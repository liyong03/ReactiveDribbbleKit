//
//  CommentsViewController.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/28/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "CommentsViewController.h"
#import "YLCommentsViewModel.h"
#import "YLDribbbleComment.h"
#import "YLDribbbleShot.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa.h>

@interface CommentsViewController ()

@property (nonatomic, strong) YLDribbbleShot* shot;
@property (nonatomic, strong) YLCommentsViewModel* viewModel;

@end

@implementation CommentsViewController

+ (CommentsViewController*)commentsViewControllerOfShot:(YLDribbbleShot*)shot {
    return [[CommentsViewController alloc] initWithShot:shot];
}

- (id)initWithShot:(YLDribbbleShot*)shot
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        _shot = shot;
        _viewModel = [YLCommentsViewModel shotsCommentsViewModelWithShotID:shot.shotID];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SVProgressHUD appearance].hudBackgroundColor = [UIColor blackColor];
    [SVProgressHUD appearance].hudForegroundColor = [UIColor whiteColor];
    
    self.title = @"Shot comments list";

    @weakify(self);
    [RACObserve(self.viewModel, comments) subscribeNext:^(id x) {
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
    return self.viewModel.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    YLDribbbleComment* comment = (YLDribbbleComment*)self.viewModel.comments[indexPath.row];
    cell.textLabel.text = comment.player.realName;
    cell.detailTextLabel.text = comment.body;
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    NSLog(@"showed %ld", (long)indexPath.row);
    NSLog(@"last %u", self.viewModel.comments.count - 1);
    if (indexPath.row == self.viewModel.comments.count - 1) {
        [self.viewModel.loadMoreCommand execute:nil];
    }
}
@end
