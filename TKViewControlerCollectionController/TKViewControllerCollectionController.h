//
//  TKViewControllerCollectionController.h
//  TKViewControlerCollectionController
//
//  Created by Tobias Kräntzer on 13.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKViewControllerCollectionController : UICollectionViewController

#pragma mark ViewController Containment

@property (nonatomic, strong) NSArray *viewControllers;

- (void)insertViewController:(UIViewController *)viewController anIndex:(NSUInteger)index;
- (void)deleteViewController:(UIViewController *)viewController;

@end
