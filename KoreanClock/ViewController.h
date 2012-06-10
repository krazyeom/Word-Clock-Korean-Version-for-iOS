//
//  ViewController.h
//  KoreanClock
//
//  Created by Steve Yeom on 6/8/12.
//  Copyright (c) 2012 Appliogue. All rights reserved.
//

#import <UIKit/UIKit.h>

<<<<<<< HEAD
@interface ViewController : UIViewController{
    float previousPoint;
    float brightness;
}
=======
@interface ViewController : UIViewController
>>>>>>> parent of ec49ad2... Add Torch, Brightness

@property (nonatomic, assign) UIColor *backgroundColor;
@property (nonatomic, assign) UIColor *brightFontColor;
@property (nonatomic, assign) UIColor *darkFontColor;
@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, retain) NSArray *koreanLetter;
- (IBAction)showInfo:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

@end
