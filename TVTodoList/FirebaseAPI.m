//
//  FirebaseAPI.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/10/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"

@implementation FirebaseAPI

+(void)fetchAllTodos:(AllTodosCompletion)completion {
    
    NSString *urlString = [NSString stringWithFormat:@"https://crossplatformtodolist.firebaseio.com/users.json?auth=%@", APP_KEY];
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"ROOT OBJECT: %@", rootObject);
        
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
        
        // Get all Todos and put them on screen, the key for all dicts in root object is a user, so we just need to values, not the keys.
        for (NSDictionary *userTodosDictionary in [rootObject allValues]) {
            NSArray *userTodos = [userTodosDictionary[@"todos"] allValues];
//            NSLog(@"USER TODOS: %@", userTodos);
            for (NSDictionary *todoDictionary in userTodos) {
                Todo *newTodo = [[Todo alloc] initWithDictionary:todoDictionary];
                
                [allTodos addObject:newTodo];
            }
        }
        
        if (completion) {
            completion(allTodos);
        }
        
    }] resume];
}

@end
