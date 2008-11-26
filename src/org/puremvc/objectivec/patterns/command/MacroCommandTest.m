//
//  MacroCommandTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "MacroCommandTest.h"
#import "TestVO.h"
#import	"Notification.h"
#import "MacroCommandTestCommand.h"

@implementation MacroCommandTest

-(void)testMacroCommandExecute {
	
	// Create the VO
	TestVO *vo = [TestVO testVO];
	vo.input = 5;
	
	// Create the Notification (note)
	id<INotification> note = [Notification withName:@"MacroCommandTest" body:vo];
	
	// Create the MacroCommand     
	id<ICommand> command = [MacroCommandTestCommand command];
	
	// Execute the MacroCommand
	[command execute:note];
	
	// test assertions
	STAssertTrue(vo.result1 == 10, @"result1 should be 10");
	STAssertTrue(vo.result2 == 25, @"result2 should be 25");
}


@end
