#ifndef CONFIG_H
#define CONFIG_H

#if __i386__
// Apple Platform i386 does not have Thread Local support
#define thread_local
#endif

// disable JSON assert
#define RAPIDJSON_ASSERT

// enable threading
#define LOTTIE_THREAD_SUPPORT

// enable logging
//#define LOTTIE_LOGGING_SUPPORT

// enable module building of image loader
//#define LOTTIE_IMAGE_MODULE_SUPPORT

// enable lottie model caching
//#define LOTTIE_CACHE_SUPPORT

#endif  // CONFIG_H
