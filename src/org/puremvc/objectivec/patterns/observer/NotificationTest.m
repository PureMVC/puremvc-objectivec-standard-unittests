//
//  NotificationTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "NotificationTest.h"
#import "Notification.h"

@implementation NotificationTest

-(void)testConstructor {
	
	// Create a new Notification and use accessors to set the note name 
	id<INotification> note = [Notification withName:@"TestNote" body:@"5" type:@"TestType"];
	
	// test assertions
	STAssertTrue([[note name] isEqualToString:@"TestNote"], @"name should be TestNote");
	STAssertTrue([[note body] isEqualToString:@"5"], @"body should be 5");
	STAssertTrue([[note type] isEqualToString:@"TestType"], @"type should be TestType");
}

@end
