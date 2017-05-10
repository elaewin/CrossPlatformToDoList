//
//  HomeViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"

@import FirebaseAuth;
@import FirebaseDatabase;


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler; //event listener works thru this.

@end

@implementation HomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TO DO LIST";
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkUserStatus];
}

// pragma MARK: Helper Methods
-(void)checkUserStatus {
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    NSLog(@"Segue destination: %@", segue.destinationViewController);
}

-(void)setupFirebase {
    
    // reference to ENTIRE database
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser]; //get user id
    
    //reference to specific db for the user that is logged in. This line MUST come after the line getting the user id, otherwise child will be nil.
    self.userReference = [[databaseReference child:@"users"]child:self.currentUser.uid];
    NSLog(@"USER REFERENCE: %@", self.userReference);
}

-(void)startMonitoringTodoUpdates {
    
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            
            Todo *todo = [[Todo alloc] init];
            todo.title = todoData[@"title"];
            todo.content = todoData[@"content"];
            
            NSLog(@"Todo Title: %@ - Content: %@", todo.title, todo.content);
            [allTodos addObject:todo];
        }
    }];
}

// pragma MARK: Actions

- (IBAction)addButtonPressed:(id)sender {
}

- (IBAction)logoutButtonPressed:(id)sender {
    // sign OUT process is these 2 lines:
        NSError *signOutError;
        [[FIRAuth auth] signOut:&signOutError];
}

@end
