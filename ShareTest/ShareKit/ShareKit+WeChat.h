//
//  ShareKit+WeChat.h
//  ShareTest
//
//  Created by zyh on 16/6/23.
//  Copyright © 2016年 SOHU. All rights reserved.
//

#import "ShareKit.h"

@interface ShareKit (WeChat)
<WXApiDelegate>

- (void)wxShareWithContent:(NSString *)content
                     image:(NSData *)image
                 thumbImage:(NSData *)thumbImage
                     title:(NSString *)title
                       url:(NSString *)urlStr
                      type:(ShareKitType)type
               description:(NSString *)description
                 mediaType:(ShareKitMediaType)mediaType;

@end
