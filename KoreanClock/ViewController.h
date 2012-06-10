//
//  ViewController.h
//  KoreanClock
//
//  Created by Steve Yeom on 6/8/12.
//  Copyright (c) 2012 Appliogue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, assign) UIColor *backgroundColor;
@property (nonatomic, assign) UIColor *brightFontColor;
@property (nonatomic, assign) UIColor *darkFontColor;
@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, retain) NSArray *koreanLetter;
- (IBAction)showInfo:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

@end
