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
@property(strong, nonatomic) NSString *created;
@property(strong, nonatomic) NSString *dueDate;
@property(strong, nonatomic) NSNumber *isComplete;
@property(strong, nonatomic) NSString *user;

-(instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content andEmail:(NSString *)email;
-(instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content andDueDate:(NSDate *)dueDate andEmail:(NSString *)email;
-(instancetype)initWithDictionary:(NSDictionary *)jsonDictionary;

-(NSString *)formatDate:(NSDate *)date;

@end
