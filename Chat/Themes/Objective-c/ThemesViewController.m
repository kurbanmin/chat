//
//  ThemesViewController.m
//  Chat
//
//  Created by Qurban on 04.03.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController

@synthesize model = _model;
@synthesize delegate = _delegate;

- (IBAction)theme1Action:(UIButton *)sender {
    self.view.backgroundColor = self.model.theme1;
    [self.delegate themesViewController:self didSelectTheme:self.model.theme1];
    [self.navigationController.navigationBar setBarTintColor:self.model.theme1];
}

- (IBAction)theme2Action:(UIButton *)sender {
    self.view.backgroundColor = self.model.theme2;
    [self.delegate themesViewController:self didSelectTheme:self.model.theme2];
    [self.navigationController.navigationBar setBarTintColor:self.model.theme2];
}

- (IBAction)theme3Action:(UIButton *)sender {
    self.view.backgroundColor = self.model.theme3;
    [self.delegate themesViewController:self didSelectTheme:self.model.theme3];
    [self.navigationController.navigationBar setBarTintColor:self.model.theme3];
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSData *colorData = [NSUserDefaults.standardUserDefaults dataForKey:@"Theme"];
    UIColor *color = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    if (color != nil) {
        self.view.backgroundColor = color;
    }
}

// get
- (Themes *)model {
    return _model;
}

// set
- (void)setModel:(Themes *)model {
    [model retain];
    [_model release];
    _model = model;
}

- (id<ThemesViewControllerDelegate>)delegate {
    return _delegate;
}

- (void)setDelegate:(id<ThemesViewControllerDelegate>)delegate {
    _delegate = delegate;
}


- (void)dealloc {
    [self.model release];
    [super dealloc];
}

@end
