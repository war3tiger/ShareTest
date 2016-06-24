//
//  ShareKit.m
//  ShareTest
//
//  Created by zyh on 16/6/22.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "WXApi.h"
#import "ShareKit+WeChat.h"

#import "WeiboSDK.h"
#import "ShareKit+Sina.h"

#import "ShareKit+Internal.h"
#import "ShareKit.h"

@interface ShareKit ()
{
    __weak id<ShareKitDelegate> _resultDelegate;
}

@end

@implementation ShareKit

+ (instancetype)sharedInstance
{
    static ShareKit *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ShareKit alloc] init];
    });
    return _instance;
}

- (void)setupShareKit
{
    [WXApi registerApp:ShareKitWXAppId];
    
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    [WeiboSDK registerApp:ShareKitSinaAppKey];
}

- (void)shareWithContent:(NSString *)content
                   image:(NSData *)imageData
              thumbImage:(NSData *)thumbImage
                   title:(NSString *)title
                     url:(NSString *)urlStr
             description:(NSString *)description
                    type:(ShareKitType)type
               mediaType:(ShareKitMediaType)mediaType
                delegate:(id<ShareKitDelegate>)delegate
{
    _resultDelegate = delegate;
    if (type == ShareKitType_WxSession || type == ShareKitType_WxTimeline) {
        [self wxShareWithContent:content image:imageData thumbImage:thumbImage title:title url:urlStr type:type description:description mediaType:mediaType];
    } else if (type == ShareKitType_SinaWb) {
        [self sinaShareWithContent:content image:imageData thumbImage:thumbImage title:title url:urlStr description:description mediaType:mediaType];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url scheme] isEqualToString:ShareKitWXAppId]) {
        return [WXApi handleOpenURL:url delegate:self];
    } else if ([[url scheme] isEqualToString:[NSString stringWithFormat:@"wb%@", ShareKitSinaAppKey]]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    return NO;
}

- (void)notifyDelegateShareSuccess
{
    if ([_resultDelegate respondsToSelector:@selector(shareResultSuccess)]) {
        [_resultDelegate shareResultSuccess];
    }
}

- (void)notifyDelegateShareFailWithError:(NSError *)error
{
    if ([_resultDelegate respondsToSelector:@selector(shareResultFailWithError:)]) {
        [_resultDelegate shareResultFailWithError:error];
    }
}

@end
