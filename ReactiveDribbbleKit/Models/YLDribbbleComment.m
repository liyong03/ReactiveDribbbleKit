//
//  YLDribbbleComment.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-16.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "YLDribbbleComment.h"

@implementation YLDribbbleComment
{
    NSAttributedString* _attributedBody;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"shotID": @"id",
             @"body": @"body",
             @"likesCount" : @"likes_count",
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

@implementation YLDribbbleCommentList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary* superPropertyKey = [super JSONKeyPathsByPropertyKey];
    NSMutableDictionary* propertyKey = [NSMutableDictionary dictionaryWithDictionary:superPropertyKey];
    [propertyKey setObject:@"comments" forKey:@"comments"];
    return propertyKey;
}

+ (NSValueTransformer *)commentsJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:YLDribbbleComment.class];
}


@end
