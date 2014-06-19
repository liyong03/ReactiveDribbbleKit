//
//  MTLJSONAdapter+Array.m
//  Dribbb7e
//
//  Created by Yong Li on 13-12-16.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import "MTLJSONAdapter+Array.h"

@implementation MTLJSONAdapter(Array)


+ (NSArray*)modelsOfClass:(Class)modelClass fromJSONDictionaryArrat:(NSArray*)JSONDictionaryArray error:(NSError **)error
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:JSONDictionaryArray.count];
    for(NSDictionary* jsonDict in JSONDictionaryArray) {
        id obj = [self modelOfClass:modelClass fromJSONDictionary:jsonDict error:error];
        if(error)
            return array;
        [array addObject:obj];
    }
    return array;
}

@end
