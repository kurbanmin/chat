//
//  ThemesViewControllerDelegate.h
//  Chat
//
//  Created by Qurban on 04.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThemesViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol ThemesViewControllerDelegate <NSObject>

-(void)themesViewController:(ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;

@end

NS_ASSUME_NONNULL_END

