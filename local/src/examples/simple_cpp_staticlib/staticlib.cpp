#include <iostream>
#include "staticlib.h"

using namespace std;

SO_PUBLIC int one = 1;

SO_PUBLIC void StaticFoo()
{
	cout << "Static says, \"hi\", too." << endl;
}

SO_PUBLIC int SomeClass::x = 5;