//
//  Todo.h
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSDate *created;
@property(strong, nonatomic) NSDate *dueDate;
@property(nonatomic) BOOL complete;

@end
