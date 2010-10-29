//
//  iRestartControl.h
//  iRestart
//
//  Created by Evilpenguin on 4/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

@interface iRestartControl : UIWindow {
	UIWindow *infoWindow;
	UIView *windowView;
	UIImage *LoadedImage;
	UIImageView *MainBackground;
	UIButton *Start;
	UIImage *StartImage;
	UIImageView *StartImageMain;
	UIButton *Stop;
	UIImage *StopImage;
	UIImageView *StopImageMain;
	UIButton *Respring;
	UIImage *RespringImage;
	UIImageView *RespringImageMain;
	UIButton *Restart;
	UIImage *RestartImage;
	UIImageView *RestartImageMain;
	UIButton *Shutdown;
	UIImage *ShutdownImage;
	UIImageView *ShutdownImageMain;
}
+ (id) sharedInstance;
- (void) Close;
- (void) StartAllTimer; 
- (void) StopTimer;
- (void) ShutdownTimer;
- (void) RestartTimer;
- (void) RespringTimer;
- (void) LoadiRestart; 
@property(nonatomic) BOOL showsTouchWhenHighlighted;
@end
