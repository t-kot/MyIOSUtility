//
//  UIViewController+PopupWithAnimation.m
//  tabelog_v2
//
//  Created by tkot on 7/7/14.
//  Copyright (c) 2014 tabelog. All rights reserved.
//

#import "UIViewController+PopupWithAnimation.h"

@implementation UIViewController (PopupWithAnimation)
- (void)popupViewController:(UIViewController *)viewControllerToPopup animated:(BOOL)flag completion:(void (^)(void))completion
{
    UIView *popup = viewControllerToPopup.view;
    self.view.alpha = 0.8f;
    popup.layer.cornerRadius = 5;
    popup.layer.shadowOpacity = 0.8;
    popup.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    popup.center = self.view.center;
    [MAIN_WINDOW addSubview:popup];
    
    if(flag) {
        popup.transform = CGAffineTransformMakeScale(1.3, 1.3);
        popup.alpha = 0;
        [UIView animateWithDuration:.25 animations:^{
            popup.alpha = 1;
            popup.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if(completion) completion();
        }];
    }
}

- (void) closePopupViewControler:(UIViewController *)popupViewController animated:(BOOL)flag completion:(void (^)(void))completion
{
    UIView *popup = popupViewController.view;
    self.view.alpha = 1;
    
    if(flag) {
        [UIView animateWithDuration:.25 animations:^{
            popup.transform = CGAffineTransformMakeScale(1.3, 1.3);
            popup.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [popup removeFromSuperview];
                if(completion) completion();
            }
        }];
    } else {
        [popup removeFromSuperview];
        if(completion) completion();
    }
}
@end
