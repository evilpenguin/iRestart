//
//  iRestarter.m
//  iRestart
//
//  Created by EvilPenguin on 4/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "iRestarter.h"

static iRestarter *sharedInstance;

@implementation iRestarter
@synthesize timer;

+ (id) sharedInstance {
	if (!sharedInstance){
		sharedInstance = [[iRestarter alloc] init];
	}
	return sharedInstance;
}

- (void) Restart {
	[[UIApplication sharedApplication] _rebootNow];
}	

- (void) Shutdown {
	[[UIApplication sharedApplication] _powerDownNow];
}

- (void) Respring {
	[[UIApplication sharedApplication] relaunchSpringBoard];
}

- (void) AutoLock {
	[[UIApplication sharedApplication] autoLock];
}

- (void) StartAutoLockTimer {
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.irestart.plist"];
	NSString *AutoLockHours = [plistDict objectForKey:@"AutoLockHours"];
	NSNumber *AutoLockMinutes = [plistDict objectForKey:@"AutoLockMinutes"];
	id AutoEnable = [plistDict objectForKey:@"AutoEnable"];
	if (AutoEnable ? [AutoEnable boolValue] : TRUE) {
		//This Section is for AutoLock
		long long AutoHours		 = ([AutoLockHours doubleValue] * 60) * 60;
		long long AutoMinutes	 = ([AutoLockMinutes doubleValue] * 60);
		long long AutoTimerTotal = AutoMinutes + AutoHours;
		if (AutoTimerTotal == 0) {
			UIAlertView *BadValue = [[UIAlertView alloc] initWithTitle:@"Invalid or empty number for Autolock timer" message:@"These values will not take anything other than a number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[BadValue show];
			[BadValue release];
			NSLog(@"Autolock has a zero value");
		}
		else {
			NSDate *AutoNow = [NSDate date];
			NSLog(@"Date: %@", AutoNow);
			NSLog(@"Hours: %u", AutoLockHours);
			NSLog(@"Minutes: %u", AutoLockMinutes);
			NSLog(@"AutoLock in: %u seconds", AutoTimerTotal);
			UIAlertView *TimerOn = [[UIAlertView alloc] initWithTitle:@"Autolock Started" message:@"The Timer has started!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[TimerOn show];
			[TimerOn release];
			checker++;
			AutoLockTimer = [NSTimer scheduledTimerWithTimeInterval:AutoTimerTotal target:self selector:@selector(AutoLock) userInfo:nil repeats:NO];
		}
	}
	[plistDict release];
}

- (void) StartRestartTimer {
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.irestart.plist"];
	NSNumber *RestartLockHours	 = [plistDict objectForKey:@"RestartLockHours"];
	NSNumber *RestartLockMinutes = [plistDict objectForKey:@"RestartLockMinutes"];
	id RestartEnable = [plistDict objectForKey:@"RestartEnable"];
	if (RestartEnable ? [RestartEnable boolValue] : TRUE) {
		long long RestartMinute		= ([RestartLockMinutes doubleValue] * 60);
		long long RestartHour		= ([RestartLockHours doubleValue] * 60) * 60;
		long long RestartTimerTotal = RestartMinute + RestartHour;
		if (RestartTimerTotal == 0) {
			UIAlertView *BadValue = [[UIAlertView alloc] initWithTitle:@"Invalid or empty number for Restart timer" message:@"These values will not take anything other than a number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[BadValue show];
			[BadValue release];
			NSLog(@"Restart has a zero value");
		}
		else {
			NSDate *RestartNow = [NSDate date];
			NSLog(@"Date: %@", RestartNow);
			NSLog(@"Hours: %u", RestartHour);
			NSLog(@"Minutes: %u", RestartMinute);
			NSLog(@"Restart in: %u seconds", RestartTimerTotal);
			UIAlertView *TimerOn = [[UIAlertView alloc] initWithTitle:@"Restart Started" message:@"The Timer has started!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[TimerOn show];
			[TimerOn release];
			checker2++;
			RestartTimer = [NSTimer scheduledTimerWithTimeInterval:RestartTimerTotal target:self selector:@selector(Restart) userInfo:nil repeats:NO];
		}
	}
	[plistDict release];
}

- (void) StartShutdownTimer {
	NSMutableDictionary *plistDict	= [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.irestart.plist"];
	NSNumber *ShutdownLockHours		= [plistDict objectForKey:@"ShutdownLockHours"];
	NSNumber *ShutdownLockMinutes	= [plistDict objectForKey:@"ShutdownLockMinutes"];
	id ShutdownEnable = [plistDict objectForKey:@"ShutdownEnable"];
	if (ShutdownEnable ? [ShutdownEnable boolValue] : TRUE) {
		long long ShutdownMinute		= ([ShutdownLockMinutes doubleValue] * 60);
		long long ShutdownHour			= ([ShutdownLockHours doubleValue] * 60) * 60;
		long long ShutDownTimerTotal	= ShutdownMinute + ShutdownHour;
		if (ShutDownTimerTotal == 0) {
			UIAlertView *BadValue = [[UIAlertView alloc] initWithTitle:@"Invalid or empty number for Shutdown timer" message:@"These values will not take anything other than a number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[BadValue show];
			[BadValue release];
			NSLog(@"Shutdown has a zero value");
		}
		else {
			NSDate *ShutdownNow = [NSDate date];
			NSLog(@"Date: %@", ShutdownNow);
			NSLog(@"Hours: %u", ShutdownHour);
			NSLog(@"Minutes: %u", ShutdownMinute);
			NSLog(@"Shutdown in: %u seconds", ShutDownTimerTotal);
			UIAlertView *TimerOn = [[UIAlertView alloc] initWithTitle:@"Shutdown Started" message:@"The Timer has started!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[TimerOn show];
			[TimerOn release];
			checker3++;
			ShutdownTimer = [NSTimer scheduledTimerWithTimeInterval:ShutDownTimerTotal target:self selector:@selector(Shutdown) userInfo:nil repeats:NO];
		}
	}
	[plistDict release];
}

- (void) StartRespringTimer {
	NSMutableDictionary *plistDict	= [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.irestart.plist"];
	NSNumber *RespringLockHours		= [plistDict objectForKey:@"RespringLockHours"];
	NSNumber *ResrpingLockMinutes	= [plistDict objectForKey:@"ResrpingLockMinutes"];
	id RespringEnable				= [plistDict objectForKey:@"RespringerEnable"];
	if (RespringEnable ? [RespringEnable boolValue] : TRUE) {
		long long RespringMinute		= ([ResrpingLockMinutes doubleValue] * 60);
		long long RespringHour			= ([RespringLockHours doubleValue] * 60) * 60;
		long long RespringimerTotal		= RespringMinute + RespringHour;
		if (RespringimerTotal == 0) {
			UIAlertView *BadValue = [[UIAlertView alloc] initWithTitle:@"Invalid or empty number for Respring timer" message:@"These values will not take anything other than a number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[BadValue show];
			[BadValue release];
			NSLog(@"Respring has a zero value");
		}
		else {
			NSDate *RespringNow = [NSDate date];
			NSLog(@"Date: %@", RespringNow);
			NSLog(@"Hours: %u", RespringHour);
			NSLog(@"Minutes: %u", RespringMinute);
			NSLog(@"Respring in: %u seconds", RespringimerTotal);
			UIAlertView *TimerOn = [[UIAlertView alloc] initWithTitle:@"Respring Started" message:@"The Timer has started!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[TimerOn show];
			[TimerOn release];
			checker4++;
			RespringTimer = [NSTimer scheduledTimerWithTimeInterval:RespringimerTotal target:self selector:@selector(Respring) userInfo:nil repeats:NO];
		}
	}
}

- (void) StopTimer {
	NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.irestart.plist"];
	id Enable				= [plistDict objectForKey:@"iRestart"];
	id AutoEnable			= [plistDict objectForKey:@"AutoEnable"];
	id RestartEnable		= [plistDict objectForKey:@"RestartEnable"];
	id ShutdownEnable		= [plistDict objectForKey:@"ShutdownEnable"];
	id RespringEnable		= [plistDict objectForKey:@"RespringerEnable"];
	if (Enable ? [Enable boolValue] : TRUE) {
		/*if (AutoEnable ? [AutoEnable boolValue] : FALSE || RestartEnable ? [RestartEnable boolValue] : FALSE || ShutdownEnable ? [ShutdownEnable boolValue] : FALSE || RespringEnable ? [RespringEnable boolValue] : FALSE) {
			UIAlertView *Nada = [[UIAlertView alloc] initWithTitle:@"iRestart has nothing to do!" message:@"Please go to the Settings application and choose what you want iRestart to handle." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[Nada show];
			[Nada release];
		}*/
		UIAlertView *TimerOff = [[UIAlertView alloc] initWithTitle:@"iRestart Stopped" message:@"The Timer has stopped!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[TimerOff show];
		[TimerOff release];
		if (AutoEnable ? [AutoEnable boolValue] : TRUE && checker == 1) {
			checker = 0;
			NSLog(@"Timer AutoLock has stopped");
			[AutoLockTimer invalidate];
			AutoLockTimer = nil;
		}
		if (RestartEnable ? [RestartEnable boolValue] : TRUE && checker2 == 1) {
			checker2 = 0;
			NSLog(@"Timer Restart has stopped");
			[RestartTimer invalidate];
			RestartTimer = nil;
		}
		if (ShutdownEnable ? [ShutdownEnable boolValue] : TRUE && checker3 == 1) {
			checker3 = 0;
			NSLog(@"Timer Shutdown has stopped");
			[ShutdownTimer invalidate];
			ShutdownTimer = nil;
		}
		if (RespringEnable ? [RespringEnable boolValue] : TRUE && checker4 ==1) {
			checker4 = 0;
			NSLog(@"Timer Respring has stopped");
			[RespringTimer invalidate];
			RespringTimer = nil;
		}
	}
	[plistDict release];
}

@end