#include <iostream>
#include "staticlib.h"

using namespace std;

int main(int argc, char**argv)
{
	cout << "Hello From main()!" << endl;
	
	StaticFoo();

	cout << "one = " << one << endl;
	
	cout << "SomeClass::x = " << SomeClass::x << endl;
	
}