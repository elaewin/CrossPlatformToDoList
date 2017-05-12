//
//  NewTodoViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "NewTodoViewController.h"
#import "TodoFirebaseAuth.h"
@import Firebase;
@import FirebaseAuth;
//@import FirebaseDatabase;

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *todoTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *todoContentTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDatePicker;

@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dueDatePicker.minimumDate = [NSDate date];
    // Do any additional setup after loading the view.
}

- (IBAction)addButtonPressed:(id)sender {
    // Get DB reference, then crawl down the tree to the level we want (users)

    //This creates a new child of todos that we can now set values on.
    FIRDatabaseReference *newTodoReference = [[[[TodoFirebaseAuth shared] userReference] child:@"todos"] childByAutoId];
    
    // Setting the values on the newTodoReference
    [[newTodoReference child:@"title"] setValue:self.todoTitleTextField.text];
    [[newTodoReference child:@"content"] setValue:self.todoContentTextField.text];
    [[newTodoReference child:@"user"] setValue:[[TodoFirebaseAuth shared] currentUser].email];
    [[newTodoReference child:@"isComplete"] setValue:@0];
    [[newTodoReference child:@"created"] setValue:[self formatDate:[NSDate date]]];
    [[newTodoReference child:@"dueDate"] setValue:[self formatDate:self.dueDatePicker.date]];
}

-(NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    return [formatter stringFromDate:date];
}


@end
