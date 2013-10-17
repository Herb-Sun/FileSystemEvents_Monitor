//
//  Monitor.h
//  DirectoryModificationMonitoring
//
//  Created by Gregory Luskin on 10/16/13.
//  Copyright (c) 2013 gluskin. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreServices/CoreServices.h>

@interface Monitor : NSObject

// See .m for descriptions
@property FSEventStreamRef stream;
@property CFStringRef mypath;
@property NSString *monitorData;

- (id) init;
- (NSString *)SelectDirectory ;

@end
