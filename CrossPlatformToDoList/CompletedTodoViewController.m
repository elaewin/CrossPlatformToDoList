//
//  CompletedTodoViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "CompletedTodoViewController.h"
#import "TodoFirebaseAuth.h"
#import "Todo.h"

@interface CompletedTodoViewController ()

@end

@implementation CompletedTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TodoFirebaseAuth shared] startMonitoringTodoUpdatesFor:@1];
    // Do any additional setup after loading the view.
}

//-(void)setupFirebase {
//    
//    // reference to ENTIRE database
//    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
//    self.currentUser = [[FIRAuth auth] currentUser]; //get user id
//    
//    //reference to specific db for the user that is logged in. This line MUST come after the line getting the user id, otherwise child will be nil.
//    self.userReference = [[databaseReference child:@"users"]child:self.currentUser.uid];
////    NSLog(@"USER REFERENCE: %@", self.userReference);
//}

-(void)startMonitoringTodoUpdates {
    
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSMutableDictionary *todoData = child.value;
            
            if ([todoData[@"completed"] isEqual:@0]) {
                Todo *todo = [[Todo alloc] initWithDictionary:todoData];
                NSLog(@"Todo Title: %@ - Content: %@ - User: %@", todo.title, todo.content, todo.user);
                [allTodos addObject:todo];
            }
            
        }
    }];
}


@end
