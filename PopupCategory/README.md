ポップアップのViewControllerをいい感じに表示したい

![](http://i.gyazo.com/9b3e1a4ec31a12ce8626f62187682aca.gif)


# UIViewController+PopupWithAnimation

```objective-c:UIViewController+PopupWithAnimation.h

#import <UIKit/UIKit.h>

@interface UIViewController (PopupWithAnimation)
- (void)popupViewController:(UIViewController *)viewControllerToPopup animated:(BOOL)flag completion:(void (^)(void))completion;
- (void) closePopupViewControler:(UIViewController *)popupViewController animated:(BOOL)flag completion:(void (^)(void))completion;
@end
```

```objective-c:UIViewController+PopupWithAnimation.m

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
```

# Usage

```objective-c
#import "UIViewController+PopupWithAnimation.h"

UIViewController *vc = [MAIN_STORYBOARD instantiateViewControllerWithIdentifier: @"MainLoginPopupViewController"];

[self popupViewController:vc animated:YES completion:nil];
```
