//
//  ShareKit+Internal.h
//  ShareTest
//
//  Created by zyh on 16/6/24.
//  Copyright © 2016年 SOHU. All rights reserved.
//

#import "ShareKit.h"

#define ShareKitWXAppId             @"wxd930ea5d5a258f4f"

#define ShareKitSinaAppKey          @"2045436852"
#define ShareKitSinaRedirectURI     @"https://api.weibo.com/oauth2/default.html"

@interface ShareKit (Internal)

- (void)notifyDelegateShareSuccess;
- (void)notifyDelegateShareFailWithError:(NSError *)error;

@end
