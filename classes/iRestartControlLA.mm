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
#include "iRestartControl.h"

@interface Activation : NSObject<LAListener> {
@private
	
}
@end

@implementation Activation

static BOOL isDisplayed2 = YES; 

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	NSLog(@"iRestart has loaded the view");
	UIImage *StartImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Pad-Start-Button.png"];
	UIImageView *StartImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 5, 5)];
	[StartImageMain setImage:StartImage];
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.irestart.plist"];
	id EnableView		= [plistDict objectForKey:@"EnableView"];
	if (EnableView ? [EnableView boolValue] : TRUE) {
		NSLog(@"iRestart View is showing!");
		if (isDisplayed2) {
			isDisplayed2 = NO;
			//[[UIApplication sharedApplication] addStatusBarImageNamed:StartImageMain];
			[[iRestartControl sharedInstance] LoadiRestart];
		}
		else {
			isDisplayed2 = YES;
			//[[UIApplication sharedApplication] removeStatusBarImageNamed:StartImage];
			[[iRestartControl sharedInstance] Close];
		}
	}
	[plistDict release];
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event {
}

+ (void)load {
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.nakedproductions.irestartView"];
}


@end 
extern "C" void ActivationInitialize() {	
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	[pool release];
}