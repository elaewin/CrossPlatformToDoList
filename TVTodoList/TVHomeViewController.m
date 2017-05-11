//
//  TVHomeViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Todo.h"
#import "TVHomeViewController.h"
#import "TVDetailViewController.h"


@interface TVHomeViewController () <UITableViewDataSource, UITableViewDelegate>


// MARK: Outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TODO LIST:";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Do any additional setup after loading the view.
}

//-(NSArray<Todo *> *)allTodos {
//    Todo *firstTodo = [[Todo alloc] init];
//    firstTodo.title = @"First Todo";
//    firstTodo.content = @"This is the first Todo!";
//    
//    Todo *secondTodo = [[Todo alloc] init];
//    secondTodo.title = @"Second Todo";
//    secondTodo.content = @"This is a neato Todo!";
//    
//    Todo *thirdTodo = [[Todo alloc] init];
//    thirdTodo.title = @"Third Todo";
//    thirdTodo.content = @"This is another spiffy Todo!";
//    
//    return @[firstTodo, secondTodo, thirdTodo];
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier  isEqual:@"TVDetailViewController"]) {
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        Todo *selectedTodo = self.allTodos[index.row];
        
        TVDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.todo = selectedTodo;
    }
}

// MARK: UITableViewDataSource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Todo *todo = self.allTodos[indexPath.row];
    
    cell.textLabel.text = todo.title;
    cell.detailTextLabel.text = todo.content;
    
    return cell;
}

// MARK: UITableViewDelegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"TVDetailViewController" sender:nil];
}

@end
