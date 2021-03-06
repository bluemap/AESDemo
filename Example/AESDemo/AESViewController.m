//
//  AESViewController.m
//  AESDemo
//
//  Created by bluemap on 08/05/2017.
//  Copyright (c) 2017 bluemap. All rights reserved.
//

#import "AESViewController.h"
#import "CocoaSecurity.h"
#import <Foundation/Foundation.h>


#define kPHPBaseURL @"http://100.84.250.23/aes.php?"
#define kIV @"280f8bb8c43d532f" //向量长度必须是16
#define kKey @"280f8bb8c43d532f389ef0e2a5321220" //key长度必须是16、24、32 三种

@interface AESViewController ()


@property (nonatomic, retain) UIButton *keyCreateBtn;
@property (nonatomic, retain) UITextView *secKey;//密钥串
@property (nonatomic, retain) UITextView *viText;//vi
@property (nonatomic, retain) UILabel *secText;     //输入密文：
@property (nonatomic, retain) UITextView *inputView; //密文
@property (nonatomic, retain) UIButton *iOSEncreptBtn;   //ios加密
@property (nonatomic, retain) UIButton *phpEncreptBtn;   //php加密
@property (nonatomic, retain) UITextView *encreptTextView;//加密密文
@property (nonatomic, retain) UITextView *phpEncreptTextView;//php加密秘
@property (nonatomic, retain) UIButton *iosDecreptBtn;   //iOS解密
@property (nonatomic, retain) UITextView *iosDecreptTextView;//iOS解密秘文
@property (nonatomic, retain) UIButton *phpDecreptBtn;   //PHP解密
@property (nonatomic, retain) UITextView *phpDecreptTextView;//PHP解密秘文


@end

@implementation AESViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareSubViews
{
    CGRect frame = CGRectMake(0, 40, 140, 30);
    self.keyCreateBtn = [[UIButton alloc] initWithFrame:frame];
    [self.keyCreateBtn setTitle:@"生成Key和Vi" forState:UIControlStateNormal];
    [self.keyCreateBtn addTarget:self action:@selector(createKeyAndViBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.keyCreateBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.keyCreateBtn];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 320, 30);
    self.secKey = [[UITextView alloc] initWithFrame:frame];
    self.secKey.backgroundColor = [UIColor greenColor];
    self.secKey.textColor = [UIColor redColor];
    self.secKey.text = kKey;//key长度必须是16、24、32 三种
    self.secKey.userInteractionEnabled = NO;
    [self.view addSubview:self.secKey];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 320, 30);
    self.viText = [[UITextView alloc] initWithFrame:frame];
    self.viText.backgroundColor = [UIColor greenColor];
    self.viText.textColor = [UIColor redColor];
    self.viText.text = kIV;//vi长度必须是16
    self.viText.userInteractionEnabled = NO;
    [self.view addSubview:self.viText];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 320, 20);
    self.secText = [[UILabel alloc] initWithFrame:frame];
    self.secText.text = @"输入秘文:";
    [self.view addSubview:self.secText];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 320, 80);
    self.inputView = [[UITextView alloc] initWithFrame:frame];
    self.inputView.backgroundColor = [UIColor lightGrayColor];
    self.inputView.text = @"test";
    [self.view addSubview:self.inputView];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 80, 40);
    self.iOSEncreptBtn = [[UIButton alloc] initWithFrame:frame];
    [self.iOSEncreptBtn setTitle:@"iOS加密" forState:UIControlStateNormal];
    [self.iOSEncreptBtn addTarget:self action:@selector(iosEncreptBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.iOSEncreptBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.iOSEncreptBtn];
    
    frame = CGRectMake(100, frame.origin.y, 80, 40);
    self.phpEncreptBtn = [[UIButton alloc] initWithFrame:frame];
    [self.phpEncreptBtn setTitle:@"php加密" forState:UIControlStateNormal];
    [self.phpEncreptBtn addTarget:self action:@selector(phpEncreptBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.phpEncreptBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.phpEncreptBtn];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 320, 80);
    self.encreptTextView = [[UITextView alloc] initWithFrame:frame];
    self.encreptTextView.userInteractionEnabled = NO;
    self.encreptTextView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.encreptTextView];
    
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 80, 40);
    self.iosDecreptBtn = [[UIButton alloc] initWithFrame:frame];
    [self.iosDecreptBtn setTitle:@"iOS解密" forState:UIControlStateNormal];
    [self.iosDecreptBtn addTarget:self action:@selector(iosDecreptBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.iosDecreptBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.iosDecreptBtn];
    
    frame = CGRectMake(160, frame.origin.y, 80, 40);
    self.phpDecreptBtn = [[UIButton alloc] initWithFrame:frame];
    [self.phpDecreptBtn setTitle:@"php解密" forState:UIControlStateNormal];
    [self.phpDecreptBtn addTarget:self action:@selector(phpDecreptBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.phpDecreptBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.phpDecreptBtn];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5, 150, 180);
    self.iosDecreptTextView = [[UITextView alloc] initWithFrame:frame];
    self.iosDecreptTextView.userInteractionEnabled = NO;
    self.iosDecreptTextView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.iosDecreptTextView];
    
    frame = CGRectMake(160, frame.origin.y, 150, 180);
    self.phpDecreptTextView = [[UITextView alloc] initWithFrame:frame];
    self.phpDecreptTextView.userInteractionEnabled = NO;
    self.phpDecreptTextView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.phpDecreptTextView];
}

