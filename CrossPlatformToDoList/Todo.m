//
//  Todo.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "Todo.h"

@implementation Todo

-(instancetype)initWithTitle:(NSString *)title andContent:(NSString *)content {
    self = [super init];
    
    if (self) {
        _title = title;
        _content = content;
    }
    return self;
}


-(instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content andDueDate:(NSDate *)dueDate {
    self = [super init];
    
    if (self) {
        _title = title;
        _content = content;
        _dueDate = [self formatDate:dueDate];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)jsonDictionary {
    self = [super init];
    
    if (self) {
        _title = jsonDictionary[@"title"];
        _content = jsonDictionary[@"content"];
        _created = [self formatDate:[NSDate date]];
        _isComplete = @0;
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
