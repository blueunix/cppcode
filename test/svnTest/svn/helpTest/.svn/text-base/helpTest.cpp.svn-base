#include <string.h>
#include <unistd.h>



extern "C" void show_help(void)
{
  char *b = "(" __DATE__ "" __TIME__ ")" \
             " - a light and fast webserver\n" \
             "usage:\n" \
             " -f <name>  filename of the config-file\n" \
             " -m <name>  module directory (default: )\n" \
             " -p         print the parsed config-file in internal form, and exit\n" \
  ;

  write(1,b,strlen(b));
}  

int main()
{
  show_help();
}
  
