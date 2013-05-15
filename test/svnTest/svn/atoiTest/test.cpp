#include <iostream>
#include <vector>
#include <string>
using namespace std;

string addOp(vector<int>&a, const vector<int>&b)
{
  unsigned int num;
  unsigned int mod;
  unsigned int bit=0;
  string str;
    int  index =a.size()-1;
  for(;index>=0;index--)
  {
    num = a[index] + b[index];
    if(num >=10)
    { 
      num = num % 10;
      if(index >=1)
      a[index-1]+= 1;
      else
        bit = 1;

  
    }
    num +='0';
cout<<"the num is"<<num<<endl;
cout<<"the index is"<<index<<endl;   
str.insert(str.begin(),num);
  }
    if(bit)
    {
      bit += '0';
      str.insert(str.begin(),bit);
    }
  
  return str;
}  


int main(void)
{
  vector<int> left;
  vector<int> right;
  left.insert(left.begin(),7);
  left.insert(left.begin(),7);
  left.insert(left.begin(),7);
  left.insert(left.begin(),7);
  left.insert(left.begin(),7);
  
  right.insert(right.begin(),5);
  right.insert(right.begin(),4);
  right.insert(right.begin(),0);
  right.insert(right.begin(),0);
  right.insert(right.begin(),1);
  string str = addOp(left,right);
  
  cout <<"string is " << str<< endl;

}  
