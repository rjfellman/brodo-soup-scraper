//
//  ViewController.h
//  Brodo
//
//  Created by Russ Fellman on 10/8/13.
//  Copyright (c) 2013 Rusty216. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *soupListTableView;
@property (nonatomic, retain) NSArray *soups;
@end
