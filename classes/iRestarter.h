//
//  iRestarter.h
//  iRestart
//
//  Created by EvilPenguin on 4/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface iRestarter : NSObject {
	int checker;
	int checker2;
	int checker3;
	int checker4;
	NSTimer *AutoLockTimer;
	NSTimer *RestartTimer;
	NSTimer *RespringTimer;
	NSTimer *ShutdownTimer;
	//NSDate *now;
}
+ (id) sharedInstance;
- (void) Restart;
- (void) Shutdown;
- (void) Respring;
- (void) AutoLock;
- (void) StartAutoLockTimer;
- (void) StartRestartTimer;
- (void) StartShutdownTimer;
- (void) StartRespringTimer;
- (void) StopTimer;
@property (nonatomic, retain) NSTimer *timer;
@end
