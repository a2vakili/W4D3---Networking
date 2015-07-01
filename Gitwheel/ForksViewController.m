//
//  ForksViewController.m
//  Gitwheel
//
//  Created by Cory Alder on 2015-07-01.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import "ForksViewController.h"

@interface ForksViewController ()

@property NSMutableArray *objects;

@end

@implementation ForksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.forkUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *jsonError;
        
        NSArray *forks = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!forks) {
            NSLog(@"There was an error: %@", error);
        } else {
            
            // do this on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                self.objects = [forks mutableCopy];
                [self.tableView reloadData];
            });
            // end main thread code
        }
        
    }];
    
    [task resume];
    
    
    
    // ***** DO NOT DO IT THIS WAY *****
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    
//    NSError *error;
//    
//    NSArray *forks = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//    
//    if (!forks) {
//        NSLog(@"There was an error: %@", error);
//    } else {
//        self.objects = [forks mutableCopy];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForkCell" forIndexPath:indexPath];
    
    NSDictionary *fork = self.objects[indexPath.row];
    
    cell.textLabel.text = fork[@"owner"][@"login"];
    
    return cell;
}

@end
