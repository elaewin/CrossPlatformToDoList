//
//  TodoTableViewCell.h
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/15/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface TodoTableViewCell : UITableViewCell

@property(strong, nonatomic) Todo *todo;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end
