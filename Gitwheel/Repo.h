//
//  Repo.h
//  Gitwheel
//
//  Created by Cory Alder on 2015-07-01.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *forkUrl;
@property (nonatomic, strong) NSNumber *forkCount;


@end