- (void)iosEncreptBtnClicked:(id)sender
{
    self.encreptTextView.text = nil;
    self.iosDecreptTextView.text = nil;
    self.phpDecreptTextView.text = nil;
    
    NSString *secSeed = self.secKey.text;
    NSString *vi = self.viText.text;
    NSString *message = self.inputView.text;
    if (secSeed && message)
    {
        CocoaSecurityResult *result = [CocoaSecurity aesEncrypt:message hexKey:secSeed hexIv:vi];
        NSString *encodeMessage = result.base64;
        if (encodeMessage)
        {
            self.encreptTextView.text = encodeMessage;
            self.encreptTextView.textColor = [UIColor greenColor];
        }
        else
        {
            self.encreptTextView.text = @"ios encode err";
            self.encreptTextView.textColor = [UIColor redColor];
        }
    }
}

- (void)iosDecreptBtnClicked:(id)sender
{
    NSString *key = self.secKey.text;
    NSString *vi = self.viText.text;
    NSString *encodeMessage = self.encreptTextView.text;
    if (encodeMessage)
    {
        CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithBase64:encodeMessage hexKey:key hexIv:vi];
        NSString *decodeMessage = result.utf8String;
        if (decodeMessage)
        {
            self.iosDecreptTextView.text = decodeMessage;
            self.iosDecreptTextView.textColor = [UIColor blueColor];
        }
        else
        {
            self.iosDecreptTextView.text = @"ios decode err";
            self.iosDecreptTextView.textColor = [UIColor redColor];
        }
    }
}

- (void)phpEncreptBtnClicked:(id)sender
{
    self.encreptTextView.text = nil;
    self.iosDecreptTextView.text = nil;
    self.phpDecreptTextView.text = nil;
    
    NSString *key = self.secKey.text;
    NSString *vi = self.viText.text;
    NSString *message = self.inputView.text;
    NSString *url = [NSString stringWithFormat:@"%@type=encode&key=%@&message=%@&iv=%@",kPHPBaseURL,[self urlEncodeUsingEncoding:key],[self urlEncodeUsingEncoding:message],vi];
    NSURL *URL = [NSURL URLWithString:url];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error)
            {
                self.encreptTextView.text = @"php encode err";
                self.encreptTextView.textColor = [UIColor redColor];
            }
            else
            {
                NSString *encodeMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                self.encreptTextView.text = encodeMessage;
                self.encreptTextView.textColor = [UIColor greenColor];
            }
            
        });
        
    }] resume];
}

- (void)phpDecreptBtnClicked:(id)sender
{
    NSString *key = self.secKey.text;
    NSString *vi = self.viText.text;
    NSString *encodeMessage = self.encreptTextView.text;
    NSString *url = [NSString stringWithFormat:@"%@type=decode&key=%@&message=%@&iv=%@",kPHPBaseURL,[self urlEncodeUsingEncoding:key],[self urlEncodeUsingEncoding:encodeMessage],vi];
    NSURL *URL = [NSURL URLWithString:url];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            { 
                self.phpDecreptTextView.text = @"php decode err";
                self.phpDecreptTextView.textColor = [UIColor redColor];
            }
            else
            {
                NSString *decodeMessage = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                self.phpDecreptTextView.text = decodeMessage;
                self.phpDecreptTextView.textColor = [UIColor blueColor];
            }
        });
    }] resume];
}

- (void)createKeyAndViBtnClicked:(UIButton *)sender
{
    NSString *UUID = [self createUUID];
    if (UUID.length > 32)
    {
        NSInteger keyLen = 32;
        NSInteger rand = arc4random()%3;
        if (rand == 0)
        {
            //key 设置16位长度
            keyLen = 16;
        }
        else if(rand == 1)
        {
            //key 设置24位长度
            keyLen = 24;
        }
        
        NSString *key = [UUID substringToIndex:keyLen];
        NSString *vi = [UUID substringFromIndex:UUID.length - 16];
        self.secKey.text = key;
        self.viText.text = vi;
    }
}

- (NSString *)urlEncodeUsingEncoding:(NSString *)text
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)text,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
}

- (NSString *)createUUID
{
    NSString *result;
    CFUUIDRef uuid;
    CFStringRef uuidStr;
    uuid = CFUUIDCreate(NULL);
    uuidStr = CFUUIDCreateString(NULL, uuid);
    result =[NSString stringWithFormat:@"%@",uuidStr];
    CFRelease(uuidStr);
    CFRelease(uuid);
    return result;
}

@end
