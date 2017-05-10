//
//  HomeInterfaceController.m
//  CrossPlatformToDoList
//
//  Created by Erica Winberry on 5/9/17.
//  Copyright © 2017 Erica Winberry. All rights reserved.
//

#import "HomeInterfaceController.h"
#import "TodoRowController.h"
#import "WatchToDoDetailController.h"

#import "Todo.h"

@interface HomeInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;
@property(strong, nonatomic) NSArray<Todo *> *allTodos;

@end

@implementation HomeInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self setupTable];
    
    // Configure interface objects here.
}

-(void)setupTable {
    [self.table setNumberOfRows:self.allTodos.count withRowType:@"TodoRowController"];
    
    // this for loop recreates cellForRowAtIndexPath
    for (NSInteger i = 0; i < self.allTodos.count; i++) {
        TodoRowController *rowController = [self.table rowControllerAtIndex:i];
        
        [rowController.titleLabel setText:self.allTodos[i].title];
        [rowController.contentLabel setText:self.allTodos[i].content];
    }
}

-(NSArray<Todo *> *)allTodos {
    Todo *firstTodo = [[Todo alloc] init];
    firstTodo.title = @"First Todo";
    firstTodo.content = @"This is the first Todo!";
    
    Todo *secondTodo = [[Todo alloc] init];
    secondTodo.title = @"Second Todo";
    secondTodo.content = @"This is a neato Todo!";
    
    Todo *thirdTodo = [[Todo alloc] init];
    thirdTodo.title = @"Third Todo";
    thirdTodo.content = @"This is another spiffy Todo!";
    
    return @[firstTodo, secondTodo, thirdTodo];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    
    Todo *todo = self.allTodos[rowIndex];
    
    [self pushControllerWithName:@"WatchToDoDetailController" context:todo];
    
}

- (IBAction)newTodoButtonPressed {
    
    NSArray *suggestions = @[@"Hello There", @"#hashtag", @"I really should walk the dog."];
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModeAllowEmoji completion:^(NSArray * _Nullable results) {
        NSLog(@"%@", results);
    }];
}

@end
