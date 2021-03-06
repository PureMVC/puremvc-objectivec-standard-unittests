//
//  SimpleCommandTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "SimpleCommandTest.h"
#import "TestVO.h"
#import "Notification.h"
#import "TestCommand.h"

@implementation SimpleCommandTest

-(void)testSimpleCommandExecute {
	
	// Create the VO
	TestVO *vo = [TestVO testVO];
	vo.input = 5;
	
	// Create the Notification (note)
	id<INotification> note = [Notification withName:@"SimpleCommandTest" body:vo];
	
	// Create the SimpleCommand              
	id<ICommand> command = [TestCommand command];
	
	[command execute:note];
	
	// test assertions
	STAssertTrue(vo.result == 10, @"result should be 10");
	
}


@end
