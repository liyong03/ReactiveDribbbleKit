//
//  YLDribbbleShot.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-16.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLDribbbleShot.h"

@implementation YLDribbbleShot


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"shotID": @"id",
             @"title": @"title",
             @"url": @"url",
             @"shortURL": @"short_url",
             @"imageURL" : @"image_url",
             @"imageTeaserURL" : @"image_teaser_url",
             @"width" : @"width",
             @"height" : @"height",
             @"viewsCount" : @"views_count",
             @"likesCount" : @"likes_count",
             @"commentsCount" : @"comments_count",
             @"reboundsCount" : @"rebounds_count",
             @"reboundSourceID" : @"rebound_source_id",
             @"createDate" : @"created_at",
             @"player" : @"player"
             };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss Z";
    return dateFormatter;
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


+ (NSValueTransformer *)shortURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


+ (NSValueTransformer *)imageURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)imageTeaserURLJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)playerJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:YLDribbbleUser.class];
}

+ (NSValueTransformer *)createDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [self.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end

@implementation YLDribbbleShotList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary* superPropertyKey = [super JSONKeyPathsByPropertyKey];
    NSMutableDictionary* propertyKey = [NSMutableDictionary dictionaryWithDictionary:superPropertyKey];
    [propertyKey setObject:@"shots" forKey:@"shots"];
    return propertyKey;
}

+ (NSValueTransformer *)shotsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:YLDribbbleShot.class];
}


@end
