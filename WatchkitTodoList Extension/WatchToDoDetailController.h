//
//  WatchToDoDetailController.h
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import "Todo.h"

@interface WatchToDoDetailController : WKInterfaceController

@property(strong, nonatomic) Todo *todo;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end
