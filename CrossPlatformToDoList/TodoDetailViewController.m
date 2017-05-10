//
//  TodoDetailViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "TodoDetailViewController.h"

@interface TodoDetailViewController ()

@end

@implementation TodoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)completeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
