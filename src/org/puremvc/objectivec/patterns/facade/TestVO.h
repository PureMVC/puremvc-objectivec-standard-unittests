//
//  ControllerTestVO.h
//  PureMVC_ObjectiveC
//
//  PureMVC Port to ObjectiveC by Brian Knorr <brian.knorr@puremvc.org>
//  PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
//

@interface TestVO : NSObject {
	int input, result, result1, result2;
}

@property int input, result, result1, result2;

+(id)testVO;

@end
