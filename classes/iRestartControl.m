//
//  iRestartControl.m
//  iRestart
//
//  Created by Evilpenguin on 4/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "iRestartControl.h"
#include "iRestarter.h"
#import <Foundation/Foundation.h>

static iRestartControl *sharedInstance;
@implementation iRestartControl
@synthesize showsTouchWhenHighlighted;

+ (id) sharedInstance{
	if (!sharedInstance){
		sharedInstance = [[iRestartControl alloc] init];
	}
	return sharedInstance;
}


- (void)Close {
	NSLog(@"CLose The View");
	[infoWindow setHidden:YES];
}

- (void) StartAllTimer {
	[infoWindow setHidden:YES];
	[[iRestarter sharedInstance] StartAutoLockTimer]; 
	[[iRestarter sharedInstance] StartRespringTimer];
	[[iRestarter sharedInstance] StartRestartTimer];
	[[iRestarter sharedInstance] StartShutdownTimer];
}

- (void) StopTimer {
	[infoWindow setHidden:YES];
	[[iRestarter sharedInstance] StopTimer];
}

- (void) ShutdownTimer {
	[infoWindow setHidden:YES];
	[[UIApplication sharedApplication] _powerDownNow];
}

- (void) RestartTimer {
	[infoWindow setHidden:YES];
	[[UIApplication sharedApplication] _rebootNow];
}	

- (void) RespringTimer {
	[infoWindow setHidden:YES];
	[[UIApplication sharedApplication] relaunchSpringBoard];
}

