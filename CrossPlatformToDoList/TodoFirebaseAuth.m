//
//  FirebaseAuth.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/10/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "TodoFirebaseAuth.h"

@implementation TodoFirebaseAuth

+(instancetype)shared {
    static TodoFirebaseAuth *shared;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[TodoFirebaseAuth alloc] init];
    });
    return shared;
}

-(instancetype)init {
    self = [super init];
    
    if (self) {
        // Get DB reference, then crawl down the tree to the level we want (users)
        FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
        _currentUser = [[FIRAuth auth] currentUser];
        
        //reference to specific db for the user that is logged in. This line MUST come after the line getting the user id, otherwise child will be nil.
        _userReference = [[databaseReference child:@"users"]child:_currentUser.uid];
//        NSLog(@"USER REFERENCE: %@", _userReference);
    }
    return self;
}

-(void)startMonitoringTodoUpdatesFor:(NSNumber *)isCompleteStatus withCompletion:(AllTodosCompletion)completion {
    
    __weak typeof(self) bruce = self;
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        __strong typeof(bruce) hulk = bruce;
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSMutableDictionary *todoData = child.value;
            
            if ([todoData[@"user"] isEqual:nil]) {
                todoData[@"user"] = hulk.currentUser.email;
            }
            if ([todoData[@"isComplete"] isEqual:nil]) {
                todoData[@"isComplete"] = @0;
            }
            
            if ([todoData[@"isComplete"] isEqual:isCompleteStatus]) {
                Todo *todo = [[Todo alloc] initWithDictionary:todoData];
                NSLog(@"Todo Title: %@ - Content: %@ - User: %@", todo.title, todo.content, todo.user);
                [allTodos addObject:todo];
            }
            
        }
        if (completion) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(allTodos);
            });
        }
    }];
}

@end
