#ifdef __OBJC__
#import <Foundation/Foundation.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "rlottie_capi.h"
#import "rlottiecommon.h"
#import "librlottie.h"

FOUNDATION_EXPORT double librlottieVersionNumber;
FOUNDATION_EXPORT const unsigned char librlottieVersionString[];

