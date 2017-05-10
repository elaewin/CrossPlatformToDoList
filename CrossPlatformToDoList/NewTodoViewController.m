//
//  NewTodoViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "NewTodoViewController.h"
@import Firebase;
@import FirebaseAuth;
//@import FirebaseDatabase;

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *todoTitleTextField;

@property (weak, nonatomic) IBOutlet UITextField *todoContentTextField;

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)addButtonPressed:(id)sender {
    // Get DB reference, then crawl down the tree to the level we want (users)
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    FIRUser *currentUser = [[FIRAuth auth] currentUser];
    FIRDatabaseReference *userReference = [[databaseReference child:@"users"] child:currentUser.uid];
    
    //This creates a new child of todos that we can now set values on.
    FIRDatabaseReference *newTodoReference = [[userReference child:@"todos"] childByAutoId];
    
    // Setting the values on the newTodoReference
    [[newTodoReference child:@"title"] setValue:self.todoTitleTextField.text];
    [[newTodoReference child:@"content"] setValue:self.todoContentTextField.text];
    
}


@end
