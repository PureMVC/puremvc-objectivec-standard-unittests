//
//  ProxyTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ProxyTest.h"
#import "Proxy.h"

@implementation ProxyTest

-(void)testConstructor {
	
	// Create a new Proxy using the Constructor to set the name and data
	id<IProxy> proxy = [Proxy withProxyName:@"colors" data:[NSArray arrayWithObjects:@"red", @"green", @"blue", nil]];
	NSArray *data = [proxy data];
	
	// test assertions
	STAssertTrue(proxy != nil, @"Expecting proxy not null");
	STAssertTrue([[proxy proxyName] isEqualToString:@"colors"], @"proxy name should be colors");
	STAssertTrue(data != nil, @"Expecting data not null");
	STAssertTrue([data count] == 3, @"Expecting [data count] == 3");
	STAssertTrue([[data objectAtIndex:0] isEqualToString:@"red"], @"shoud be red");
	STAssertTrue([[data objectAtIndex:1] isEqualToString:@"green"], @"shoud be green");
	STAssertTrue([[data objectAtIndex:2] isEqualToString:@"blue"], @"shoud be blue");
}


@end
