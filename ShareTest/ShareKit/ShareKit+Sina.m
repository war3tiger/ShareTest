//
//  ShareKit+Sina.m
//  ShareTest
//
//  Created by zyh on 16/6/24.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import <objc/runtime.h>

#import "WeiboSDK.h"
#import "ShareKit+Internal.h"

#import "ShareKit+Sina.h"

static char shareKitSinaToken;
@implementation ShareKit (Sina)

- (void)sinaShareWithContent:(NSString *)content
                       image:(NSData *)image
                  thumbImage:(NSData *)thumbImage
                       title:(NSString *)title
                         url:(NSString *)urlStr
                 description:(NSString *)description
                   mediaType:(ShareKitMediaType)mediaType
{
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = ShareKitSinaRedirectURI;
    authRequest.scope = @"all";
    [WeiboSDK sendRequest:authRequest];
    return;
    
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
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:[self sinaWbToken]];
//        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
    }
}

- (NSString *)sinaWbToken
{
    return objc_getAssociatedObject(self, &shareKitSinaToken);
}

- (void)setSinaWbToken:(NSString *)wbToken
{
    objc_setAssociatedObject(self, &shareKitSinaToken, wbToken, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:[WBSendMessageToWeiboResponse class]]) {
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        int a = 0;
    }
}

@end
