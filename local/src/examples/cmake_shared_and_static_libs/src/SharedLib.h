
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

SO_PUBLIC void SharedFoo();
