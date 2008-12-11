//
//  ControllerTestCommand2.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ControllerTestCommand2.h"
#import "TestVO.h"

@implementation ControllerTestCommand2

-(void)execute:(id<INotification>)notification {
	TestVO *vo = [notification body];
	vo.result = vo.result + (2 * vo.input);
}

@end
