//
//  ShareKit+WeChat.m
//  ShareTest
//
//  Created by zyh on 16/6/23.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "WXApi.h"
#import "ShareKit+Internal.h"
#import "ShareKit+WeChat.h"

@implementation ShareKit (WeChat)

- (void)wxShareWithContent:(NSString *)content
                     image:(NSData *)image
                thumbImage:(NSData *)thumbImage
                     title:(NSString *)title
                       url:(NSString *)urlStr
                      type:(ShareKitType)type
               description:(NSString *)description
                 mediaType:(ShareKitMediaType)mediaType
{
    int scene = (type == ShareKitType_WxSession) ? WXSceneSession : WXSceneTimeline;
    switch (mediaType) {
        case ShareKitMediaType_Text:
        {
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = YES;
            req.scene = scene;
            req.text = content;
            [WXApi sendReq:req];
            break;
        }
        case ShareKitMediaType_Image:
        {
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = image;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = title;
            message.description = description;
            message.mediaObject = ext;
            message.thumbData = thumbImage;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.scene = scene;
            req.message = message;
            [WXApi sendReq:req];
            break;
        }
        case ShareKitMediaType_Url:
        {
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = urlStr;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = title;
            message.description = description;
            message.mediaObject = ext;
            message.thumbData = thumbImage;
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.scene = scene;
            req.message = message;
            [WXApi sendReq:req];
            break;
        }
        default:
            break;
    }
}

#pragma mark - WXApiDelegate
-(void)onReq:(BaseReq*)req
{
    
}

-(void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (resp.errCode == WXSuccess) {
            [self notifyDelegateShareSuccess];
        } else {
            NSString *errorStr = @"未知错误";
            if ([resp.errStr isKindOfClass:[NSString class]] && resp.errStr.length > 0) {
                errorStr = resp.errStr;
            }
            NSError *error = [NSError errorWithDomain:errorStr code:resp.errCode userInfo:nil];
            [self notifyDelegateShareFailWithError:error];
        }
    }
}

@end
