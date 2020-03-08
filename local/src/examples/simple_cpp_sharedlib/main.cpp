#include <iostream>
#include "sharedlib.h"

using namespace std;

int main(int argc, char**argv)
{
	cout << "Hello From main()!" << endl;
	
	SharedFoo();

	cout << "one = " << one << endl;
	
	cout << "SomeClass::x = " << SomeClass::x << endl;
	
}