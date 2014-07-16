//
//  TNTAlertViewController.m
//  AlertView
//
//  Created by Joe Selvik on 7/11/14.
//  Copyright (c) 2014 The New Tricks. All rights reserved.
//

#import "TNTAlertViewController.h"

@interface TNTAlertViewController ()

@property (assign, nonatomic) CGRect frameForAlertView;

@property (nonatomic, weak) UIViewController *currentAlertMessageViewController;

@property (strong, nonatomic) IBOutlet UIView *alertBoxView;        // Crashes if this is deleted
@property (weak, nonatomic) IBOutlet UILabel *alertMessageLabel;
@property (weak, nonatomic) IBOutlet UIButton *alertCloseButton;

@end

@implementation TNTAlertViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // AlertView Size
    CGFloat xAlertFrame = 0;
    CGFloat yAlertFrame = self.navigationController.navigationBar.frame.size.height+[UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat widthAlertFrame = self.navigationController.navigationBar.frame.size.width;
    CGFloat heightAlertFrame = self.navigationController.navigationBar.frame.size.height;
    _frameForAlertView = CGRectMake(xAlertFrame, yAlertFrame, widthAlertFrame, heightAlertFrame);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)createAlertVCWithMessage:(NSString *)message fromCurrentVC:(UIViewController *)currentVC
{
    UIStoryboard *storyboard = self.storyboard;
    TNTAlertViewController *alertVC = [storyboard instantiateViewControllerWithIdentifier:@"alertViewController"];
    alertVC.view.frame = self.frameForAlertView;
    
    [alertVC setAlertMessage:message];
    [alertVC connectAlertVCCloseButtonWithSelf:alertVC];
    
    // Properly add childVC to parentVC
    [currentVC addChildViewController:alertVC];
    [currentVC.view addSubview:alertVC.view];
    [alertVC didMoveToParentViewController:currentVC];
}



-(void)setAlertMessage:(NSString *)message
{
    self.alertMessageLabel.text = message;
}

-(void)connectAlertVCCloseButtonWithSelf:(TNTAlertViewController *)instance
{
    self.currentAlertMessageViewController = instance;
    
    [self.alertCloseButton addTarget:self
                          action:@selector(closeAlertMessageVC)
                forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)closeAlertMessageVC
{
    [self.currentAlertMessageViewController willMoveToParentViewController:nil];
    [self.currentAlertMessageViewController.view removeFromSuperview];
    [self.currentAlertMessageViewController removeFromParentViewController];

}




@end
