//
//  ViewTestMediator.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ViewTestMediator.h"

@implementation ViewTestMediator

-(void)onRegister {
	[self.viewComponent setOnRegisterCalled:YES];
}

-(void)onRemove {
	[self.viewComponent setOnRemoveCalled:YES];
}

-(void)handleNotification:(id<INotification>)notification {
	[self.viewComponent setLastNotification:[notification getName]];
}

-(NSArray *)listNotificationInterests {
	return [NSArray arrayWithObjects:@"Notification1", @"Notification2", nil];
}

@end
