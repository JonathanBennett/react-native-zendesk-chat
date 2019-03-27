#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RNZendeskChatModule : RCTEventEmitter<RCTBridgeModule>
+ (id)allocWithZone:(NSZone *)zone;
- (void)chatEventReceived:(NSNumber *)messageCount;
@end
