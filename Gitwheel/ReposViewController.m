//
//  MasterViewController.m
//  Gitwheel
//
//  Created by Cory Alder on 2015-07-01.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import "ReposViewController.h"
#import "ForksViewController.h"

#import "Repo.h"

@interface ReposViewController ()

@property NSMutableArray *objects;
@end

@implementation ReposViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"https://api.github.com/users/researchkit/repos";
    
    NSURL *url = [NSURL URLWithString:urlString];
//    NSData *data = [NSData dataWithContentsOfURL:url];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSError *jsonError;
        
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!repos) {
            NSLog(@"There was an error: %@", error);
        } else {
            
            
            NSMutableArray *repoTemp = [NSMutableArray array];
            
            
            for (NSDictionary *repoDict in repos) {
                Repo *newRepo = [[Repo alloc] init];
                
                newRepo.fullName = repoDict[@"full_name"];
                newRepo.forkCount   = repoDict[@"forks"];
                
                NSURL *forkUrl = [NSURL URLWithString:repoDict[@"forks_url"]];
                
                newRepo.forkUrl = forkUrl;
                
            
                [repoTemp addObject:newRepo];
            }
            
            
            
            // do this on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                self.objects = repoTemp;
                [self.tableView reloadData];
            });
            // end main thread code
        }
        
    }];
    
    [task resume];
    
    //NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Repo *repo = self.objects[indexPath.row];
        
        [[segue destinationViewController] setForkUrl:repo.forkUrl];
        // pass to destination view controller
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Repo *repo = self.objects[indexPath.row];
    
    cell.textLabel.text = repo.fullName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ forks", repo.forkCount];
    
    
    return cell;
}

@end
