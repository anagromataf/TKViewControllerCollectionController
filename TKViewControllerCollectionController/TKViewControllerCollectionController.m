//
//  TKViewControllerCollectionController.m
//  TKViewControllerCollectionController
//
//  Created by Tobias Kräntzer on 13.11.12.
//  Copyright (c) 2012 Tobias Kräntzer. All rights reserved.
//

#import <objc/runtime.h>

#import "TKViewControllerCollectionController.h"

#define kTKViewControllerCollectionControllerCellReuseIdentifier @"kTKViewControllerCollectionControllerCellReuseIdentifier"

#pragma mark -

static const char * kTKViewControllerCollectionControllerCellKey = "kTKViewControllerCollectionControllerCellKey";

@interface UICollectionViewCell (TKViewControllerCollectionController)
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation UICollectionViewCell (TKViewControllerCollectionController)
- (void)setViewController:(UIViewController *)viewController;
{
    objc_setAssociatedObject(self, kTKViewControllerCollectionControllerCellKey, viewController, OBJC_ASSOCIATION_RETAIN);
}
- (UIViewController *)viewController;
{
    return objc_getAssociatedObject(self, kTKViewControllerCollectionControllerCellKey);
}
@end

#pragma mark -

@interface TKViewControllerCollectionController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation TKViewControllerCollectionController

#pragma mark Life-cycle


#pragma mark Accessors

- (void)setViewControllers:(NSArray *)viewControllers;
{
    if (_viewControllers != viewControllers) {
        _viewControllers = viewControllers;
        [self.collectionView reloadData];
    }
}

#pragma mark ViewController Containment

- (void)insertViewController:(UIViewController *)viewController anIndex:(NSUInteger)index completion:(void (^)(BOOL finished))completion;
{
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
        NSMutableArray *viewControllers = [_viewControllers mutableCopy];
        [viewControllers insertObject:viewController atIndex:index];
        _viewControllers = viewControllers;
    } completion:completion];
}

- (void)deleteViewController:(UIViewController *)viewController completion:(void (^)(BOOL finished))completion;
{
    [self.collectionView performBatchUpdates:^{
        NSUInteger index = [_viewControllers indexOfObject:viewController];
        [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
        NSMutableArray *viewControllers = [_viewControllers mutableCopy];
        [viewControllers removeObjectAtIndex:index];
        _viewControllers = viewControllers;
    } completion:completion];
}

#pragma mark UIViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kTKViewControllerCollectionControllerCellReuseIdentifier];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    if (section == 0) {
        return [self.viewControllers count];
    } else {
        return 0;
    }
}

#pragma mark UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kTKViewControllerCollectionControllerCellReuseIdentifier forIndexPath:indexPath];
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:indexPath.row];
    cell.viewController = viewController;
        
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [viewController didMoveToParentViewController:self];
    
    [viewController beginAppearanceTransition:YES animated:NO];
    [cell.contentView addSubview:viewController.view];
    viewController.view.frame = cell.contentView.bounds;
    [viewController endAppearanceTransition];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UIViewController *viewController = cell.viewController;
    
    [viewController willMoveToParentViewController:nil];
    [viewController removeFromParentViewController];
    [viewController didMoveToParentViewController:nil];
    
    [viewController beginAppearanceTransition:NO animated:NO];
    [viewController.view removeFromSuperview];
    [viewController endAppearanceTransition];
    
    cell.viewController = nil;
}

#pragma mark Forwarding Delegate Calls

- (BOOL)respondsToSelector:(SEL)aSelector;
{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    } else {
        return [self.delegate respondsToSelector:aSelector];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
{
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (methodSignature) {
        return methodSignature;
    } else {
        return [(id)self.delegate methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    SEL aSelector = [invocation selector];
    
    if ([self.delegate respondsToSelector:aSelector])
        [invocation invokeWithTarget:self.delegate];
    else
        [self doesNotRecognizeSelector:aSelector];
}

@end
