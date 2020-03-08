#include <iostream>
#include "sharedlib.h"

using namespace std;

SO_PUBLIC int one = 1;

SO_PUBLIC void SharedFoo()
{
	cout << "Shared says, \"hi\", too." << endl;
}

SO_PUBLIC int SomeClass::x = 5;