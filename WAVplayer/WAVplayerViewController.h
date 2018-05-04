//
//  WAVplayerViewController.h
//  WAVplayer
//
//  Created by wangzhe on 2018/5/4.
//  Copyright © 2018年 wangzhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface WAVplayerViewController : UIViewController
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerViewController *avplayerController;
@end
