//
//  ViewController.m
//  ShareTest
//
//  Created by zyh on 16/6/22.
//  Copyright © 2016年 SOHU. All rights reserved.
//
#import "ShareKit.h"

#import "ViewController.h"

@interface ViewController ()
<ShareKitDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 50, 50, 50);
    button.tag = 0;
    [button setTitle:@"文字" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(70, 50, 50, 50);
    button.tag = 1;
    [button setTitle:@"图片" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(130, 50, 50, 50);
    button.tag = 2;
    [button setTitle:@"网址" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)sender
{
    int tag = (int)sender.tag;
    
    ShareKitType shareType = ShareKitType_SinaWb;
    if (tag == 0) {
        [[ShareKit sharedInstance] shareWithContent:@"这是在测试文字分享" image:nil thumbImage:nil title:nil url:nil description:nil type:shareType mediaType:ShareKitMediaType_Text delegate:self];
    } else if (tag == 1) {
        UIImage *image = [UIImage imageNamed:@"show.jpg"];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        NSData *thumbData = UIImageJPEGRepresentation([UIImage imageNamed:@"showthumb"], 1.0);
        [[ShareKit sharedInstance] shareWithContent:@"图片分享" image:imageData thumbImage:thumbData title:@"Pic Title" url:@"https://www.baidu.com" description:@"PIC Description abc abc" type:shareType mediaType:ShareKitMediaType_Image delegate:self];
    } else {
        NSData *thumbData = UIImageJPEGRepresentation([UIImage imageNamed:@"showthumb"], 1.0);
        [[ShareKit sharedInstance] shareWithContent:@"网址分享" image:nil thumbImage:thumbData title:@"baidu Title" url:@"https://www.baidu.com" description:@"baidu Description baidu" type:shareType mediaType:ShareKitMediaType_Url delegate:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ShareKitDelegate
- (void)shareResultSuccess
{
    NSLog(@"share success");
}

- (void)shareResultFailWithError:(NSError *)error
{
    NSLog(@"share fail:%@", error);
}

@end
