//
//  TKViewControllerCollectionController.h
//  TKViewControllerCollectionController
//
//  Created by Tobias Kräntzer on 13.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKViewControllerCollectionController : UICollectionViewController

@property (nonatomic, assign) id <UICollectionViewDelegate> delegate;

#pragma mark UIViewController Containment

@property (nonatomic, strong) NSArray *viewControllers;

- (void)addViewController:(UIViewController *)viewController completion:(void (^)(BOOL finished))completion;
- (void)insertViewController:(UIViewController *)viewController atIndex:(NSUInteger)index completion:(void (^)(BOOL finished))completion;
- (void)deleteViewController:(UIViewController *)viewController completion:(void (^)(BOOL finished))completion;
- (void)deleteViewControllers:(NSArray *)viewControllers completion:(void (^)(BOOL finished))completion;

#pragma mark Customizing Insertion

// The view controller collection calls this method before the batch update of the collection view.
- (void)prepareInsertionOfViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;

// The view controller collection calls this method as the last step in the batch update of the collevtion view.
- (void)finalizeInsertionOfViewController:(UIViewController *)viewController;

#pragma mark Customizing Deletion

// The view controller collection calls this method before the batch update of the collection view.
- (void)prepareDeletionOfViewControllers:(NSArray *)viewControllers;

// The view controller collection calls this method as the last step in the batch update of the collevtion view.
- (void)finalizeDeletionOfViewControllers:(NSArray *)viewControllers;

@end
