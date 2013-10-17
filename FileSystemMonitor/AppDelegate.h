//
//  AppDelegate.h
//  FileSystemMonitor
//
//  Created by Gregory Luskin on 10/16/13.
//  Copyright (c) 2013 gluskin. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end

