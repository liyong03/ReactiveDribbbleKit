//
//  PlayersTableViewController.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/23/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "PlayersTableViewController.h"
#import "YLPlayersViewModel.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa.h>
#import "YLDribbbleUser.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ShotsViewController.h"

@interface PlayersTableViewController ()

@property (nonatomic, strong) YLPlayersViewModel *viewModel;

@end

@implementation PlayersTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _viewModel = [YLPlayersViewModel playerFollowerViewModelWithName:@"simplebits"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [SVProgressHUD appearance].hudBackgroundColor = [UIColor blackColor];
    [SVProgressHUD appearance].hudForegroundColor = [UIColor whiteColor];
    
    self.title = @"Player list";
    
    @weakify(self);
    [RACObserve(self.viewModel, players) subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    [RACObserve(self.viewModel, loading) subscribeNext:^(NSNumber *loading){
        if (loading.boolValue) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
    // actions
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple *arguments) {
        @strongify(self);
        
        NSIndexPath *indexPath = arguments.second;
        YLDribbbleUser* player = self.viewModel.players[indexPath.row];
        
        ShotsViewController* controller = [ShotsViewController playerShotsViewControllerOfPlayer:player];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    [self.viewModel.reloadCommand execute:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.viewModel.players.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    YLDribbbleUser* user = (YLDribbbleUser*)self.viewModel.players[indexPath.row];
    //cell.textLabel.text = user.realName;
    RAC(cell.textLabel, text) = [RACObserve(user, realName) takeUntil:cell.rac_prepareForReuseSignal];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",user.shotsCount];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    NSLog(@"showed %ld", (long)indexPath.row);
    NSLog(@"last %u", self.viewModel.players.count - 1);
    if (indexPath.row == self.viewModel.players.count - 1) {
        [self.viewModel.loadMoreCommand execute:nil];
    }
}

@end
