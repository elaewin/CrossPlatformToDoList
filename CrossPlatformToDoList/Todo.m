//
//  Todo.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "Todo.h"

@implementation Todo

-(instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content andEmail:(NSString *)email {
    self = [super init];
    
    if (self) {
        _title = title;
        _content = content;
        _user = email;
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content andDueDate:(NSDate *)dueDate andEmail:(NSString *)email createdOn:(NSString *)created {
    self = [super init];
    
    if (self) {
        _title = title;
        _content = content;
        _created = created;
        _dueDate = dueDate;
        _user = email;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)jsonDictionary {
    self = [super init];
    
    if (self) {
        _title = jsonDictionary[@"title"];
        _content = jsonDictionary[@"content"];
        _created = jsonDictionary[@"created"];
        _isComplete = jsonDictionary[@"isComplete"];
        _user = jsonDictionary[@"user"];
    }
    
    return self;
}

-(NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:locale];
    [formatter setDateFormat:@"MMM d, yyyy"];
    return [formatter stringFromDate:date];
}


@end
