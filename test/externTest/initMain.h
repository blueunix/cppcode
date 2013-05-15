#ifndef _INIT_MAIN
#define _INIT_MAIN
#include <semaphore.h>
#include <pthread.h> 
#include <iostream>
#include <string>
#include <map>
using namespace std;

class Handler;
class initMain
{
  public:
    initMain();
    initMain(const char*);
    virtual ~initMain();
    
    void pushInit();
    void  InstanceOperation();
    virtual void InstantOperation(){} 
    void doSomething()
    {
      cout << "do something else" << endl;
    }  

    //static void* thread_entry(void*);

  private:  
    typedef map<string,Handler*> MapStr2Class;
    MapStr2Class strMap;
    string strName;
    


};

class sonInitMain1: public initMain
{
  public:
    sonInitMain1(const char *);
    ~sonInitMain1();
    void InstantOperation()
    {
      cout << "this is sonInitMain1's instant operation" << endl;
    
    }  

  private:  
    string sonInit;

};                   
class sonInitMain2: public initMain
{
  public:
    sonInitMain2();
    ~sonInitMain2();
    void InstantOperation()
    {
      cout << "this is sonInitMain2's instant operation" << endl;
    }  
  private:  

};                    

//#########################################
//
//
//#########################################
class MessageQueue;
class Message;
class Handler
{
  public:
    Handler();
    Handler(MessageQueue*);
    virtual ~Handler();
    virtual void handleMessage()= 0;
    virtual void putMessage(Message*) = 0;
    void setQueue(MessageQueue *_queue) {queue = _queue;}
  //private:
    
    MessageQueue *queue;
};



//#########################################
//
//
//#########################################
class ShortMessage;
class ShortMsgHandler: public Handler
{
  public:
    ShortMsgHandler();
    ShortMsgHandler(MessageQueue*);
    ~ShortMsgHandler();
    void handleMessage();
    void putMessage(Message* msg);
  private:  
};



//########################################
//
//
//#########################################

class WorkObj;
class Message
{
  public:
    typedef enum
    {
      LONGMSG,
      SHORTMSG,
      MAX_MSG_NUM
    }MSG_TYPE;

    Message();
    Message(MSG_TYPE _type, WorkObj* _obj , unsigned int count);
    virtual ~Message();
    void setWorkObj(WorkObj* o){obj = o;}
    WorkObj* getObj(){ return obj;}
    unsigned int getCount() { return count;}
    void setNext(Message* _next){next = _next;}
    Message* getNext(){return next;}
  private:
    
    MSG_TYPE type;
    WorkObj *obj;
    unsigned int count;
    Message* next;
};


//########################################
//
//
//#########################################
class ShortMessage:public Message
{
  public:
    ShortMessage();
    ~ShortMessage();

  private:

};                   

//########################################
//
//
//#########################################
class MessageQueue
{
  public:
    MessageQueue();
    ~MessageQueue();
    void push(Message*);
    Message* get();
    unsigned int getMsgCount(){return count;}
  //private:
    Message* first;
    unsigned int count;
    sem_t getSem;
    sem_t putSem;
    pthread_mutex_t mutex;
};

//########################################
//
//
//#########################################
class WorkObj
{
  public:
    WorkObj();
    virtual ~WorkObj();
    void handle(Message*);

  private:  

};


#endif
