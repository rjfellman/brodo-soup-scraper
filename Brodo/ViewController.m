//
//  ViewController.m
//  Brodo
//
//  Created by Russ Fellman on 10/8/13.
//  Copyright (c) 2013 Rusty216. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.soupListTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.soupListTableView setFrame:CGRectMake(self.soupListTableView.frame.origin.x, self.soupListTableView.frame.origin.y + 20, self.soupListTableView.frame.size.width, self.soupListTableView.frame.size.height)];
  [self.soupListTableView setDelegate:self];
  [self.soupListTableView setDataSource:self];
  
  self.soups = [self loadSoups];
  
  if (!self.soups) {
    self.soups = @[@"Scarola Speciale", @"Broccoli & Cheddar Cheese Soup"];
  }
  
  [self.view addSubview:self.soupListTableView];
}

#pragma mark UITableViewDatasource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
  
  cell.textLabel.text = [self.soups objectAtIndex:indexPath.row];
  
  return cell;

}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  NSDate *todayDate = [NSDate date];
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateStyle:NSDateFormatterMediumStyle];
  return [NSString stringWithFormat:@"Cafe Brodo Soup Selection - %@", [formatter stringFromDate:todayDate]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [self.soups count];
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
}

-(NSArray*)loadSoups {
  
  NSMutableArray *tempSoups = [[NSMutableArray alloc] init];
  [tempSoups addObject:@"Scarola Speciale"];
  [tempSoups addObject:@"Broccoli & Cheddar Cheese Soup"];
  
  NSURL *tutorialsUrl = [NSURL URLWithString:@"http://www.cafebrodo.com/Menus/Soups"];
  NSData *tutorialsHtmlData = [NSData dataWithContentsOfURL:tutorialsUrl];
  
  TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:tutorialsHtmlData];
  
  NSString *tutorialsXpathQueryString = @"//*[@id=\"c\"]/table/tbody/tr/td[2]/div[6]/span[2]";
  NSArray *tutorialsNodes = [tutorialsParser searchWithXPathQuery:tutorialsXpathQueryString];
  
  NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
  for (TFHppleElement *element in tutorialsNodes) {
    if ([element firstChild]) {
      [newTutorials addObject:[[element firstChild] children]];
    }
  }
  
  for (TFHppleElement *element in [newTutorials firstObject]) {
    if ([element content]) {
      NSLog(@"%@", [element content]);
      [tempSoups addObject:[element content]];
    }
  }
  
  return tempSoups;
}


@end
