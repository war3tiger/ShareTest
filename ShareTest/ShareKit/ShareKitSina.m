//
//  ShareKitSina.m
//  ShareTest
//
//  Created by zyh on 16/6/27.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "WeiboSDK.h"

#import "ShareKit+Internal.h"
#import "ShareKitSina.h"

@interface ShareKitSina ()
<WeiboSDKDelegate>

@end

@implementation ShareKitSina

+ (instancetype)sharedInstance
{
    static ShareKitSina *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ShareKitSina alloc] init];
    });
    return _instance;
}

- (void)setupWithAppKey:(NSString *)appKey
{
#if DEBUG
    [WeiboSDK enableDebugMode:YES];
#endif
    [WeiboSDK registerApp:appKey];
}

- (void)shareWithContent:(NSString *)content
                   image:(NSData *)image
              thumbImage:(NSData *)thumbImage
                   title:(NSString *)title
                     url:(NSString *)urlStr
             description:(NSString *)description
               mediaType:(ShareKitMediaType)mediaType
{
    //    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    //    authRequest.redirectURI = ShareKitSinaRedirectURI;
    //    authRequest.scope = @"all";
    //    [WeiboSDK sendRequest:authRequest];
    //    return;
    
    WBMessageObject *message = [WBMessageObject message];
    
    switch (mediaType) {
        case ShareKitMediaType_Text:
        {
            message.text = content;
            break;
        }
        case ShareKitMediaType_Image:
        {
            WBImageObject *imageObj = [WBImageObject object];
            imageObj.imageData = image;
            message.imageObject = imageObj;
            break;
        }
        case ShareKitMediaType_Url:
        {
            WBWebpageObject *webpage = [WBWebpageObject object];
            webpage.objectID = @"identifier1";
            webpage.title = title;
            webpage.description = description;
            webpage.thumbnailData = thumbImage;
            webpage.webpageUrl = urlStr;
            message.mediaObject = webpage;
            break;
        }
        default:
            message = nil;
            break;
    }
    if (message) {
        //        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:[self sinaWbToken]];
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
    }
}

- (BOOL)handleOpenUrl:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        if (sendMessageToWeiboResponse.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            [[ShareKit sharedInstance] notifyDelegateShareSuccess];
        } else {
            NSString *errorStr = @"未知错误";
            NSError *error = [NSError errorWithDomain:errorStr code:sendMessageToWeiboResponse.statusCode userInfo:nil];
            [[ShareKit sharedInstance] notifyDelegateShareFailWithError:error];
        }
    }
}

@end
