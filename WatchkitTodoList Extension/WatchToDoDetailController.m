//
//  WatchToDoDetailController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "WatchToDoDetailController.h"

@implementation WatchToDoDetailController

-(void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.todo = context;
    
    [self.titleLabel setText:self.todo.title];
    [self.contentLabel setText:self.todo.content];
}

@end
