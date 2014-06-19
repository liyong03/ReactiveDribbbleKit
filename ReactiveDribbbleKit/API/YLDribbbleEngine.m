//
//  YLDribbbleEngine.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-18.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLDribbbleEngine.h"

#import "YLDribbbleUser.h"
#import "YLDribbbleShot.h"
#import "YLDribbbleComment.h"
#import "MTLJSONAdapter+Array.h"

#import <Mantle.h>
#import <AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

const NSUInteger listPerPage = 30;
const static NSString* DribbbleAPIURL = @"http://api.dribbble.com/";

typedef void (^requestErrorBlock)(NSError* error);
typedef void (^getCompletionBlock)(id obj);

@implementation YLDribbbleEngine

#pragma mark - Player
+ (AFHTTPRequestOperation*)getPlayerWithUsername:(NSString*)username successBlock:(playerCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = [NSString stringWithFormat:@"%@", username];
    return [self sendGetRequestWithAPI:api andParameter:nil completion:^(id obj) {
        YLDribbbleUser* player = [MTLJSONAdapter modelOfClass:YLDribbbleUser.class fromJSONDictionary:obj error:nil];
        //NSLog(@"user: %@", player);
        successBlock(player);
    } error:^(NSError *error) {
        errorBlock(error);
    }];
}

+ (AFHTTPRequestOperation*)getPlayerFollowingWithUsername:(NSString*)username page:(NSInteger)page successBlock:(playerListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = [NSString stringWithFormat:@"players/%@/following", username];
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleUserList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleUserList.class])
            successBlock((YLDribbbleUserList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    } failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getPlayerFollowerWithUsername:(NSString*)username page:(NSInteger)page successBlock:(playerListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    
    NSString* api = [NSString stringWithFormat:@"players/%@/followers", username];
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleUserList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleUserList.class])
            successBlock((YLDribbbleUserList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    } failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getPlayerDrafteeWithUsername:(NSString*)username page:(NSInteger)page successBlock:(playerListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    
    NSString* api = [NSString stringWithFormat:@"players/%@/draftees", username];
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleUserList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleUserList.class])
            successBlock((YLDribbbleUserList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    } failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getPlayerShotsWithUsername:(NSString*)username page:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = [NSString stringWithFormat:@"players/%@/shots", username];
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleShotList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleShotList.class])
            successBlock((YLDribbbleShotList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    } failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getFollowingShotsWithUsername:(NSString*)username page:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = [NSString stringWithFormat:@"players/%@/shots/following", username];
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleShotList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleShotList.class])
            successBlock((YLDribbbleShotList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    } failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getLikeShotsWithUsername:(NSString*)username page:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    
    NSString* api = [NSString stringWithFormat:@"players/%@/shots/likes", username];
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleShotList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleShotList.class])
            successBlock((YLDribbbleShotList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    } failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getEveryoneShotsWithPage:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = @"shots/everyone";
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleShotList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleShotList.class])
            successBlock((YLDribbbleShotList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    } failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getPopularShotsWithPage:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = @"shots/popular";
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleShotList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleShotList.class])
            successBlock((YLDribbbleShotList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    }  failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getDebutsShotsWithPage:(NSInteger)page successBlock:(shotsListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = @"shots/debuts";
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleShotList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleShotList.class])
            successBlock((YLDribbbleShotList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    }  failedBlock:errorBlock];
}

+ (AFHTTPRequestOperation*)getCommentsOfShot:(NSUInteger)shotID withPage:(NSInteger)page successBlock:(commentListCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = [NSString stringWithFormat:@"shots/%lu/comments", shotID];
    return [self getPaginationListWithAPI:api page:page andPerpage:listPerPage andClass:YLDribbbleCommentList.class successBlock:^(YLDribbbleList *list) {
        if([list isKindOfClass:YLDribbbleCommentList.class])
            successBlock((YLDribbbleCommentList*)list);
        else {
            NSError* error = [NSError errorWithDomain:@"Engine" code:203 userInfo:nil];
            errorBlock(error);
        }
    }  failedBlock:errorBlock];
}

#pragma mark - 
+ (AFHTTPRequestOperation*)getShotWithID:(NSUInteger)shotID successBlock:(shotCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSString* api = [NSString stringWithFormat:@"shots/%lu", (unsigned long)shotID];
    return [self sendGetRequestWithAPI:api andParameter:nil completion:^(id obj) {
        YLDribbbleShot* shot = [MTLJSONAdapter modelOfClass:YLDribbbleShot.class fromJSONDictionary:obj error:nil];
        //NSLog(@"shot: %@", shot);
        successBlock(shot);
    } error:^(NSError *error) {
        errorBlock(error);
    }];
}


+ (AFHTTPRequestOperation*)getPaginationListWithAPI:(NSString*)api page:(NSInteger)page andPerpage:(NSInteger)perpage andClass:(Class)modelClass successBlock:(listCompletionBlock)successBlock failedBlock:(errorBlock)errorBlock
{
    NSDictionary* parameters = @{ @"page": @(page),
                                  @"per_page" : @(perpage)};
    return [self sendGetRequestWithAPI:api andParameter:parameters completion:^(id obj) {
        YLDribbbleList* list = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:obj error:nil];
        successBlock(list);
    } error:^(NSError *error) {
        errorBlock(error);
    }];
}

+ (AFHTTPRequestOperation*)sendGetRequestWithAPI:(NSString*)api andParameter:(NSDictionary*)parameters completion:(getCompletionBlock)completionBlock error:(requestErrorBlock)errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString* apiURL = [NSString stringWithFormat:@"%@%@", DribbbleAPIURL, api];
    return [manager GET:apiURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        completionBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"Error: %@", error);
        errorBlock(error);
    }];
}

@end
