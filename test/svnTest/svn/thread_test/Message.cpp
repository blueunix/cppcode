#include "Message.h"

Message::Message(string& s,MessageHandler* p):str(s),pHandler(p)
{


} 


Message::~Message()
{

}

void Message::work()
{
  pHandler->HandleMessage(this);
  MessageAction();  
}

string Message getString()
{
  return str;

}  
  
void Message::setNext(Message* msg)
{
  next = msg;
}

Message* getNext()
{
  return next;
}  
