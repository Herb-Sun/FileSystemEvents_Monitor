//
//  Monitor.m
//  FileSystemMonitor
//
//  Created by Gregory Luskin on 10/16/13.
//  Copyright (c) 2013 gluskin. All rights reserved.
//

#import "Monitor.h"

@implementation Monitor

//Synthesize File System Events Stream and Path
@synthesize stream = _stream;
@synthesize mypath = _mypath;

// Synthesize the string to hold all the File System Monitor
// that will be displayed in the xib NSTextField.
@synthesize monitorData = _monitorData;

- (id) init
{
    if ( self = [super init] )
    {
        //Call SelectDirctory To Allow User To Select The Directory To Monitor
        NSString *userPath = [self SelectDirectory];
        
        //Update Monitor in xib
        _monitorData = [NSString stringWithFormat:@"Begin File Systems Monitor of: %@", userPath];
        _monitorData = [_monitorData stringByAppendingString:@"\n--------------------------------------\n\n"];
        
        //Creates The Path Array For User-Selected Directory
        NSArray *pathArray = [NSArray arrayWithObject:userPath];
        
        //Time After System Event Notification to Respond
        CFAbsoluteTime latency = 3.0;
        
        //Store reference to monitor for callbackfunction
        void *monitorRef = (__bridge void *)self;
        FSEventStreamContext reference = {0, monitorRef, NULL, NULL, NULL};
        
        //Creates The Stream & Calls 
        _stream = FSEventStreamCreate(NULL,
                                     &processEvent,
                                     &reference,
                                     (__bridge CFArrayRef)pathArray,
                                     kFSEventStreamEventIdSinceNow,
                                     latency,
                                     kFSEventStreamCreateFlagFileEvents
                                     );
        FSEventStreamScheduleWithRunLoop(_stream, CFRunLoopGetCurrent(),         kCFRunLoopDefaultMode);
        FSEventStreamStart(_stream);
        
    }
    return self;
}

//////////////////////////////////////////////////////
//                                                  //
//    PROCESSES THE FSEventStream Notifications     //
//                                                  //
//////////////////////////////////////////////////////
void processEvent(
                ConstFSEventStreamRef streamRef,
                void *clientCallBackInfo,
                size_t numEvents,
                void *eventPaths,
                const FSEventStreamEventFlags eventFlags[],
                const FSEventStreamEventId eventIds[])
{
    int i;
    char **paths = eventPaths;
    Monitor *mon = (__bridge Monitor *)clientCallBackInfo;
    
    for (i=0; i<numEvents; i++)
    {
        
        //////////////////////////////////////////////////////
        //        HANDLES ALL FILE-TYPE EVENTS              //
        //////////////////////////////////////////////////////
        if(eventFlags[i] & kFSEventStreamEventFlagItemIsFile){
            if(eventFlags[i]  & kFSEventStreamEventFlagItemCreated){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was created.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemRemoved){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was removed.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemInodeMetaMod){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had Inode Meta Modifications.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemRenamed){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was renamed.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemModified){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was modified.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemFinderInfoMod){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had finder info modifications.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemChangeOwner){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had ownership change.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemXattrMod){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The file "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had X attribute modifications.\n"];
                //Do As Needed
            }
        }
        //////////////////////////////////////////////////////
        //        HANDLES ALL DIRECTORY EVENTS              //
        //////////////////////////////////////////////////////
        else if(eventFlags[i]  & kFSEventStreamEventFlagItemIsDir){
            if(eventFlags[i]  & kFSEventStreamEventFlagItemCreated){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was created.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemRemoved){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was removed.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemInodeMetaMod){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had Inode Meta Modifications.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemRenamed){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was renamed.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemModified){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" was modified.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemFinderInfoMod){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had finder info modifications.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemChangeOwner){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had ownership change.\n"];
                //Do As Needed
            }
            else if(eventFlags[i]  & kFSEventStreamEventFlagItemXattrMod){
                mon.monitorData = [mon.monitorData stringByAppendingString:@"- The directory "];
                mon.monitorData = [mon.monitorData stringByAppendingString:[NSString stringWithUTF8String:paths[i]]];
                mon.monitorData = [mon.monitorData stringByAppendingString:@" had X attribute modifications.\n"];
                //Do As Needed
            }
        }
    }
}


//
//
// Prompts user with a file/directory browser. No files are allowed to be selected so user must select a directory
//
//
- (NSString *)SelectDirectory {
    NSOpenPanel *directoryBrowser = [NSOpenPanel openPanel];
    [directoryBrowser setCanChooseFiles:NO];
    [directoryBrowser setCanChooseDirectories:YES];
    [directoryBrowser setAllowsMultipleSelection:NO];
    
    if ([directoryBrowser runModal] != NSFileHandlingPanelOKButton) return nil;
    return [[[directoryBrowser URLs] lastObject] path];
}

@end
