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
    
    return cell;
}

@end
