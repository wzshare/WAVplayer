//
//  ViewController.m
//  WAVplayer
//
//  Created by wangzhe on 2018/5/3.
//  Copyright © 2018年 wangzhe. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property (nonatomic, strong) AVPlayer *avPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = paths.firstObject;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    fileList = [fileManager contentsOfDirectoryAtPath:docDir error:&error];
    
    NSString *moviePath = [NSString stringWithFormat:@"%@/%@", docDir, fileList[1]];
    NSURL *movieUrl = [NSURL fileURLWithPath:moviePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:movieUrl options:nil];;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    self.avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerLayer.contentsScale = [UIScreen mainScreen].scale;
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = width / 16 * 9;
    CGFloat y = (self.view.frame.size.height - height) / 2;
    playerLayer.frame = CGRectMake(0, y, width, height);
    [self.view.layer addSublayer:playerLayer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    }
    else if ([keyPath isEqualToString:@"status"]) {
        if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
            NSLog(@"player is ready.");
            [self.avPlayer play];
        } else {
            NSLog(@"load break");
            NSLog(@"%@", playerItem.error.localizedDescription);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
