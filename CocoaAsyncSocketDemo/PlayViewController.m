//
//  PlayViewController.m
//  CocoaAsyncSocketDemo
//
//  Created by xjw on 2017/3/30.
//  Copyright © 2017年 cn.com.rockmobile. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface PlayViewController ()
@property(nonatomic,strong)AVPlayer * player;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    NSURL *url = [[NSURL alloc]initFileURLWithPath:self.PlayerUrl];;
    
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    // 3.创建AVPlayer
    _player = [AVPlayer playerWithPlayerItem:item];
    
    // 4.添加AVPlayerLayer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view.layer addSublayer:layer];
    [_player play];
    // Do any additional setup after loading the view.
}
//- (AVPlayer *)player
//{
//    if (_player == nil) {
//        // 1.获取URL(远程/本地)
//        // NSURL *url = [[NSBundle mainBundle] URLForResource:@"01-知识回顾.mp4" withExtension:nil];
//       
//    }
//    return _player;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
