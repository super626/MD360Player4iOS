//
//  BitmapPlayerViewController.m
//  MD360Player4iOS
//
//  Created by ashqal on 16/5/21.
//  Copyright © 2016年 ashqal. All rights reserved.
//

#import "BitmapPlayerViewController.h"

@interface BitmapPlayerViewController ()<IMDImageProvider>

@end

@implementation BitmapPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   // self.vrLibrary
    self.mURL = [NSURL URLWithString:@"http://app.img.3dov.cn/2016/9/08/5B1DB729E06D8BA655F95B1A89FE9BCB.jpg"];
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:self.mURL options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                NSLog(@"progress:%ld/%ld",receivedSize,expectedSize);
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if ( image && finished) {
                                   // do something with image
                                   [self.vrLibrary updateTexture:image];

                               }
                           }];
}

- (void) initPlayer{
    
    /////////////////////////////////////////////////////// MDVRLibrary
    MDVRConfiguration* config = [MDVRLibrary createConfig];
    
    [config displayMode:MDModeDisplayNormal];
    [config interactiveMode:MDModeInteractiveTouch];
    [config projectionMode:MDModeProjectionDome180];
    [config asImage:self];
    
    [config setContainer:self view:self.view];
    [config pinchEnabled:true];
    
    self.vrLibrary = [config build];
    [self.vrLibrary setInterweaveMode:1];
    [self.vrLibrary switchProjectionMode:MDModeProjectionPlaneFull];
    [self.vrLibrary switchDisplayMode:MDModeDisplayNormal ];
    /////////////////////////////////////////////////////// MDVRLibrary
   
}

-(void) onProvideImage:(id<TextureCallback>)callback {
    //
    //self.mURL = [NSURL URLWithString:@"http://app.img.3dov.cn/2016/9/08/5B1DB729E06D8BA655F95B1A89FE9BCB.jpg"];
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:self.mURL options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                NSLog(@"progress:%ld/%ld",receivedSize,expectedSize);
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if ( image && finished) {
                                   // do something with image
                                   if ([callback respondsToSelector:@selector(texture:)]) {
                                       
                                        [callback texture:image];
                    
                                       
                                   }
                               }
                           }];
    
    
}

@end
