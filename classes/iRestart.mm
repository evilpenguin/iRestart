//
//  iRestart.mm
//  iRestart
//
//  Created by EvilPenguin on 4/8/10.
//  Copyright Apple Inc 2010. All rights reserved.
//
//  MobileSubstrate, libsubstrate.dylib, and substrate.h are
//  created and copyrighted by Jay Freeman a.k.a saurik and 
//  are protected by various means of open source licensing.
//
// 
//
#include <substrate.h>
#include "libactivator.h"
#include "iRestarter.h"
#include "iRestartControl.h"

@interface Activations : NSObject<LAListener> {
@private
	
}
@end

@implementation Activations

static BOOL isDisplayed = YES; 

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	NSLog(@"iRestart has started/stopped!");
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.irestart.plist"];
	id Enable			= [plistDict objectForKey:@"iRestart"];
	if (Enable ? [Enable boolValue] : TRUE) {
		if (isDisplayed) {
			isDisplayed = NO;
			[[iRestarter sharedInstance] StartAutoLockTimer]; 
			[[iRestarter sharedInstance] StartRespringTimer];
			[[iRestarter sharedInstance] StartRestartTimer];
			[[iRestarter sharedInstance] StartShutdownTimer];
		}
		else {
			isDisplayed = YES;
			[[iRestarter sharedInstance] StopTimer];
		}
	}
	[plistDict release];
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event {
}

+ (void)load {
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.nakedproductions.irestart"];
}


@end 
extern "C" void iRestartInitialize() {	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

	[pool release];
}