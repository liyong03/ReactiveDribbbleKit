//
//  ReactiveDribbbleKitDemoTests.m
//  ReactiveDribbbleKitDemoTests
//
//  Created by Yong Li on 6/19/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "YLDribbbleEngine.h"
#import "YLReactiveDribbbleEngine.h"

@interface ReactiveDribbbleKitDemoTests : XCTestCase

@end

@implementation ReactiveDribbbleKitDemoTests {
    OCMockObject* _mockDribbbleEngine;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _mockDribbbleEngine = [OCMockObject mockForClass:[YLDribbbleEngine class]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testGetProfileName
{
    void (^theBlock)(NSInvocation *) = ^(NSInvocation *invocation) {
        void (^passedBlock)( YLDribbbleUser* user );
        [invocation getArgument:&passedBlock atIndex:3];
        //NSString* str = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"getPlayer" withExtension:@"json"] encoding:NSUTF8StringEncoding error:nil];
        NSURL* url = [[NSBundle bundleForClass:self.class] URLForResource:@"getPlayer" withExtension:@"json"];
        NSData* data = [NSData dataWithContentsOfURL:url];
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        YLDribbbleUser* player = [MTLJSONAdapter modelOfClass:YLDribbbleUser.class fromJSONDictionary:obj error:nil];
        passedBlock(player);
    };
    [[[_mockDribbbleEngine stub] andDo:theBlock] getPlayerWithUsername:[OCMArg any] successBlock:[OCMArg any] failedBlock:[OCMArg any]];
    __block YLDribbbleUser* user = nil;
    [[YLReactiveDribbbleEngine getPlayerWithUsername:@""] subscribeNext:^(id x) {
        user = x;
    }];
    
    XCTAssert(user.userID == 1);
}

@end
