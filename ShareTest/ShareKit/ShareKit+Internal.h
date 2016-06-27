//
//  ShareKit+Internal.h
//  ShareTest
//
//  Created by zyh on 16/6/24.
//  Copyright © 2016年 SOHU. All rights reserved.
//

#import "ShareKit.h"

@interface ShareKit (Internal)

- (void)notifyDelegateShareSuccess;
- (void)notifyDelegateShareFailWithError:(NSError *)error;

@end