- (void)LoadiRestart {
	NSMutableDictionary *Prefernces	= [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.nakedproductions.iRestart.plist"];
	id EnableView		= [Prefernces objectForKey:@"EnableView"];
	id StartButton		= [Prefernces objectForKey:@"StartButton"];
	id StopButton		= [Prefernces objectForKey:@"StopButton"];
	id RespringButton	= [Prefernces objectForKey:@"RespringButton"];
	id RestartButton	= [Prefernces objectForKey:@"RestartButton"];
	id ShutDownButton	= [Prefernces objectForKey:@"ShutdownButton"];
	
	if (EnableView ? [EnableView boolValue] : TRUE) {
		if([UIDevice instancesRespondToSelector:@selector(isWildcat)] && [[UIDevice currentDevice] isWildcat]) { 
			if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
				infoWindow		= [[UIWindow alloc] initWithFrame: CGRectMake(0, 100, 700, 100)];
				infoWindow.frame	= CGRectMake(35, 5, 700, 100);
			}
			else {
				infoWindow		= [[UIWindow alloc] initWithFrame: CGRectMake(0, 100, 700, 100)];
				infoWindow.frame	= CGRectMake(35, 915, 700, 100);
			}
			[infoWindow setWindowLevel: UIWindowLevelStatusBar + 100];
			[infoWindow makeKeyAndVisible];
			windowView		= [[UIView alloc] initWithFrame: CGRectMake(0, 0, 700, 100)];
			LoadedImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Background.png"];
			MainBackground	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 700, 100)];
			[MainBackground setImage:LoadedImage];
			[windowView addSubview:MainBackground];
		}
		else { 
			infoWindow	= [[UIWindow alloc] initWithFrame: CGRectMake(0, 100, 300, 100)];
			infoWindow.frame	= CGRectMake(10, 378, 300, 100);
			[infoWindow setWindowLevel: UIWindowLevelStatusBar + 100];
			[infoWindow makeKeyAndVisible];
			windowView		= [[UIView alloc] initWithFrame: CGRectMake(0, 0, 300, 100)];
			LoadedImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Background.png"];
			MainBackground	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 300, 100)];
			[MainBackground setImage:LoadedImage];
			[windowView addSubview:MainBackground];
		}
		//CGContextRef contextRollUpBottom = UIGraphicsGetCurrentContext();
		//[UIView beginAnimations:nil context:contextRollUpBottom];
		//[UIView setAnimationDelay: .4];
		//[UIView commitAnimations];
		[infoWindow addSubview:windowView];
		[windowView release];
		[MainBackground release];
		if (StartButton ? [StartButton boolValue] : TRUE) {
			if([UIDevice instancesRespondToSelector:@selector(isWildcat)] && [[UIDevice currentDevice] isWildcat]) { 
				Start			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				StartImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Pad-Start-Button.png"];
				StartImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
					[Start setTransform:CGAffineTransformMake(-1,0,0,-1,0,0)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
					[Start setTransform:CGAffineTransformMakeRotation(3.14159/2)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
					[Start setTransform:CGAffineTransformMakeRotation(-3.14159/2)];
				}
				[StartImageMain setImage:StartImage];
				[Start addSubview:StartImageMain];
				//[Start setTransform:CGAffineTransformMake(0,1.5,-0.67,0,0,0)];
				Start.backgroundColor = [UIColor clearColor];
				Start.center		  = CGPointMake(145, 50);
			}
			else {
				Start			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				StartImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Start-Button.png"];
				StartImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				[StartImageMain setImage:StartImage];
				[Start addSubview:StartImageMain];
				Start.backgroundColor = [UIColor clearColor];
				Start.center		  = CGPointMake(30, 50);
			}
			[Start setShowsTouchWhenHighlighted:YES];
			[Start addTarget:self action:@selector(StartAllTimer) forControlEvents:UIControlEventTouchUpInside];
			[infoWindow addSubview:Start];
			[StartImageMain release];
		}
		if (StopButton ? [StartButton boolValue] : TRUE) {
			if([UIDevice instancesRespondToSelector:@selector(isWildcat)] && [[UIDevice currentDevice] isWildcat]) { 
				Stop			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				StopImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Pad-Stop-Button.png"];
				StopImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
					[Stop setTransform:CGAffineTransformMake(-1,0,0,-1,0,0)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
					[Stop setTransform:CGAffineTransformMakeRotation(3.14159/2)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
					[Stop setTransform:CGAffineTransformMakeRotation(-3.14159/2)];
				}
				[StopImageMain setImage:StopImage];
				[Stop addSubview:StopImageMain];
				Stop.backgroundColor = [UIColor clearColor];
				Stop.center		  = CGPointMake(250, 50);
			}
			else {
				Stop			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				StopImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Stop-Button.png"];
				StopImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				[StopImageMain setImage:StopImage];
				[Stop addSubview:StopImageMain];
				Stop.backgroundColor = [UIColor clearColor];
				Stop.center		  = CGPointMake(90, 50);
			}
			[Stop setShowsTouchWhenHighlighted:YES];
			[Stop addTarget:self action:@selector(StopTimer) forControlEvents:UIControlEventTouchUpInside];
			[infoWindow addSubview:Stop];
			[StopImageMain release];
		}
		if (RespringButton ? [RespringButton boolValue] : TRUE) {
			if([UIDevice instancesRespondToSelector:@selector(isWildcat)] && [[UIDevice currentDevice] isWildcat]) { 
				Respring			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				RespringImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Pad-Respring-Button.png"];
				RespringImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
					[Respring setTransform:CGAffineTransformMake(-1,0,0,-1,0,0)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
					[Respring setTransform:CGAffineTransformMakeRotation(3.14159/2)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
					[Respring setTransform:CGAffineTransformMakeRotation(-3.14159/2)];
				}
				[RespringImageMain setImage:RespringImage];
				[Respring addSubview:RespringImageMain];
				Respring.backgroundColor = [UIColor clearColor];
				Respring.center		  = CGPointMake(360, 50);
			}
			else {
				Respring			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				RespringImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Respring-Button.png"];
				RespringImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				[RespringImageMain setImage:RespringImage];
				[Respring addSubview:RespringImageMain];
				Respring.backgroundColor = [UIColor clearColor];
				Respring.center		  = CGPointMake(150, 50);
			}
			[Respring setShowsTouchWhenHighlighted:YES];
			[Respring addTarget:self action:@selector(RespringTimer) forControlEvents:UIControlEventTouchUpInside];
			[infoWindow addSubview:Respring];
			[RespringImageMain release];
		}
		if (RestartButton ? [RestartButton boolValue] : TRUE) {
			if([UIDevice instancesRespondToSelector:@selector(isWildcat)] && [[UIDevice currentDevice] isWildcat]) { 
				Restart			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				RestartImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Pad-Restart-Button.png"];
				RestartImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
					[Restart setTransform:CGAffineTransformMake(-1,0,0,-1,0,0)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
					[Restart setTransform:CGAffineTransformMakeRotation(3.14159/2)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
					[Restart setTransform:CGAffineTransformMakeRotation(-3.14159/2)];
				}
				[RestartImageMain setImage:RestartImage];
				[Restart addSubview:RestartImageMain];
				Restart.backgroundColor = [UIColor clearColor];
				Restart.center		  = CGPointMake(470, 50);
			}
			else {
				Restart			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				RestartImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Restart-Button.png"];
				RestartImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				[RestartImageMain setImage:RestartImage];
				[Restart addSubview:RestartImageMain];
				Restart.backgroundColor = [UIColor clearColor];
				Restart.center		  = CGPointMake(210, 50);
			}
			[Restart setShowsTouchWhenHighlighted:YES];
			[Restart addTarget:self action:@selector(RestartTimer) forControlEvents:UIControlEventTouchUpInside];
			[infoWindow addSubview:Restart];
			[RestartImageMain release];
		}
		if (ShutDownButton ? [ShutDownButton boolValue] : TRUE) {
			if([UIDevice instancesRespondToSelector:@selector(isWildcat)] && [[UIDevice currentDevice] isWildcat]) { 
				Shutdown			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				ShutdownImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Pad-Shutdown-Button.png"];
				ShutdownImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 80, 80)];
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
					[Shutdown setTransform:CGAffineTransformMake(-1,0,0,-1,0,0)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
					[Shutdown setTransform:CGAffineTransformMakeRotation(3.14159/2)];
				}
				if( [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
					[Shutdown setTransform:CGAffineTransformMakeRotation(-3.14159/2)];
				}
				[ShutdownImageMain setImage:ShutdownImage];
				[Shutdown addSubview:ShutdownImageMain];
				Shutdown.backgroundColor = [UIColor clearColor];
				Shutdown.center		  = CGPointMake(580, 50);
			}
			else {
				Shutdown			= [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				ShutdownImage		= [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/iRestart.bundle/iRestart-Shutdown-Button.png"];
				ShutdownImageMain	= [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 80)];
				[ShutdownImageMain setImage:ShutdownImage];
				[Shutdown addSubview:ShutdownImageMain];
				Shutdown.backgroundColor = [UIColor clearColor];
				Shutdown.center		  = CGPointMake(270, 50);
			}
			[Shutdown setShowsTouchWhenHighlighted:YES];
			[Shutdown addTarget:self action:@selector(ShutdownTimer) forControlEvents:UIControlEventTouchUpInside];
			[infoWindow addSubview:Shutdown];
			[ShutdownImageMain release];
		}
	}
	[Prefernces release];
}

@end
