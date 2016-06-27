//
//  ShareKitSina.h
//  ShareTest
//
//  Created by zyh on 16/6/27.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "ShareKitConstant.h"

#import <Foundation/Foundation.h>

@interface ShareKitSina : NSObject

+ (instancetype)sharedInstance;
- (void)setupWithAppKey:(NSString *)appKey;
- (void)shareWithContent:(NSString *)content
                   image:(NSData *)image
              thumbImage:(NSData *)thumbImage
                   title:(NSString *)title
                     url:(NSString *)urlStr
             description:(NSString *)description
               mediaType:(ShareKitMediaType)mediaType;
- (BOOL)handleOpenUrl:(NSURL *)url;

@end
