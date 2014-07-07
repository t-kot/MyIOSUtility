//
//  UIViewController+PopupWithAnimation.h
//  tabelog_v2
//
//  Created by tkot on 7/7/14.
//  Copyright (c) 2014 tabelog. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PopupWithAnimation)
- (void)popupViewController:(UIViewController *)viewControllerToPopup animated:(BOOL)flag completion:(void (^)(void))completion;
- (void) closePopupViewControler:(UIViewController *)popupViewController animated:(BOOL)flag completion:(void (^)(void))completion;
@end
