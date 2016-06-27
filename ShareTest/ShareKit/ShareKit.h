//
//  ShareKit.h
//  ShareTest
//
//  Created by zyh on 16/6/22.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "ShareKitConstant.h"

#import <UIKit/UIKit.h>

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
