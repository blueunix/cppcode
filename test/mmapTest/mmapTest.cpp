#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <iostream>
using namespace std;

int main()
{
  int fdSrc = open("mmapFile.txt",O_RDWR);  
  if(fdSrc < 0)
  {
    cout << "can not open" <<endl;
    perror("can not open"); 
  }  
  
  int fdDst = open("dstFile.txt",O_CREAT|O_RDWR|O_TRUNC,S_IRUSR|S_IWUSR);
  if(fdDst < 0)
  {
    perror("can not open dst file\n");
    exit(EXIT_FAILURE);
  }
  struct stat s;
  if(fstat(fdSrc,&s) < 0)
  {
    perror("fstat target");
    exit(EXIT_FAILURE);
  }
  
  cout << "src file size is " << s.st_size << endl;
  lseek(fdDst,s.st_size-10  ,SEEK_SET);
  
  write(fdDst,"",1);
  void * address = mmap(NULL,s.st_size,PROT_READ|PROT_WRITE,MAP_SHARED,fdSrc,0);
  
  
  if(address == (void*)-1)
  {
    cout << "mmap error" << endl;
  }
  
  void *dst = mmap(NULL,s.st_size,PROT_READ|PROT_WRITE,MAP_SHARED,fdDst,0);
  if(dst == (void*)-1)
  {
    cout << "mmap dst error" << endl;
    exit(EXIT_FAILURE);
  
  }
  char *pDst = (char*)dst;
  //pDst[0] = ' ';
  memcpy(dst,address,s.st_size);
#if 0
  char *p = (char*)address;
cout<<p[0]<<endl;
    *p = '1';
    *(p+300) = '1';
#endif
    //for(int i =0;i<100;i++)
  //{
  // cout << *p++ << endl; 
  //}


  return 0;
}  
