/*
 * =====================================================================================
 *
 *       Filename:  main1.cpp
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  12/09/12 15:54:39
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *   Organization:  
 *
 * =====================================================================================
 */

class test_jx {
public:
        test_jx(int a,int b,char* c);
        virtual ~test_jx();

private:
    /* data */
    int a;
    int b;
    char *c;
};



struct test_st
{
  int tt;
  int bb;
};

test_st tee;
tee.tt = 2;
tee.bb = 3;
ActiveDispatcher dis;
dis.start();

ActiveMethod me;
me.swap(other);
