//
//  LoginViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "LoginViewController.h"
@import FirebaseAuth;

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//pragma MARK: Actions

-(IBAction)loginButtonPressed:(UIButton *)sender {
    
    [[FIRAuth auth] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error signing in: %@", error.localizedDescription);
        }
        
        if (user) {
            NSLog(@"Logged in user: %@", user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
}

-(IBAction)signupButtonPressed:(UIButton *)sender {
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error signing up: %@", error.localizedDescription);
        }
        
        if (user) {
            NSLog(@"New user (%@) successfully signed up.", user);
            // create logic here to deal with behavior when a new user signs up.
        }
        
    }];
}


@end
