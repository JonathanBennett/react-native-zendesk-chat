//
//  RNZendeskChat.m
//  Tasker
//
//  Created by Jean-Richard Lai on 11/23/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

#import "RNZendeskChatModule.h"
#import <ZDCChat/ZDCChat.h>

@implementation RNZendeskChatModule

RCT_EXPORT_MODULE(RNZendeskChatModule);

RCT_EXPORT_METHOD(setVisitorInfo:(NSDictionary *)options) {
  [ZDCChat updateVisitor:^(ZDCVisitorInfo *visitor) {
    if (options[@"name"]) {
      visitor.name = options[@"name"];
    }
    if (options[@"email"]) {
      visitor.email = options[@"email"];
    }
    if (options[@"phone"]) {
      visitor.phone = options[@"phone"];
    }
    visitor.shouldPersist = options[@"shouldPersist"] || NO;
  }];
}

RCT_EXPORT_METHOD(startChat:(NSDictionary *)options) {
  UIView *statusBar = (UIView *)[[UIApplication sharedApplication] valueForKey:@"statusBar"];
  statusBar.backgroundColor = [[UIColor alloc] initWithRed:0 green:(190.0/255.0) blue:(179.0/255.0) alpha:1.0];
  NSDictionary *navbarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor] ,NSForegroundColorAttributeName, nil];
  [[UINavigationBar appearance] setTitleTextAttributes:navbarAttributes];
  [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
  [[UINavigationBar appearance] setBarTintColor:[[UIColor alloc] initWithRed:0 green:(190.0/255.0) blue:(179.0/255.0) alpha:1.0]];
  [[ZDCChatOverlay appearance] setInsets:[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(75.0f, 15.0f, 70.0f, 15.0f)]];

  [self setVisitorInfo:options];

  dispatch_sync(dispatch_get_main_queue(), ^{
    [ZDCChat startChat:^(ZDCConfig *config) {
      if (options[@"department"]) {
        config.department = options[@"department"];
      }
      if (options[@"tags"]) {
        config.tags = options[@"tags"];
      }
      config.preChatDataRequirements.name       = ZDCPreChatDataRequired;
      config.preChatDataRequirements.email      = options[@"emailNotRequired"] ? ZDCPreChatDataNotRequired : ZDCPreChatDataRequired;
      config.preChatDataRequirements.phone      = options[@"phoneNotRequired"] ? ZDCPreChatDataNotRequired : ZDCPreChatDataRequired;
      config.preChatDataRequirements.department = ZDCPreChatDataOptional;
      config.preChatDataRequirements.message    = ZDCPreChatDataOptional;
    }];
  });
}

@end
