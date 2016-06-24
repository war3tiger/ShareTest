//
//  ShareKit+Sina.h
//  ShareTest
//
//  Created by zyh on 16/6/24.
//  Copyright © 2016年 SOHU. All rights reserved.
//

#import "ShareKit.h"

@interface ShareKit (Sina)
<WeiboSDKDelegate>

- (void)sinaShareWithContent:(NSString *)content
                       image:(NSData *)image
                  thumbImage:(NSData *)thumbImage
                       title:(NSString *)title
                         url:(NSString *)urlStr
                 description:(NSString *)description
                   mediaType:(ShareKitMediaType)mediaType;

@end
