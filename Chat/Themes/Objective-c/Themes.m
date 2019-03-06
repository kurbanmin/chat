//
//  Themes.m
//  Chat
//
//  Created by Qurban on 04.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

#import "Themes.h"

@implementation Themes

@synthesize theme1 = _theme1;
@synthesize theme2 = _theme2;
@synthesize theme3 = _theme3;


- (UIColor *)theme1 {
    return _theme1;
}

- (void)setTheme1:(UIColor *)theme1 {
    [theme1 retain];
    [_theme1 release];
    _theme1 = theme1;
}

- (UIColor *)theme2 {
    return _theme2;
}

- (void)setTheme2:(UIColor *)theme2 {
    [theme2 retain];
    [_theme2 release];
    _theme2 = theme2;
}

- (UIColor *)theme3 {
    return _theme3;
}

- (void)setTheme3:(UIColor *)theme3 {
    [theme3 retain];
    [_theme3 release];
    _theme3 = theme3;
}


- (void)dealloc {
    [self.theme1 release];
    [self.theme2 release];
    [self.theme3 release];
    [super dealloc];
}

@end
