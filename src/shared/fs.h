/**
 *  miniSphere JavaScript game engine
 *  Copyright (c) 2015-2020, Fat Cerberus
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

#ifndef SPHERE__FS_H__INCLUDED
#define SPHERE__FS_H__INCLUDED

#include <stddef.h>
#include <stdbool.h>
#include <sys/stat.h>
#include "path.h"

typedef struct fs fs_t;

typedef void* (* fs_fslurp_impl_t)   (fs_t* fs, const char* pathname, size_t *out_size);
typedef int   (* fs_stat_impl_t)     (fs_t* fs, const char* pathname, struct stat *out_stat);

fs_t*   fs_new          (const char* prefixes, void* userdata);
void    fs_free         (fs_t* it);
void    fs_define_alias (fs_t* it, char prefix, const char* base_dir);
void    fs_on_fslurp    (fs_t* it, fs_fslurp_impl_t impl);
void    fs_on_stat      (fs_t* it, fs_stat_impl_t impl);
void*   fs_user_ptr     (const fs_t* it);
bool    fs_dir_exists   (fs_t* it, const char* filename);
bool    fs_file_exists  (fs_t* it, const char* filename);
void*   fs_fslurp       (fs_t* it, const char* filename, size_t *out_size);
path_t* fs_pathname     (fs_t* it, const char* filename, const char* base_dir);
int     fs_stat         (fs_t* it, const char* filename, struct stat *out_stat);

#endif // SPHERE__FS_H__INCLUDED
