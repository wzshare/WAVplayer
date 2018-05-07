//
//  ViewController.m
//  WAVplayer
//
//  Created by wangzhe on 2018/5/3.
//  Copyright © 2018年 wangzhe. All rights reserved.
//

#import "ViewController.h"
#import "WAVplayerViewController.h"
#import "WAVLocalMovieTableView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet WAVLocalMovieTableView *lmTableview;
@property (nonatomic, strong) NSArray *localMovies;
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
    
    self.localMovies = fileList;

    _lmTableview.dataSource = self;
    _lmTableview.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_localMovies count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"LOCAL_MOVIEW_CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row < _localMovies.count) {
        cell.textLabel.text = _localMovies[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self playWith:cell.textLabel.text];
}

- (void)playWith:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = paths.firstObject;
    NSString *moviePath = [NSString stringWithFormat:@"%@/%@", docDir, fileName];
    NSURL *movieUrl = [NSURL fileURLWithPath:moviePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:movieUrl options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    WAVplayerViewController *wavPlayer = [[WAVplayerViewController alloc] init];
    wavPlayer.playerItem = playerItem;
    [self presentViewController:wavPlayer animated:YES completion:nil];
}

@end
