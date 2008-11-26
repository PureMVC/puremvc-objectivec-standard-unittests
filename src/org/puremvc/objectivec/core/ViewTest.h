//
//  ViewTest.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface ViewTest : SenTestCase {
	NSString *viewTestVar, *lastNotification;
	BOOL onRegisterCalled, onRemoveCalled;
	int counter;
}

@property BOOL onRegisterCalled, onRemoveCalled;
@property(nonatomic, retain) NSString *lastNotification;
@property int counter;

@end
