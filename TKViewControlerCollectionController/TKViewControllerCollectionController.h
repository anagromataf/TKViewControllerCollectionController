//
//  TKViewControllerCollectionController.h
//  TKViewControlerCollectionController
//
//  Created by Tobias Kräntzer on 13.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKViewControllerCollectionController : UICollectionViewController

@property (nonatomic, assign) id <UICollectionViewDelegate> delegate;

#pragma mark ViewController Containment

@property (nonatomic, strong) NSArray *viewControllers;

- (void)insertViewController:(UIViewController *)viewController anIndex:(NSUInteger)index completion:(void (^)(BOOL finished))completion;;
- (void)deleteViewController:(UIViewController *)viewController completion:(void (^)(BOOL finished))completion;;

@end
