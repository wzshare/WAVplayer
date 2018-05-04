//
//  WAVplayerViewController.m
//  WAVplayer
//
//  Created by wangzhe on 2018/5/4.
//  Copyright © 2018年 wangzhe. All rights reserved.
//

#import "WAVplayerViewController.h"

@interface WAVplayerViewController ()
@property (nonatomic, strong) AVPlayer *avPlayer;
@end

@implementation WAVplayerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    self.avPlayer = [AVPlayer playerWithPlayerItem:_playerItem];
    
    _avplayerController = [[AVPlayerViewController alloc] init];
    _avplayerController.player = self.avPlayer;
    _avplayerController.videoGravity = AVLayerVideoGravityResizeAspect;
    _avplayerController.showsPlaybackControls = YES;
    _avplayerController.view.frame = self.view.bounds;
    [self addChildViewController:_avplayerController];
    [self.view addSubview:_avplayerController.view];
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
