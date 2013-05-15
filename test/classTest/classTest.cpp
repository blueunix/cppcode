class node
{
  public:
    node(int i);
    ~node();
    static node* root;
    static void insert(int x);
    static void printtree(node* ptr);
  private:  
    node* left;
    node* right;
    int value;
};


node* node::root =0;
node::node(int x)
{
  value = x;
  left = right = 0;
}  

void node::insert(int x)
{

}

void printtree(node* ptr)
{


} 


int main(void)
{

  return 0;
}  
