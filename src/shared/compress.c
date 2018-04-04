/**
*  miniSphere JavaScript game engine
*  Copyright (c) 2015-2018, Fat Cerberus
*  All rights reserved.
*
*  Redistribution and use in source and binary forms, with or without
*  modification, are permitted provided that the following conditions are met:
*
*  * Redistributions of source code must retain the above copyright notice,
*    this list of conditions and the following disclaimer.
*
*  * Redistributions in binary form must reproduce the above copyright notice,
*    this list of conditions and the following disclaimer in the documentation
*    and/or other materials provided with the distribution.
*
*  * Neither the name of miniSphere nor the names of its contributors may be
*    used to endorse or promote products derived from this software without
*    specific prior written permission.
*
*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
*  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
*  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
*  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
*  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
*  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
*  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
*  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
*  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
*  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
*  POSSIBILITY OF SUCH DAMAGE.
**/

#include "compress.h"

#include <stdlib.h>
#include <zlib.h>

void*
z_deflate(const void* data, size_t size, int level, size_t *out_output_size)
{
	static const uInt CHUNK_SIZE = 65536;

	Bytef*       buffer = NULL;
	int          flush_flag = Z_NO_FLUSH;
	int          result;
	Bytef*       new_buffer;
	int          num_chunks = 0;
	size_t       out_size;
	z_stream     z;

	memset(&z, 0, sizeof(z_stream));
	z.next_in = (Bytef*)data;
	z.avail_in = (uInt)size;
	if (deflateInit(&z, level) != Z_OK)
		goto on_error;
	do {
		if (z.avail_out == 0) {
			if (!(new_buffer = realloc(buffer, ++num_chunks * CHUNK_SIZE)))
				goto on_error;
			z.next_out = new_buffer + (num_chunks - 1) * CHUNK_SIZE;
			z.avail_out = CHUNK_SIZE;
			buffer = new_buffer;
		}
		result = deflate(&z, flush_flag);
		if (z.avail_out > 0)
			flush_flag = Z_FINISH;
	} while (result != Z_STREAM_END);
	out_size = num_chunks * CHUNK_SIZE - z.avail_out;
	deflateEnd(&z);

	// create a byte array from the deflated data
	*out_output_size = out_size;
	return buffer;

on_error:
	deflateEnd(&z);
	free(buffer);
	return NULL;
}

void*
z_inflate(const void* data, size_t size, size_t max_inflate, size_t *out_output_size)
{
	Bytef*   buffer = NULL;
	uInt     chunk_size;
	int      flush_flag = Z_NO_FLUSH;
	size_t   inflated_size;
	Bytef*   new_buffer;
	size_t   num_chunks = 0;
	int      result;
	z_stream z;

	memset(&z, 0, sizeof(z_stream));
	z.next_in = (Bytef*)data;
	z.avail_in = (uInt)size;
	if (inflateInit(&z) != Z_OK)
		goto on_error;
	chunk_size = max_inflate != 0 ? (uInt)max_inflate : 65536;
	do {
		if (z.avail_out == 0) {
			if (buffer != NULL && max_inflate > 0)
				goto on_error;  // inflated data exceeds maximum size
			if (!(new_buffer = realloc(buffer, ++num_chunks * chunk_size + 1)))
				goto on_error;
			z.next_out = new_buffer + (num_chunks - 1) * chunk_size;
			z.avail_out = chunk_size;
			buffer = new_buffer;
		}
		if ((result = inflate(&z, flush_flag)) == Z_DATA_ERROR)
			goto on_error;
		if (z.avail_out > 0)
			flush_flag = Z_FINISH;
	} while (result != Z_STREAM_END);
	inflated_size = num_chunks * chunk_size - z.avail_out;
	buffer[inflated_size] = '\0';  // handy NUL terminator
	inflateEnd(&z);

	// create a byte array from the deflated data
	*out_output_size = inflated_size;
	return buffer;

on_error:
	inflateEnd(&z);
	free(buffer);
	return NULL;
}