//
//  ShotCell.m
//  ReactiveDribbbleKitDemo
//
//  Created by Yong Li on 6/27/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "ShotCell.h"
#import <ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ShotCell {
    UIImageView* _imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_imageView];
        
        @weakify(self)
        [RACObserve(self, shot) subscribeNext:^(id x) {
            @strongify(self)
            [_imageView setImageWithURL:self.shot.imageTeaserURL
                       placeholderImage:nil
                                options:SDWebImageProgressiveDownload
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   NSLog(@"%f for: %@", receivedSize/(float)expectedSize, self.shot.imageURL);
                               } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                   
                               }];
        }];
        
        [[self rac_signalForSelector:@selector(prepareForReuse)] subscribeNext:^(id x) {
            NSLog(@"prepare for reuse");
            [_imageView cancelCurrentImageLoad];
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
