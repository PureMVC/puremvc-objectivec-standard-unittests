//
//  ViewTest.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ViewTest.h"
#import "View.h"
#import "Observer.h"
#import "Notification.h"
#import "Mediator.h"
#import "ViewTestMediator.h"
#import "ViewTestMediator3.h"
#import "ViewTestMediator6.h"

@implementation ViewTest

@synthesize onRegisterCalled, onRemoveCalled, lastNotification, counter;

-(void)testGetInstance {
	id<IView> view = [View getInstance];
	STAssertTrue(view != nil, @"view should not be nil");
}

-(void)viewTestMethod:(id<INotification>)notification {
	// set the local viewTestVar to the number on the event payload
	viewTestVar = [notification body];
}


-(void)testRegisterAndNotifyObserver {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create observer, passing in notification method and context
	id<IObserver> observer = [Observer withNotifyMethod:@selector(viewTestMethod:) notifyContext:self];
	
	// Register Observer's interest in a particulat Notification with the View 
	[view registerObserver:@"ViewTestNote" observer:observer];
	
	// Create a ViewTestNote, setting 
	// a body value, and tell the View to notify 
	// Observers. Since the Observer is this class 
	// and the notification method is viewTestMethod,
	// successful notification will result in our local 
	// viewTestVar being set to the value we pass in 
	// on the note body.
	id<INotification> note = [Notification withName:@"ViewTestNote" body:@"10"];
	[view notifyObservers:note];
	
	// test assertions 
	STAssertTrue([viewTestVar isEqualToString:@"10"], @"viewTestVar should be 10");
}

-(void)testRegisterAndRetrieveMediator {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> viewTestMediator = [Mediator withMediatorName:@"ViewTestMediator" viewComponent:self];
	[view registerMediator:viewTestMediator];
	
	// Retrieve the component
	id<IMediator> mediator = [view retrieveMediator:@"ViewTestMediator"];
	
	// test assertions              
	STAssertTrue([mediator isEqualTo:viewTestMediator], "should be the same mediator");
}

-(void)testHasMediator {
	
	// register a Mediator
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> mediator = [Mediator withMediatorName:@"hasMediatorTest" viewComponent:self];
	[view registerMediator:mediator];
	
	// assert that the view.hasMediator method returns true
	// for that mediator name
	STAssertTrue([view hasMediator:@"hasMediatorTest"], @"view should have mediator");
	
	[view removeMediator:@"hasMediatorTest"];
	
	// assert that the view.hasMediator method returns false
	// for that mediator name
	STAssertFalse([view hasMediator:@"hasMediatorTest"], @"view should not have mediator");
}

-(void)testRegisterAndRemoveMediator {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> mediator = [Mediator withMediatorName:@"testing" viewComponent:self];
	[view registerMediator:mediator];
	
	// Remove the component
	id<IMediator> removeMediator = [view removeMediator:@"testing"];
	
	// assert that we have removed the appropriate mediator
	STAssertTrue([[removeMediator mediatorName] isEqualToString:@"testing"], @"name should be testing");
	
	// assert that the mediator is no longer retrievable
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"retrieve mediator should be nil");
}

-(void)testOnRegisterAndOnRemove {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator
	id<IMediator> mediator = [ViewTestMediator withMediatorName:@"testing" viewComponent:self];
	[view registerMediator:mediator];
	
	// assert that onRegsiter was called, and the mediator responded by setting our boolean
	STAssertTrue(onRegisterCalled, @"onRegisterCalled should be YES");
	
	// Remove the component
	[view removeMediator:@"testing"];
	
	// assert that the mediator is no longer retrievable
	STAssertTrue(onRemoveCalled, @"onRemoveCalled should be YES");
}

-(void)testSuccessiveRegisterAndRemoveMediator {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator, 
	// but not so we have a reference to it
	id<IMediator> mediator = [ViewTestMediator withMediatorName:@"testing" viewComponent:self];
	[view registerMediator:mediator];
	
	// test that we can retrieve it
	STAssertTrue([view retrieveMediator:@"testing"] != nil, @"mediator should not be nil");
	
	// Remove the Mediator
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");
	
	// test that removing the mediator again once its gone doesn't cause crash         
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should again be nil");
	
	//register again instance of the test mediator, 
	[view registerMediator:mediator];
	
	STAssertTrue([view retrieveMediator:@"testing"] != nil, @"mediator should not be nil");
	
	// Remove the Mediator
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");                                     
}

