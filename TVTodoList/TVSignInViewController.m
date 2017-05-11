//
//  TVSignInViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/10/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "FirebaseAPI.h"
#import "TVHomeViewController.h"
#import "TVSignInViewController.h"

@interface TVSignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation TVSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqual:@"TVHomeViewController"]) {
        NSString *user = self.emailTextField.text;
        // get todos here
    }
}

- (IBAction)getTodosButtonPressed:(id)sender {
    
    [FirebaseAPI fetchAllTodosForEmail:self.emailTextField.text withCompletion:^(NSArray<Todo *> *allTodos) {
        
        if (allTodos.count == 0) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Results" message:@"No Todos were found for that email address." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *noneFoundAction = [UIAlertAction actionWithTitle:@"Go Back" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:noneFoundAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        
        } else {
            TVHomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TVHomeViewController"];
            
            homeVC.allTodos = allTodos;
            
            [self.navigationController pushViewController:homeVC animated:YES];
        }
        
        
        
    }];
    
    
}

@end
