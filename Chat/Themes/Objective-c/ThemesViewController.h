//
//  ThemesViewController.h
//  Chat
//
//  Created by Qurban on 04.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes.h"
#import "ThemesViewControllerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController

@property (strong, nonatomic) Themes *model;
@property (weak, nonatomic) id<ThemesViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
