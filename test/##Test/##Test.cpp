using namespace std;

#define SET(name, type, value) \
      void Set##name(const type& value) \
      { \
        name = value; \
      }  
#define GET(name,type,value) \
      void Get##name(type& value) \
      { \
        value = name; \
      }
class Base
{
  public:
    Base():year(2012),month(3),day(12),hour(12),minute(0)
    {
      
    }  
    ~Base(){}
    SET(year,unsigned int,yeari)
    SET(month,unsigned int,monthi)
    SET(day,unsigned int,dayi)
    SET(hour,unsigned int,houri)
    SET(minute,unsigned int,minutei)
    
    GET(year,unsigned int,yeari)
    GET(month,unsigned int,monthi)
    GET(day,unsigned int,dayi)
    GET(hour,unsigned int,houri)
    GET(minute,unsigned int,minutei)
  private:
    unsigned int year;
    unsigned int month;
    unsigned int day;
    unsigned int hour;
    unsigned int minute;

};


int main(void)
{

return 0;
}  
