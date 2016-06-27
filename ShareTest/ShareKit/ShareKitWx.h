//
//  ShareKitWx.h
//  ShareTest
//
//  Created by zyh on 16/6/27.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "ShareKitConstant.h"

#import <Foundation/Foundation.h>

@interface ShareKitWx : NSObject

+ (instancetype)sharedInstance;

- (void)setupWithAppId:(NSString *)appId;
- (void)shareWithContent:(NSString *)content
                   image:(NSData *)image
              thumbImage:(NSData *)thumbImage
                   title:(NSString *)title
                     url:(NSString *)urlStr
                    type:(ShareKitType)type
             description:(NSString *)description
               mediaType:(ShareKitMediaType)mediaType;
- (BOOL)handleOpenUrl:(NSURL *)url;

@end
