//
//  ViewController.m
//  WAVplayer
//
//  Created by wangzhe on 2018/5/3.
//  Copyright © 2018年 wangzhe. All rights reserved.
//

#import "ViewController.h"
#import "WAVplayerViewController.h"

@interface ViewController ()

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
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:movieUrl options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    WAVplayerViewController *wavPlayer = [[WAVplayerViewController alloc] init];
    wavPlayer.playerItem = playerItem;
    [self.navigationController pushViewController:wavPlayer animated:YES];
    
//    [self presentViewController:wavPlayer animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
