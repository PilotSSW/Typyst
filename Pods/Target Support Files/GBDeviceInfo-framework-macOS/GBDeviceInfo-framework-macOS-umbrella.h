#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GBDeviceInfoTypes_OSX.h"
#import "GBDeviceInfo_OSX.h"
#import "GBDeviceInfoTypes_Common.h"
#import "GBDeviceInfo_Common.h"
#import "GBDeviceInfo.h"
#import "GBDeviceInfoInterface.h"
#import "GBDeviceInfo_Subclass.h"

FOUNDATION_EXPORT double GBDeviceInfoVersionNumber;
FOUNDATION_EXPORT const unsigned char GBDeviceInfoVersionString[];

