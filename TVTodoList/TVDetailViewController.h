//
//  TVDetailViewController.h
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"

@interface TVDetailViewController : UIViewController

@property(strong, nonatomic) Todo *todo;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;

@end
