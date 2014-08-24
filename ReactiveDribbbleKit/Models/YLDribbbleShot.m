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

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"DribbbleShot";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
             @"reboundSourceID" : [NSNull null],
             };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"shotID"];
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"player" : YLDribbbleUser.class
             };
}

+ (NSValueTransformer *)urlTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^NSString *(NSURL *url) {
        return [url description];
    } reverseBlock:^NSURL *(NSString *urlString) {
        return [NSURL URLWithString:urlString];
    }];
}

+ (NSValueTransformer *)urlEntityAttributeTransformer {
    return [self urlTransformer];
}
+ (NSValueTransformer *)shortURLEntityAttributeTransformer {
    return [self urlTransformer];
}
+ (NSValueTransformer *)imageURLEntityAttributeTransformer {
    return [self urlTransformer];
}
+ (NSValueTransformer *)imageTeaserURLEntityAttributeTransformer {
    return [self urlTransformer];
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

#pragma mark - MTLManagedObjectSerializing

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    NSDictionary* relations = [super relationshipModelClassesByPropertyKey];
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithDictionary:relations];
    [result setObject:YLDribbbleShot.class forKey:@"shots"];
    return result;
}

@end
