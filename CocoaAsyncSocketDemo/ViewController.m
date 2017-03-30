//
//  ViewController.m
//  CocoaAsyncSocketDemo
//
//  Created by xjw on 2017/3/28.
//  Copyright © 2017年 cn.com.rockmobile. All rights reserved.
//
#import "ViewController.h"
#import "SYYIpHelper.h"
#import "AppDelegate.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MyHTTPConnection.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayViewController.h"
@interface ViewController ()
{
    HTTPServer *httpServer;
}
@property (weak, nonatomic) IBOutlet UILabel *Port;
@property (weak, nonatomic) IBOutlet UITextField *songNameField;

@property (weak, nonatomic) IBOutlet UILabel *songPath;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property(nonatomic,strong) AVPlayer * player;

@property(nonatomic,strong)MPMoviePlayerController * playVc;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    httpServer = [[HTTPServer alloc] init];
    [httpServer setType:@"_http._tcp."];
    // webPath是server搜寻HTML等文件的路径
    NSString *webPath = [[NSBundle mainBundle] resourcePath];
    [httpServer setDocumentRoot:webPath];
    [httpServer setConnectionClass:[MyHTTPConnection class]];
    
    NSError *err;
    if ([httpServer start:&err]) {
        NSLog(@"port %hu",[httpServer listeningPort]);
    }else{
        NSLog(@"%@",err);
    }
    NSString * str =   [SYYIpHelper deviceIPAdress];
    
    NSLog(@"========%@",str);
    self.Port.text = [NSString stringWithFormat:@"%@:%hu",[SYYIpHelper deviceIPAdress],[httpServer listeningPort]];
    AppDelegate * app =   (AppDelegate * )[[UIApplication sharedApplication]delegate];
    self.songNameField.text =  app.name;
    
    self.songPath.text = app.path;
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload:)  name:@"reload" object:nil];
    
    [self.playBtn addTarget:self action:@selector(gotoPlay:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)reload:(NSNotification *)dict{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.songNameField.text = dict.object[@"textOne"];
        
        self.songPath.text = dict.object[@"textTwo"];
        
        NSLog(@"%@  ----------%@",self.songNameField.text,self.songPath.text);
        
    });
}
-(void)gotoPlay:(UIButton *)sender{
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:_playVc ];
    
    PlayViewController * playVc =[[PlayViewController alloc]init];
    
    playVc.PlayerUrl = [NSString stringWithFormat:@"%@/%@",self.songPath.text,self.songNameField.text];
    [self.navigationController pushViewController:playVc animated:YES];
//    [self.navigationController presentMoviePlayerViewControllerAnimated:_playVc];
}
#pragma mark - 懒加载
//- (MPMoviePlayerController *)playVc
//{
//    if (_playVc == nil) {
//        NSURL *url = [[NSURL alloc]initFileURLWithPath:self.songPath.text];
//        
//        _playVc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];;
//    }
//    return _playVc;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
