//
//  ShareKit.m
//  ShareTest
//
//  Created by zyh on 16/6/22.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "ShareKitWx.h"
#import "ShareKitSina.h"
#import "ShareKitQQ.h"

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
    [[ShareKitWx sharedInstance] setupWithAppId:ShareKitWXAppId];
    [[ShareKitSina sharedInstance] setupWithAppKey:ShareKitSinaAppKey];
    [[ShareKitQQ sharedInstance] setupWithAppId:ShareKitQQAppId];
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
        [[ShareKitWx sharedInstance] shareWithContent:content image:imageData thumbImage:thumbImage title:title url:urlStr type:type description:description mediaType:mediaType];
    } else if (type == ShareKitType_SinaWb) {
        [[ShareKitSina sharedInstance] shareWithContent:content image:imageData thumbImage:thumbImage title:title url:urlStr description:description mediaType:mediaType];
    } else if (type == ShareKitType_QQ) {
        [[ShareKitQQ sharedInstance] shareWithContent:content image:imageData thumbImage:thumbImage title:title url:urlStr description:description mediaType:mediaType];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url scheme] isEqualToString:ShareKitWXAppId]) {
        return [[ShareKitWx sharedInstance] handleOpenUrl:url];
    } else if ([[url scheme] isEqualToString:[NSString stringWithFormat:@"wb%@", ShareKitSinaAppKey]]) {
        return [[ShareKitSina sharedInstance] handleOpenUrl:url];
    } else if ([[url scheme] isEqualToString:[NSString stringWithFormat:@"tencent%@", ShareKitQQAppId]]) {
        return [[ShareKitQQ sharedInstance] handleOpenUrl:url];
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
