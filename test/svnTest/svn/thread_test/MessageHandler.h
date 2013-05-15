#ifndef _MESSAGE_HANDLER_H
#define _MESSAGE_HANDLER_H
class MessageHandler
{
  public:
    MessageHandler();
    virtual ~MessageHandler();
    virtual HandleMessage(Message*)
};

#endif
