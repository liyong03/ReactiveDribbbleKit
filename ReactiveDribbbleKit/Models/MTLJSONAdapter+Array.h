//
//  MTLJSONAdapter+Array.h
//  Dribbb7e
//
//  Created by Yong Li on 13-12-16.
//  Copyright (c) 2013年 YongLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface MTLJSONAdapter(Array)

+ (NSArray*)modelsOfClass:(Class)modelClass fromJSONDictionaryArrat:(NSArray*)JSONDictionaryArray error:(NSError **)error;

@end
