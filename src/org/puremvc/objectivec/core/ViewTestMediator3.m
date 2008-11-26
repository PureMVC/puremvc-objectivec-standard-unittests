//
//  ViewTestMediator3.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ViewTestMediator3.h"
#import "ViewTest.h"

@implementation ViewTestMediator3

-(void)handleNotification:(id<INotification>)notification {
	[self.viewComponent setLastNotification:[notification getName]];
	((ViewTest *)viewComponent).counter++;
}

-(NSArray *)listNotificationInterests {
	return [NSArray arrayWithObject:@"Notification3"];
}

@end
