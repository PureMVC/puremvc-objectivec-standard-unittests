//
//  ModelTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ModelTest.h"
#import "Model.h"
#import "Proxy.h"
#import "ModelTestProxy.h"

@implementation ModelTest

-(void)testGetInstance {
	id<IModel> model = [Model getInstance];
	STAssertTrue(model != nil, @"model should not be nil");
}

-(void)testRegisterAndRetrieveProxy {
	
	// register a proxy and retrieve it.
	id<IModel> model = [Model getInstance];
	[model registerProxy:[Proxy withProxyName:@"colors" data:[NSArray arrayWithObjects:@"red", @"green", @"blue", nil]]];
	
	id<IProxy> proxy = [model retrieveProxy:@"colors"];
	NSArray *data = [proxy getData];
	
	// test assertions
	STAssertTrue(data != nil, @"Expecting data not null");
	STAssertTrue([data count] == 3, @"Expecting [data count] == 3");
	STAssertTrue([[data objectAtIndex:0] isEqualToString:@"red"], @"shoud be red");
	STAssertTrue([[data objectAtIndex:1] isEqualToString:@"green"], @"shoud be green");
	STAssertTrue([[data objectAtIndex:2] isEqualToString:@"blue"], @"shoud be blue");
}

-(void)testRegisterAndRemoveProxy {
	
	// register a proxy, remove it, then try to retrieve it
	id<IModel> model = [Model getInstance];
	[model registerProxy:[Proxy withProxyName:@"sizes" data:[NSArray arrayWithObjects:@"7", @"13", @"21", nil]]];
	
	// remove the proxy
	id<IProxy> proxy = [model removeProxy:@"sizes"];
	
	// assert that we removed the appropriate proxy
	STAssertTrue([[proxy getProxyName] isEqualToString:@"sizes"], @"proxyName shoud be equal to 'sizes'");
	
	// ensure that the proxy is no longer retrievable from the model
	proxy = [model retrieveProxy:@"sizes"];
	
	// test assertions
	STAssertTrue(proxy == nil, @"Expecting proxy is null");
}

-(void)testHasProxy {
	
	// register a proxy
	id<IModel> model = [Model getInstance];
	[model registerProxy:[Proxy withProxyName:@"aces" data:[NSArray arrayWithObjects:@"clubs", @"spades", @"hearts", @"diamonds", nil]]];
	
	// assert that the model hasProxy method returns true
	// for that proxy name
	STAssertTrue([model hasProxy:@"aces"], @"should have proxy aces");
	
	// remove the proxy
	[model removeProxy:@"aces"];
	
	// assert that the model.hasProxy method returns false
	// for that proxy name
	STAssertFalse([model hasProxy:@"aces"], @"should not have proxy aces");
}

-(void)testOnRegisterAndOnRemove {
	
	// Get the Singleton View instance
	id<IModel> model = [Model getInstance];
	
	// Create and register the test mediator
	id<IProxy> proxy = [ModelTestProxy proxy];
	[model registerProxy:proxy];
	
	// assert that onRegsiter was called, and the proxy responded by setting its data accordingly
	STAssertTrue([[proxy getData] isEqualToString:@"onRegister called"], @"on register should be called");
	
	// Remove the component
	[model removeProxy:@"Proxy"];
	
	// assert that onRemove was called, and the proxy responded by setting its data accordingly
	STAssertTrue([[proxy getData] isEqualToString:@"onRemove called"], @"on remove should be called");
	
}





@end
