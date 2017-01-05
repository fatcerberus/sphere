#ifndef CELL__FS_H__INCLUDED
#define CELL__FS_H__INCLUDED

typedef struct fs fs_t;

fs_t*     fs_new      (const char* origin_dir, const char* game_dir);
void      fs_free     (fs_t* fs);
int       fs_fcopy    (const fs_t* fs, const char* destination, const char* source, int overwrite);
FILE*     fs_fopen    (const fs_t* fs, const char* filename, const char* mode);
void*     fs_fslurp   (const fs_t* fs, const char* filename, size_t* out_size);
vector_t* fs_list_dir (const fs_t* fs, const char* dirname);
int       fs_stat     (const fs_t* fs, const char* filename, struct stat* p_stat);

#endif // CELL__FS_H__INCLUDED
