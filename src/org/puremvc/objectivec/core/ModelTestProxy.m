//
//  ModelTestProxy.m
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

#import "ModelTestProxy.h"


@implementation ModelTestProxy

-(void)onRegister {
	self.data = @"onRegister called";
}

-(void)onRemove {
	self.data = @"onRemove called";
}

@end
