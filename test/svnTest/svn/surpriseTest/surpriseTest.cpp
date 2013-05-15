#include <iostream>
#include <stdlib.h>
using namespace std;
class AA
{
 public:
    void result()
    {
      std::cout << "Surprise?" << std::endl;
    };
};



int main()
{
    AA *p = NULL;
    p->result();
    
    ((AA *) 0)->result();
    
    system("Pause");
    return 0;
}


