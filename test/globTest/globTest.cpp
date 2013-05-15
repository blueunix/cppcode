#include "glob.h"
#include <ftw.h>
#include <iostream>
#include <fstream>
using namespace std;
#include <unistd.h>

static int
display_info(const char *fpath, const struct stat *sb,
              int tflag, struct FTW *ftwbuf)
{
  printf("%-3s %2d %7jd   %-40s %d %s\n",
   (tflag == FTW_D) ?   "d"   : (tflag == FTW_DNR) ? "dnr" :
   (tflag == FTW_DP) ?  "dp"  : (tflag == FTW_F) ?   "f" :
   (tflag == FTW_NS) ?  "ns"  : (tflag == FTW_SL) ?  "sl" :
   (tflag == FTW_SLN) ? "sln" : "???",
   ftwbuf->level, (intmax_t) sb->st_size,
   fpath, ftwbuf->base, fpath + ftwbuf->base);
   
  return 0;           /* To tell nftw() to continue */
}




void printDir(const char *dir)
{
  int flags = 0;
  nftw(dir,display_info, 20, flags);
}
int main(void)
{
  ofstream io("result.txt");
  glob_t globbuf;
  globbuf.gl_offs = 2;
  glob("*.cpp", GLOB_DOOFFS, NULL, &globbuf);
  glob("../*.c", GLOB_DOOFFS | GLOB_APPEND, NULL, &globbuf);
  glob("../*Test/*.cpp", GLOB_DOOFFS | GLOB_APPEND, NULL, &globbuf);
  cout << "print begin" << endl;
  cout << "paht number is " << globbuf.gl_pathc  << endl;
  size_t i = 2;
  for(;i < globbuf.gl_pathc;i++)
  {
    
    cout << globbuf.gl_pathv[i] << endl;
    //cout << "length is " << strlen(globbuf.gl_pathv[i]) << endl;
    io.write(globbuf.gl_pathv[i], strlen(globbuf.gl_pathv[i]));
    io << endl;
  }
  io.close();
  cout << "print end" << endl; 
  
  printDir("../../");
  //globbuf.gl_pathv[0] = "ls";
  //globbuf.gl_pathv[1] = "-l";
  //execvp("ls", &globbuf.gl_pathv[0]);
  
  //globfree(&globbuf);
  

}  


