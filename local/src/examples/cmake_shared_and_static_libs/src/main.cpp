#include <iostream>
#include "StaticLib.h"
#include "SharedLib.h"

using namespace std;

int main(int argc, char**argv)
{
	cout << "hello world!" << endl;
	StaticFoo();
	SharedFoo();
	cout << "Mark Hodges" << endl;
}