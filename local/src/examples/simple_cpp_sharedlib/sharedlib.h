
#if defined _WIN32
// ===============================================================
// Windows
// ===============================================================
	#ifdef SO_BUILDING
		#define SO_PUBLIC __declspec(dllexport)
		#define SO_PRIVATE
	#else
		#define SO_PUBLIC __declspec(dllimport)
		#define SO_PRIVATE
	#endif

#else
// ===============================================================
// Linux
// ===============================================================
	#ifdef SO_BUILDING
		#define SO_PUBLIC __attribute__ ((visibility ("default")))
		#define SO_PRIVATE __attribute__ ((visibility ("hidden")))
	#else
		#define SO_PUBLIC
		#define SO_PRIVATE
	#endif
#endif

// NOTE: On windows SO_PUBLIC is only required in the .h file.  On Linux
// SO_PUBLIC is only required in the .cpp files.  You definitely want
// to use it in both places for it to work on both platforms.

SO_PUBLIC void SharedFoo();
 
extern SO_PUBLIC int one;

class SO_PUBLIC SomeClass
{
public:
	static int x;
};

