//
//  HomeViewController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/8/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "TodoFirebaseAuth.h"
#import "TodoTableViewCell.h"

@import FirebaseAuth;
@import FirebaseDatabase;


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler; //event listener works thru this.
@property(strong, nonatomic) NSArray<Todo *> *allTodos;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TO DO LIST";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nib = [UINib nibWithNibName:@"TodoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"TodoTableViewCell"];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkUserStatus];
    [self.tableView reloadData];
}

// pragma MARK: Helper Methods
-(void)checkUserStatus {
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
//        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    NSLog(@"Segue destination: %@", segue.destinationViewController);
}

-(void)setupFirebase {
    
    // reference to ENTIRE database
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser]; //get user id
    
    //reference to specific db for the user that is logged in. This line MUST come after the line getting the user id, otherwise child will be nil.
    self.userReference = [[databaseReference child:@"users"]child:self.currentUser.uid];
//    NSLog(@"USER REFERENCE: %@", self.userReference);
}

-(void)startMonitoringTodoUpdates {

    __weak typeof(self) bruce = self;
    [[TodoFirebaseAuth shared] startMonitoringTodoUpdatesFor:@0 withCompletion:^(NSArray<Todo *> *allTodos) {
        
        __strong typeof(bruce) hulk = bruce;
        hulk.allTodos = allTodos;
        
    }];
    [self.tableView reloadData];
}

//    __weak typeof(self) bruce = self;
//    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        
//        __strong typeof(bruce) hulk = bruce;
//        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
//        
//        for (FIRDataSnapshot *child in snapshot.children) {
//            NSMutableDictionary *todoData = child.value;
//            
//            if ([todoData[@"user"] isEqual:nil]) {
//                todoData[@"user"] = hulk.currentUser.email;
//            }
//            if ([todoData[@"isComplete"] isEqual:nil]) {
//                todoData[@"isComplete"] = @0;
//            }
//            
//            if ([todoData[@"created"] isEqual:nil]) {
//                todoData[@"created"] = @"Jan 1, 12:00 am";
//            }
//            
//            if ([todoData[@"isComplete"] isEqual:@0]) {
//                Todo *todo = [[Todo alloc] initWithDictionary:todoData];
//                NSLog(@"Todo Title: %@ - Content: %@ - User: %@", todo.title, todo.content, todo.user);
//                [allTodos addObject:todo];
//            }
//        }
//        self.allTodos = allTodos.copy;
//    }];
    


// pragma MARK: UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"---NUMBER OF TODOS: %lu", (unsigned long)self.allTodos.count);
    return self.allTodos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoTableViewCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[TodoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TodoTableViewCell"];
    }
    
    Todo *todo = [self.allTodos objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = todo.title;
    cell.contentLabel.text = todo.content;
    cell.dueDateLabel.text = [NSString stringWithFormat:@"Due: %@", todo.dueDate];
    
    return cell;
}

// pragma MARK: UITableViewDelegate methods

// pragma MARK: Actions

- (IBAction)addButtonPressed:(id)sender {
}

- (IBAction)logoutButtonPressed:(id)sender {
    // sign OUT process is these 2 lines:
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
    [self checkUserStatus];
}

@end
