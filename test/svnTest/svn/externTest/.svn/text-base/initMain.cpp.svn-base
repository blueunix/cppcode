#include <pthread.h>
#include <errno.h>
#include <assert.h>
#include <stdio.h>
#include <iostream>
#include "initMain.h"
using namespace std;

extern "C" void init_main()
{
  printf("here is the init_main()\n");


}

//MessageQueue queue;

static void* get_entry(void *ptr)
{
  
  cout << "thread2 ,get_entry" << endl; 
  ShortMsgHandler* handler = static_cast<ShortMsgHandler*>(ptr);
  if(handler)
  {
    //handler->setQueue(&queue);
    for(;;)
    {  
      //cout << "thread2 get" << endl;
      handler->handleMessage();
    }
  }
  else
  {
    assert(0);
  }  
  return 0;
}  

static void* put_entry(void* ptr)
{
  cout << "thread1,put_entry" << endl;
  ShortMsgHandler* handler = static_cast<ShortMsgHandler*>(ptr);
  if(handler)
  { 
    //handler->setQueue(&queue);
    static unsigned int count = 0;
    WorkObj* obj = new WorkObj;
    //Message msg[50];
    for(;;)
    {
      //cout << "thread1 put" << endl; 
      Message * msg = new Message(Message::SHORTMSG, obj, count);
      if(msg)
        handler->putMessage(msg);
      else 
        cout << "create Message error" << endl;
      count++;
    }

    delete obj;
  }
  else
  {
    cout << "not get ShortMsgHandler" << endl;
    assert(0);
  }
  
  return 0;
}  


initMain::initMain()
{
  cout << "construct initMain()" << endl;
  pthread_t pid0;
  pthread_t pid1;
  pthread_t pid2;

  MessageQueue* queue1 = new MessageQueue;
#if 0
ShortMsgHandler* handler1 = new ShortMsgHandler(queue1);

ShortMsgHandler* handler2 = new ShortMsgHandler(queue1);
#endif
  
  
  ShortMsgHandler* handler1 = new ShortMsgHandler();
  handler1->setQueue(queue1);
  ShortMsgHandler* handler2 = new ShortMsgHandler();
  handler2->setQueue(queue1);
  
  
  
  
  //int ret0 = pthread_create(&pid0,NULL,put_entry,handler1);
  
  int ret1 = pthread_create(&pid1,NULL,put_entry,handler1);
  if(0 != ret1)
    cout << "thread1 create error " << endl;
  
  int ret2 = pthread_create(&pid2,NULL,get_entry,handler2);
    if(0 != ret2)
      cout << "thread2 create error " << endl;
  //it will cause segmentation fault while
  //thread is running we delete this handler
  //delete handler1;
  //delete handler2;

}  



void initMain::pushInit()
{
  strMap.insert(std::make_pair("ShortMsgHandler",new ShortMsgHandler));
  strMap.insert(std::make_pair("sonInitMain2",new ShortMsgHandler));


}  

initMain::~initMain()
{
  cout << "destruct initMain()" << endl;
#if 0
  MapStr2Class:: iterator it = strMap.begin();
  for(;it != strMap.end();it++)
  {
    delete it->second;
  }  
#endif
} 

void initMain::InstanceOperation()
{
  MapStr2Class:: iterator it = strMap.begin();
  for(;it != strMap.end();it++)
  {
    (it->second)->handleMessage();
  }  

}  


sonInitMain1::sonInitMain1(const char* str)
  :initMain(),sonInit(str)
{
  cout << "construct sonInitMain1" << endl;

}   


sonInitMain1::~sonInitMain1()
{
  cout << "destruct sonInitMain1" << endl;

}

sonInitMain2::sonInitMain2():initMain()
{
cout << "construct sonInitMain2" << endl;


}

sonInitMain2::~sonInitMain2()
{
cout << "destruct sonInitMain22" << endl;



}  

//##############################################
//
//
//#############################################

Handler::Handler()
{
  cout << "construct Handler" << endl;
  //sem_init(&getSem,0,0);
  //sem_init(&putSem,0,1);
  //pthread_mutex_init(&mutex, NULL);
}  


Handler::Handler(MessageQueue* msgQ):queue(msgQ)
{
 cout << "construct Handler" << endl;
}
  
Handler::~Handler()
{
  cout << "destruct Handler" << endl;
  if(queue)
    delete queue;
  
}  

//##############################################
//
//
//##############################################
ShortMsgHandler::ShortMsgHandler():Handler()
{
  cout << "construct ShortMsgHandler" << endl;

}

ShortMsgHandler::ShortMsgHandler(MessageQueue *quque):Handler(queue)
{
    cout << "constrcut ShortMsgHanlder with MessageQueue" << endl;

}                                                      
ShortMsgHandler::~ShortMsgHandler()
{
  cout << "destruct ShortMsgHandler" << endl;
}

void ShortMsgHandler::handleMessage()
{
  Message* msg = queue->get();
  if(NULL != msg)
  {
    WorkObj* obj = msg->getObj();
    obj->handle(msg);
  }  

}

void ShortMsgHandler::putMessage(Message* msg)
{

  queue->push(msg);
}  

//########################################
//
//
//#######################################
Message::Message():type(MAX_MSG_NUM),obj(NULL),count(0),next(NULL)
{
  cout << "construct Message" << endl;
  
}  

Message::Message(MSG_TYPE _type,WorkObj* _obj, unsigned int _count):type(_type),obj(_obj),count(_count),next(NULL)
{
  //cout << "construct Message,message type is" << type <<",count is "<< count  << endl;
}

Message::~Message()
{
  cout << "destruct Message" << endl;

}  




//#########################################
//
//
//#########################################
MessageQueue::MessageQueue():first(NULL),count(0)
{
  cout << "construct MessageQueue" << endl;
  if(sem_init(&getSem,0,0) == -1)
    cout << "sem_init error" << endl;
  sem_init(&putSem,0,1);
  pthread_mutex_init(&mutex,NULL);
}

MessageQueue::~MessageQueue()
{
  cout << "destruct MessageQueue" << endl;
  
  //TO DO ,DELETE ALL MESSAGE
  sem_destroy(&getSem);
  sem_destroy(&putSem);
  pthread_mutex_destroy(&mutex);

}

void MessageQueue::push(Message* _msg)
{
  cout << "" << endl;
  int s = 0;
  while((s = sem_wait(&putSem)) == -1 && errno == EINTR)
    continue;
  pthread_mutex_lock(&mutex);

  if(NULL == first)
    first = _msg;
  else
  {  
    _msg->setNext(first);
    first = _msg;
  }  
  cout << "MessageQueue::push msg"<< _msg->getCount() << " push "   << endl;
  pthread_mutex_unlock(&mutex);
  sem_post(&getSem);
}

Message* MessageQueue::get()
{
  Message* msg = NULL;
  int s = 0;
  while((s = sem_wait(&getSem)) == -1 && errno == EINTR)
    continue;
  
  cout << "MessageQueue acquire getSem" << endl;
  pthread_mutex_lock(&mutex);


  if(first != NULL)
  {
    msg = first;
    first = first->getNext();

  }  
  pthread_mutex_unlock(&mutex);
  sem_post(&putSem);
  return msg;
}


//########################################
//
//
//########################################
WorkObj::WorkObj()
{
  cout << "constrcut WorkObj" << endl;
}

WorkObj::~WorkObj()
{
  cout << "destruct WorkObj" << endl;

}


void WorkObj::handle(Message* msg)
{
  cout << "Message "<< msg->getCount() << "handled by WorkObj" << endl;
  delete msg;
}  
