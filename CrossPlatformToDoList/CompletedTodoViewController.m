//
//  CompletedTodoViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "CompletedTodoViewController.h"
#import "TodoFirebaseAuth.h"
#import "Todo.h"
#import "TodoTableViewCell.h"

@interface CompletedTodoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<Todo *> *allTodos;

@end

@implementation CompletedTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[TodoFirebaseAuth shared] startMonitoringTodoUpdatesFor:@1];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.allTodos = [self preloadTodos];
    
    UINib *nib = [UINib nibWithNibName:@"TodoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TodoTableViewCell"];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (Todo *todo in self.allTodos) {
        NSLog(@"TODO TITLE FROM COMPLETED: %@", todo.title);
    }
    
    [self.tableView reloadData];
}
//-(void)setupFirebase {
//    
//    // reference to ENTIRE database
//    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
//    self.currentUser = [[FIRAuth auth] currentUser]; //get user id
//    
//    //reference to specific db for the user that is logged in. This line MUST come after the line getting the user id, otherwise child will be nil.
//    self.userReference = [[databaseReference child:@"users"]child:self.currentUser.uid];
////    NSLog(@"USER REFERENCE: %@", self.userReference);
//}

-(NSArray<Todo *> *)preloadTodos {
    Todo *firstTodo = [[Todo alloc] init];
    firstTodo.title = @"First Todo";
    firstTodo.content = @"This is the first Todo!";
    firstTodo.dueDate = @"Due: eventually";

    Todo *secondTodo = [[Todo alloc] init];
    secondTodo.title = @"Second Todo";
    secondTodo.content = @"This is a neato Todo!";
    secondTodo.dueDate = @"Due: sometime";
    
    Todo *thirdTodo = [[Todo alloc] init];
    thirdTodo.title = @"Third Todo";
    thirdTodo.content = @"This is another spiffy Todo!";
    thirdTodo.dueDate = @"Due: maybe never";

    return @[firstTodo, secondTodo, thirdTodo];
}

-(void)startMonitoringTodoUpdates {
    
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSMutableDictionary *todoData = child.value;
            
            if ([todoData[@"completed"] isEqual:@0]) {
                Todo *todo = [[Todo alloc] initWithDictionary:todoData];
                NSLog(@"Todo Title: %@ - Content: %@ - User: %@", todo.title, todo.content, todo.user);
                [allTodos addObject:todo];
            }
            
        }
    }];
}

// MARK: UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoTableViewCell" forIndexPath:indexPath];
        
    cell.todo = [self.allTodos objectAtIndex:indexPath.row];
    
    return cell;
}

@end
