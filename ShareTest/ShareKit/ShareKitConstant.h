//
//  ShareKitConstant.h
//  ShareTest
//
//  Created by zyh on 16/6/27.
//  Copyright © 2016年 SOHU. All rights reserved.
//

#ifndef ShareKitConstant_h
#define ShareKitConstant_h

#define ShareKitWXAppId             @"wxd930ea5d5a258f4f"

#define ShareKitSinaAppKey          @"2045436852"
#define ShareKitSinaRedirectURI     @"https://api.weibo.com/oauth2/default.html"

#define ShareKitQQAppId             @"222222"

typedef enum _ShareKitType {
    ShareKitType_WxSession,
    ShareKitType_WxTimeline,
    ShareKitType_SinaWb,
    ShareKitType_QQ
} ShareKitType;

typedef enum _ShareKitMediaType {
    ShareKitMediaType_Text,
    ShareKitMediaType_Image,
    ShareKitMediaType_Url
} ShareKitMediaType;

#endif /* ShareKitConstant_h */
