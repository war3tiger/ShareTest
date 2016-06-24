//
//  ShareKit.h
//  ShareTest
//
//  Created by zyh on 16/6/22.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(int, ShareKitType) {
    ShareKitType_WxSession,
    ShareKitType_WxTimeline,
    ShareKitType_SinaWb,
    ShareKitType_QQ
};

typedef NS_ENUM(int, ShareKitMediaType) {
    ShareKitMediaType_Text,
    ShareKitMediaType_Image,
    ShareKitMediaType_Url
};

@protocol ShareKitDelegate;
@interface ShareKit : NSObject

+ (instancetype)sharedInstance;

- (void)setupShareKit;
- (void)shareWithContent:(NSString *)content
                   image:(NSData *)imageData
               thumbImage:(NSData *)thumbImage
                   title:(NSString *)title
                     url:(NSString *)urlStr
             description:(NSString *)description
                    type:(ShareKitType)type
               mediaType:(ShareKitMediaType)mediaType
                delegate:(id<ShareKitDelegate>)delegate;
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;


@end

@protocol ShareKitDelegate <NSObject>

@optional
- (void)shareResultSuccess;
- (void)shareResultFailWithError:(NSError *)error;

@end
