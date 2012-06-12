//
//  ViewController.m
//  KoreanClock
//
//  Created by Steve Yeom on 6/8/12.
//  Copyright (c) 2012 Appliogue. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kMinAlpha 0.4
#define kMaxAlpha 1.0
#define kRowColumn 6
#define kBackgroundColor [UIColor blackColor];
#define kBrightFontColor [UIColor whiteColor];
#define kDarkFontColor [UIColor grayColor];

@interface ViewController ()
- (void)showLetter:(int)index;
- (void)showLetter:(NSString *)letter withTag:(NSInteger)tag;
- (void)hideLetter:(NSString *)letter withTag:(NSInteger)tag;
- (void)initLetter;
- (void)clearTime;
- (void)tictok;
- (void)display;
@end

@implementation ViewController
@synthesize infoButton = _infoButton;
@synthesize backgroundColor, brightFontColor, darkFontColor;
@synthesize timer;
@synthesize koreanLetter = _koreanLetter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ( (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ) ){
        [UIApplication sharedApplication].idleTimerDisabled = YES;    // 꺼짐방지
        backgroundColor = kBackgroundColor;
        brightFontColor = kBrightFontColor;
        darkFontColor = kDarkFontColor;
        self.koreanLetter = [NSArray arrayWithObjects:@"오", @"전", @"후", @"열", @"한", @"두", @"세", @"일", @"곱", @"다", @"여", @"섯", @"네", @"여", @"덟", @"아", @"홉", @"시", @"자", @"이", @"삼", @"사", @"오", @"십", @"정", @"오", @"일", @"이", @"삼", @"사", @"육", @"칠", @"팔", @"구", @"분", @"초", nil];
        
        brightness = [[UIScreen mainScreen] brightness];
        
        UISwipeGestureRecognizer *swipeRecognizer;
        
        swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(torchOn:)];
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipeRecognizer];
        
        swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(torchOff:)];
        swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:swipeRecognizer];

    }
    
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(initLetter) withObject:nil afterDelay:2];
#warning fix me
    [_infoButton setFrame:CGRectMake(280, 260, 18, 19)];
}

- (IBAction)showInfo:(id)sender {
    [(UIButton *)sender setHidden:YES];
    [timer invalidate];
    [self clearTime];

    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationCurveEaseIn animations:^{

        [self showLetter:@"한" withTag:11];
        [self showLetter:@"글" withTag:12];
        [self showLetter:@"시" withTag:13];
        [self showLetter:@"계" withTag:14];

        [self showLetter:@"만" withTag:21];
        [self showLetter:@"든" withTag:22];
        [self showLetter:@"놈" withTag:23];
        [self showLetter:@"크" withTag:32];
        [self showLetter:@"레" withTag:33];
        [self showLetter:@"이" withTag:34];
        [self showLetter:@"지" withTag:35];
        [self showLetter:@"염" withTag:36];
        
        [self showLetter:@"참" withTag:41];
        [self showLetter:@"조" withTag:42];
        [self showLetter:@"수" withTag:52];
        [self showLetter:@"아" withTag:53];
        [self showLetter:@"파" withTag:54];
        [self showLetter:@"파" withTag:55];
        [self showLetter:@"한" withTag:61];
        [self showLetter:@"글" withTag:62];
        [self showLetter:@"시" withTag:64];
        [self showLetter:@"계" withTag:65];
        
        [self hideLetter:nil withTag:66];    
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(initLetter) userInfo:nil repeats:NO];
    }];   
}

- (void)showLetter:(int)index{
    [self showLetter:nil withTag:index];
}

- (void)showLetter:(NSString *)letter withTag:(NSInteger)tag{
    UILabel *label = (UILabel *)[self.view viewWithTag:tag];
    if (letter != nil) {
        label.text = letter;
    }
    label.alpha = kMaxAlpha;
    label.textColor = brightFontColor;    
}

- (void)hideLetter:(NSString *)letter withTag:(NSInteger)tag{
    UILabel *label = (UILabel *)[self.view viewWithTag:tag];
    if (letter != nil){
        label.text = letter;
    }
    label.alpha = kMinAlpha;
    label.textColor = darkFontColor;    
}

- (void)initLetter{
    int tagIndex, index = 0;
    UILabel *label = nil;
    for (int i = 1;i <= kRowColumn; i++){
        for (int j = 1; j <= kRowColumn; j++) {
            tagIndex = i * 10 + j;
            label = (UILabel *)[self.view viewWithTag:tagIndex];            
            label.text = [_koreanLetter objectAtIndex:index];
            label.alpha = kMinAlpha;
            index++;
            }
        }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(display) userInfo:nil repeats:YES];
    UIButton *button = (UIButton *)[self.view viewWithTag:99];
    [button setHidden:NO];
}

