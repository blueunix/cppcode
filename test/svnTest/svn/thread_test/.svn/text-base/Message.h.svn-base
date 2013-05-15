#ifndef _MESSAGE_H
#define _MESSAGE_H

#include <string>
#include "MessageHandler.h"

class Message
{
  public:
    Message(string s,MessageHandler *handler);
    virtual ~Message();
    virtual MessageAction() = 0; 
    string getString();
    void work();
    void setNext(Message *);
    Message* getNext();

  private:
    MessageHandler *pHandler;
    string str;
    Message * next;

};


#endif

