#include<iostream.h>
#include<string.h>
istream & skipchar(istream &stream)
{
  int i;
  char c;
  for(i=0;i<5;i++) stream>>c;
  return stream;
}
main()
{
  char str[80];
  cout<<"Enter some characters:";
  cin>>skipchar>>str;
  cout<<str<<'\n';
  return 0;
}