-(void)testRemoveMediatorAndSubsequentNotify {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register the test mediator to be removed.
	id<IMediator> mediator = [ViewTestMediator withMediatorName:@"testing" viewComponent:self];
	[view registerMediator:mediator];
	
	// test that notifications work
	[view notifyObservers:[Notification withName:@"Notification1"]];
	STAssertTrue([lastNotification isEqualToString:@"Notification1"], @"should be equal to Notification1");
	
	[view notifyObservers:[Notification withName:@"Notification2"]];
	STAssertTrue([lastNotification isEqualToString:@"Notification2"], @"should be equal to Notification2");
	
	// Remove the Mediator
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");
	
	// test that notifications no longer work
	// (ViewTestMediator2 is the one that sets lastNotification
	// on this component, and ViewTestMediator)
	self.lastNotification = nil;
	
	[view notifyObservers:[Notification withName:@"Notification1"]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");
	
	[view notifyObservers:[Notification withName:@"Notification2"]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");                                     
}

-(void)testRemoveOneOfTwoMediatorsAndSubsequentNotify {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register that responds to notifications 1 and 2
	id<IMediator> mediator = [ViewTestMediator withMediatorName:@"testing" viewComponent:self];
	[view registerMediator:mediator];
	
	// Create and register that responds to notification 3
	id<IMediator> mediator3 = [ViewTestMediator3 withMediatorName:@"testing3" viewComponent:self];
	[view registerMediator:mediator3];
	
	// test that all notifications work
	[view notifyObservers:[Notification withName:@"Notification1"]];
	STAssertTrue([lastNotification isEqualToString:@"Notification1"], @"should be equal to Notification1");
	
	[view notifyObservers:[Notification withName:@"Notification2"]];
	STAssertTrue([lastNotification isEqualToString:@"Notification2"], @"should be equal to Notification2");
	
	[view notifyObservers:[Notification withName:@"Notification3"]];
	STAssertTrue([lastNotification isEqualToString:@"Notification3"], @"should be equal to Notification3");
	
	// Remove the Mediator that responds to 1 and 2
	[view removeMediator:@"testing"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing"] == nil, @"mediator should be nil");
	
	// test that notifications no longer work
	// for notifications 1 and 2, but still work for 3
	self.lastNotification = nil;
	
	[view notifyObservers:[Notification withName:@"Notification1"]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");
	
	[view notifyObservers:[Notification withName:@"Notification2"]];
	STAssertTrue(lastNotification == nil, @"lastNotification should be nil");  
	
	[view notifyObservers:[Notification withName:@"Notification3"]];
	STAssertTrue([lastNotification isEqualToString:@"Notification3"], @"should be equal to Notification3");                                     
}

-(void)testMediatorReregistration {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register that responds to notification 3
	id<IMediator> mediator3 = [ViewTestMediator3 withMediatorName:@"testing3" viewComponent:self];
	[view registerMediator:mediator3];

	
	// try to register another.
	[view registerMediator:mediator3];
	
	// test that the counter is only incremented once (mediator 3's response) 
	counter = 0;
	[view notifyObservers:[Notification withName:@"Notification3"]];
	STAssertTrue(counter == 1, @"counter should be 1");
	
	// Remove the Mediator 
	[view removeMediator:@"testing3"];
	
	// test that retrieving it now returns null            
	STAssertTrue([view retrieveMediator:@"testing3"] == nil, @"mediator should be nil");
	
	// test that the counter is no longer incremented  
	counter = 0;
	[view notifyObservers:[Notification withName:@"Notification3"]];
	STAssertTrue(counter == 0, @"counter should be 0");
}

-(void)testModifyObserverListDuringNotification {
	
	// Get the Singleton View instance
	id<IView> view = [View getInstance];
	
	// Create and register several mediator instances that respond to notification 6 
	// by removing themselves, which will cause the observer list for that notification 
	// to change. versions prior to Standard Version 2.0.4 will see every other mediator
	// fails to be notified.  
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing1" viewComponent:self]];
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing2" viewComponent:self]];
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing3" viewComponent:self]];
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing4" viewComponent:self]];
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing5" viewComponent:self]];
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing6" viewComponent:self]];
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing7" viewComponent:self]];
	[view registerMediator:[ViewTestMediator6 withMediatorName:@"testing8" viewComponent:self]];
	
	// clear the counter
	counter = 0;
	// send the notification. each of the above mediators will respond by removing
	// themselves and incrementing the counter by 1. This should leave us with a
	// count of 8, since 8 mediators will respond.
	[view notifyObservers:[Notification withName:@"Notification6"]];
	// verify the count is correct
	STAssertTrue(counter == 8, @"counter should be 8");
    
	// test that the counter is no longer incremented
	counter = 0;
	[view notifyObservers:[Notification withName:@"Notification6"]];
	STAssertTrue(counter == 0, @"counter should be 0");
}

@end
