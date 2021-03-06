//
//  ShotsViewController.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/27/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "ShotsViewController.h"
#import "YLShotsViewModel.h"
#import "ShotCell.h"
#import "CommentsViewController.h"
#import <SVProgressHUD.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface ShotsViewController ()

@property(nonatomic, strong) YLDribbbleUser* player;
@property(nonatomic, strong) YLShotsViewModel* viewModel;

@end

@implementation ShotsViewController

+ (ShotsViewController*)playerShotsViewControllerOfPlayer:(YLDribbbleUser*)player {
    return [[self alloc] initWithPlayer:player];
}

- (id)initWithPlayer:(YLDribbbleUser*)user
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(145, 100);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // Custom initialization
        self.title = @"Player Shots";
        _player = user;
        _viewModel = [YLShotsViewModel playerShotsViewModelOfPlayer:_player];
    }
    return self;
}


+ (ShotsViewController*)popularShotsViewController {
    return [[ShotsViewController alloc] initPopularController];
}

- (id)initPopularController
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(145, 100);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        // Custom initialization
        self.title = @"Popular Shots";
        _player = nil;
        _viewModel = [YLShotsViewModel popularShotsViewModel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:ShotCell.class forCellWithReuseIdentifier:@"ShotCell"];
    [SVProgressHUD appearance].hudBackgroundColor = [UIColor blackColor];
    [SVProgressHUD appearance].hudForegroundColor = [UIColor whiteColor];
    
    
    @weakify(self);
    [RACObserve(self.viewModel, shots) subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    [RACObserve(self.viewModel, loading) subscribeNext:^(NSNumber *loading){
        if (loading.boolValue) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    }];
    
    [[self rac_signalForSelector:@selector(collectionView:cellForItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(RACTuple *arguments) {
        @strongify(self);
        
        NSIndexPath* indexPath = arguments.second;
        NSLog(@"showed %ld", (long)indexPath.row);
        NSLog(@"last %lu", self.viewModel.shots.count - 1);
        if (indexPath.row == self.viewModel.shots.count-1) {
            [self.viewModel.loadMoreCommand execute:nil];
        }
    }];
    
    [[self rac_signalForSelector:@selector(collectionView:didSelectItemAtIndexPath:) fromProtocol:@protocol(UICollectionViewDelegate)] subscribeNext:^(RACTuple *arguments) {
        
        @strongify(self);
        
        NSIndexPath* indexPath = arguments.second;
        YLDribbbleShot* shot = self.viewModel.shots[indexPath.row];
        CommentsViewController* controller = [CommentsViewController commentsViewControllerOfShot:shot];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    [self.viewModel.loadCacheCommand execute:nil];
    [self.viewModel.reloadCommand execute:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.shots.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShotCell" forIndexPath:indexPath];
    cell.shot = self.viewModel.shots[indexPath.row];
    
    return cell;
}

@end