#warning 매번 초기화 하는 것보다 변경된것만 켜고 끄고...
- (void)clearTime{
    int tagIndex = 0;
    for (int i = 1;i <= kRowColumn; i++){
        for (int j = 1; j <= kRowColumn; j++) {
            tagIndex = i * 10 + j;
            if (tagIndex != 66){
                UILabel *label = (UILabel *)[self.view viewWithTag:tagIndex];
                label.textColor = darkFontColor;
                label.alpha = kMinAlpha;
            }
        }
    }
}

- (void)tictok{
    UILabel *label = (UILabel *)[self.view viewWithTag:66];
    if (label.alpha == kMaxAlpha){
        label.textColor = darkFontColor;
        label.alpha = kMinAlpha;
    }else{
        label.textColor = brightFontColor;
        label.alpha = kMaxAlpha;
    }
}

- (void)display{
    NSDate *date = [NSDate date]; 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"H"];
    int hour = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"mm"];
    int min = [[formatter stringFromDate:date] intValue];
    
    BOOL isMidnightRrNoon = NO;
    
#warning fix me
    [self clearTime]; 

    if (hour >= 12 && !(hour == 12 && min == 0)) {
        [self showLetter:11]; [self showLetter:13]; // 오후
    }else if (hour < 12 && !((hour == 0 || hour == 24) && min == 0)) {
        [self showLetter:11]; [self showLetter:12]; // 오전
    }

    if (hour == 12 && min == 0) {
        [self showLetter:51]; [self showLetter:52]; // 정오
        hour = -1;
        isMidnightRrNoon = YES;
    }else if ((hour == 0 || hour == 24) && min == 0) {
        [self showLetter:41]; [self showLetter:51]; // 자정
        hour = -1;
        isMidnightRrNoon = YES;
    }
    
    if (hour > 13){
        hour = hour - 12;
    }

    switch (hour) {
        case 1:
            [self showLetter:15];    
            break;
        case 2:
            [self showLetter:16];            
            break;
        case 3:
            [self showLetter:21];
            break;
        case 4:
            [self showLetter:31];
            break;
        case 5:
            [self showLetter:24]; [self showLetter:26];
            break;
        case 6:
            [self showLetter:25]; [self showLetter:26];
            break;
        case 7:
            [self showLetter:22]; [self showLetter:23];
            break;
        case 8:
            [self showLetter:32]; [self showLetter:33];
            break;
        case 9:
            [self showLetter:34]; [self showLetter:35];
            break;
        case 10:
            [self showLetter:14];
            break;
        case 11:
            [self showLetter:14]; [self showLetter:15];
            break;
        case 12:
        case 0:
            [self showLetter:14]; [self showLetter:16];
            break;

        default:
            break;
    }
    
    if (!isMidnightRrNoon){
        [self showLetter:36]; // 시
    }
    
    int ten = min / 10;
    switch (ten) {
        case 1:
            [self showLetter:46];    
            break;
        case 2:
            [self showLetter:42]; [self showLetter:46];           
            break;
        case 3:
            [self showLetter:43]; [self showLetter:46];
            break;
        case 4:
            [self showLetter:44]; [self showLetter:46];
            break;
        case 5:
            [self showLetter:45]; [self showLetter:46];
            break;
        default:
            break;
    }
    min = min % 10;
    switch (min) {
        case 1:
            [self showLetter:53];     
            break;
        case 2:
            [self showLetter:54];            
            break;
        case 3:
            [self showLetter:55]; 
            break;
        case 4:
            [self showLetter:56]; 
            break;
        case 5:
            [self showLetter:52]; 
            break;
        case 6:
            [self showLetter:61]; 
            break;
        case 7:
            [self showLetter:62]; 
            break;
        case 8:
            [self showLetter:63]; 
            break;
        case 9:
            [self showLetter:64]; 
            break;            
        default:
            break;
    }

    if (!isMidnightRrNoon && min != 0){
        [self showLetter:65]; // 분
    }
    [self tictok];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    previousPoint = location.y;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    float _brightness = brightness + (previousPoint/100 - location.y/100);   
    
    if (_brightness < 0) _brightness = 0;
    else if (_brightness > 1) _brightness = 1;
    
    [[UIScreen mainScreen] setBrightness:_brightness];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    brightness = [[UIScreen mainScreen] brightness];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    brightness = [[UIScreen mainScreen] brightness];
}

- (void)torchOn:(id)sender{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    [device setTorchMode:AVCaptureTorchModeOn];
    [device unlockForConfiguration];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    timer = nil;
    [timer invalidate];
    [self setInfoButton:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
        [_infoButton setFrame:CGRectMake(400, 280, 18, 19)];
    }
    else{
        [_infoButton setFrame:CGRectMake(280, 400, 18, 19)];
    }

}

@end
