//
//  TVDetailViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "TVDetailViewController.h"

@interface TVDetailViewController ()

@end

@implementation TVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.todo.title;
    self.contentlabel.text = self.todo.content;
    // Do any additional setup after loading the view.
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
