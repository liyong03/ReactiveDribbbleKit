//
//  LoginViewController.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 7/5/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "LoginViewController.h"
#import "YLDribbbleLoginViewModel.h"
#import "YLAccountManager.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa.h>

@interface LoginViewController ()
@property (nonatomic, strong) UITextField* userNameField;
@property (nonatomic, strong) UIButton* signin;
@property (nonatomic, strong) YLDribbbleLoginViewModel* viewModel;
@property (nonatomic, copy) void (^finishHandler)();
@end

@implementation LoginViewController

+ (LoginViewController*)showLoginViewWithFinishHandler:(void(^)())completionBlock {
    if ([YLAccountManager sharedManager].currentPlayer) {
        completionBlock();
        return nil;
    } else {
        LoginViewController* loginVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        loginVC.finishHandler = completionBlock;
        return loginVC;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _viewModel = [[YLDribbbleLoginViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [SVProgressHUD appearance].hudBackgroundColor = [UIColor blackColor];
    [SVProgressHUD appearance].hudForegroundColor = [UIColor whiteColor];
    
    self.userNameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 40)];
    [self.view addSubview:self.userNameField];
    self.userNameField.placeholder = @"Dribbble username";
    
    self.signin = [[UIButton alloc] initWithFrame:CGRectMake(20, 180, self.view.frame.size.width - 40, 30)];
    [self.view addSubview:self.signin];
    [self.signin setTitle:@"SignIn" forState:UIControlStateNormal];
    [self.signin setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.signin setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    RAC(self.viewModel, username) = self.userNameField.rac_textSignal;
    self.signin.rac_command = self.viewModel.loginCommand;
    
    [RACObserve(self.viewModel, loading) subscribeNext:^(NSNumber *loading){
        if (loading.boolValue) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
    [[self.viewModel.loginCommand.executionSignals concat] subscribeNext:^(id x) {
        NSLog(@"%@", x);
        self.finishHandler();
    }];
    
    [self.viewModel.loginCommand.errors subscribeNext:^(id x) {
        NSLog(@"Login error: %@", x);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
