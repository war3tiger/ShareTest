//
//  ShareKitQQ.m
//  ShareTest
//
//  Created by zyh on 16/6/27.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "ShareKit+Internal.h"
#import "ShareKitQQ.h"

@interface ShareKitQQ ()
<QQApiInterfaceDelegate>

@end

@implementation ShareKitQQ

+ (instancetype)sharedInstance
{
    static ShareKitQQ *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ShareKitQQ alloc] init];
    });
    return _instance;
}

- (void)setupWithAppId:(NSString *)appId
{
    TencentOAuth *qqOauth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:nil];
}

- (void)shareWithContent:(NSString *)content
                   image:(NSData *)image
              thumbImage:(NSData *)thumbImage
                   title:(NSString *)title
                     url:(NSString *)urlStr
             description:(NSString *)description
               mediaType:(ShareKitMediaType)mediaType
{
    switch (mediaType) {
        case ShareKitMediaType_Text:
        {
            QQApiTextObject *txtObj = [QQApiTextObject objectWithText:content];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
            [QQApiInterface sendReq:req];
            break;
        }
        case ShareKitMediaType_Image:
        {
            QQApiImageObject *imgObj = [QQApiImageObject objectWithData:image
                                                       previewImageData:thumbImage
                                                                  title:title
                                                           description :description];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
            [QQApiInterface sendReq:req];
            break;
        }
        case ShareKitMediaType_Url:
        {
            QQApiNewsObject *newsObj = [QQApiNewsObject
                                        objectWithURL:[NSURL URLWithString:urlStr]
                                        title:title
                                        description:description previewImageData:thumbImage];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            [QQApiInterface sendReq:req];
            
            break;
        }
            
        default:
            break;
    }
}

- (BOOL)handleOpenUrl:(NSURL *)url
{
    return [QQApiInterface handleOpenURL:url delegate:self];
}

#pragma mark -QQApiInterfaceDelegate
- (void)onReq:(QQBaseReq *)req
{
    
}

- (void)onResp:(QQBaseResp *)resp
{
    NSString *errorStr = @"未知错误";
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        if ([resp.result isKindOfClass:[NSString class]]) {
            int resultCode = [resp.result intValue];
            if (resultCode == 0) {
                [[ShareKit sharedInstance] notifyDelegateShareSuccess];
                return;
            }
        }
        if (resp.errorDescription) {
            errorStr = resp.errorDescription;
        }
    }
    NSError *error = [NSError errorWithDomain:errorStr code:[resp.result intValue] userInfo:nil];
    [[ShareKit sharedInstance] notifyDelegateShareFailWithError:error];
}

- (void)isOnlineResponse:(NSDictionary *)response
{
    
}

@end
