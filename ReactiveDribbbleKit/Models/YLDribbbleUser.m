//
//  YLDribbbleUser.m
//  Dribbb7e
//
//  Created by Yong Li on 13-11-30.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLDribbbleUser.h"

@implementation YLDribbbleUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userID": @"id",
             @"userName": @"username",
             @"realName": @"name",
             @"twitterID" : @"twitter_screen_name",
             @"location" : @"location",
             @"avatarURL": @"avatar_url",
             @"websiteURL" : @"website_url",
             @"shotsCount" : @"shots_count",
             @"drafteesCount" : @"draftees_count",
             @"followerCount" : @"followers_count",
             @"followingCount" : @"following_count",
             @"commentsCount" : @"comments_count",
             @"commentsReceivedCount" : @"comments_received_count",
             @"likesCount" : @"likes_count",
             @"likesReceivedCount" : @"likes_received_count",
             @"reboundsCount" : @"rebounds_count",
             @"reboundsReceivedCount" : @"rebounds_received_count",
             @"createDate" : @"created_at"
             };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss Z";
    return dateFormatter;
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)websiteURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)createDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}


#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"DribbbleUser";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
             };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"userID"];
}

+ (NSValueTransformer *)urlTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^NSString *(NSURL *url) {
        return [url description];
    } reverseBlock:^NSURL *(NSString *urlString) {
        return [NSURL URLWithString:urlString];
    }];
}

+ (NSValueTransformer *)avatarURLEntityAttributeTransformer {
    return [self urlTransformer];
}
+ (NSValueTransformer *)websiteURLEntityAttributeTransformer {
    return [self urlTransformer];
}


@end

@implementation YLDribbbleUserList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary* superPropertyKey = [super JSONKeyPathsByPropertyKey];
    NSMutableDictionary* propertyKey = [NSMutableDictionary dictionaryWithDictionary:superPropertyKey];
    [propertyKey setObject:@"players" forKey:@"players"];
    return propertyKey;
}

+ (NSValueTransformer *)playersJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:YLDribbbleUser.class];
}


@end
