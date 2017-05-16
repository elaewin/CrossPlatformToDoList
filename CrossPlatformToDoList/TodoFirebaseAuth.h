//
//  TodoFirebaseAuth.h
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/10/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

@import Firebase;
@import FirebaseAuth;

typedef void(^AllTodosCompletion)(NSArray<Todo *> *allTodos);

@interface TodoFirebaseAuth : NSObject

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;
@property(nonatomic) FIRDatabaseHandle allTodosHandler;

+(instancetype)shared;
-(void)startMonitoringTodoUpdatesFor:(NSNumber *)isCompleteStatus withCompletion:(AllTodosCompletion)completion;

@end
