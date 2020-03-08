#include <iostream>
#include <pthread.h>


using namespace std;

static bool done = false;
void* threadMain(void *threadarg)
{
   cout << "Hello World from thread." << endl;
   done = true;
   return NULL;
}

int main()
{
	cout << "Hello World!" << endl;
	
	pthread_t thread;
	pthread_create(&thread, (pthread_attr_t*)NULL, threadMain, (void*)NULL);
	
	while(!done) {}

	return 0;
}

