//
//  TVHomeViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "TVHomeViewController.h"
#import "Todo.h"

@interface TVHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) NSArray<Todo *> *allTodos;

// pragma MARK: Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TODO LIST:";
    
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
}

-(NSArray<Todo *> *)allTodos {
    Todo *firstTodo = [[Todo alloc] init];
    firstTodo.title = @"First Todo";
    firstTodo.content = @"This is the first Todo!";
    
    Todo *secondTodo = [[Todo alloc] init];
    secondTodo.title = @"First Todo";
    secondTodo.content = @"This is a neato Todo!";
    
    Todo *thirdTodo = [[Todo alloc] init];
    thirdTodo.title = @"First Todo";
    thirdTodo.content = @"This is another spiffy Todo!";
    
    return @[firstTodo, secondTodo, thirdTodo];
}

// pragma MARK: UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    
    return cell;
}

@end
