//
//  TKAppDelegate.m
//  TKViewControlerCollectionController
//
//  Created by Tobias Kräntzer on 13.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import "TKViewControllerCollectionController.h"

#import "TKAppDelegate.h"

@interface TableViewController : UITableViewController
@end
@implementation TableViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {return 3;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{return [[UITableViewCell alloc] init];}
@end

@interface TKAppDelegate () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation TKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TKViewControllerCollectionController *collection = [[TKViewControllerCollectionController alloc] initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    collection.delegate = self;
    
    collection.viewControllers = @[
        [[TableViewController alloc] initWithStyle:UITableViewStyleGrouped],
        [[TableViewController alloc] initWithStyle:UITableViewStylePlain],
        [[TableViewController alloc] initWithStyle:UITableViewStyleGrouped]
    ];
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [collection insertViewController:[[TableViewController alloc] initWithStyle:UITableViewStylePlain] anIndex:0];
        
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [collection deleteViewController:[collection.viewControllers objectAtIndex:2]];
            
            int64_t delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                collection.viewControllers = @[
                [[TableViewController alloc] initWithStyle:UITableViewStyleGrouped],
                [[TableViewController alloc] initWithStyle:UITableViewStylePlain],
                [[TableViewController alloc] initWithStyle:UITableViewStyleGrouped]
                ];
            });
        });
    });
    
    self.window.rootViewController = collection;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark UICollectionViewDelegate (UICollectionViewDelegateFlowLayout)

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return self.window.rootViewController.view.bounds.size;
}

@end
