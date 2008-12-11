//
//  ViewTestMediator6.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ViewTestMediator6.h"
#import "Facade.h"
#import	"ViewTest.h"

@implementation ViewTestMediator6

-(void)handleNotification:(id<INotification>)notification {
	[[Facade getInstance] removeMediator:[self mediatorName]];
}

-(NSArray *)listNotificationInterests {
	return [NSArray arrayWithObject:@"Notification6"];
}

-(void)onRemove {
	((ViewTest *)viewComponent).counter++;
}

@end
