//
//  LaunchPicManager.m
//  ValleyWaterSource
//
//  Created by 软件技术中心 on 2017/12/1.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import "LaunchPicManager.h"


typedef void(^doneBlock)(LaunchPicManager * mage);
@interface LaunchPicManager()<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *scrollerView;

@property (nonatomic,retain) NSMutableArray *imageArray;

@property (nonatomic,retain) UIImageView *mainImageView;

@property (nonatomic,retain) UIButton *cancleButton;

@property (nonatomic,copy) doneBlock finishBlock;


@end

@implementation LaunchPicManager

+ (BOOL)canShowLuanchImage {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstInstall"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstInstall"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
        
    } else {
        return NO;
        
    }
}

+ (void)showLaunchImageWindow:(UIWindow*)window completeHuandel:(void (^)(LaunchPicManager *))block {
    
    window.backgroundColor = [UIColor whiteColor];
    
    LaunchPicManager * launch = [[LaunchPicManager alloc]init];
    if ([self canShowLuanchImage]) {
     
        [window setRootViewController:launch];
        [window makeKeyAndVisible];
        
        if (block) {
            launch.finishBlock = block;
        }
    }else {
        
        block(launch);
    }
    
}

- (void)doneAction:(UIButton *)button {
    
    [UIView animateWithDuration:1.25 animations:^{
        self.view.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
        self.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        if (self.finishBlock) {
            self.finishBlock(self);
        }
    }];

    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.imageArray = [[NSArray arrayWithObjects:[UIImage imageNamed:@"l1"],[UIImage imageNamed:@"l2"], [UIImage imageNamed:@"l3"],nil] mutableCopy];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollerView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    
    self.scrollerView.delegate = self;
    self.scrollerView.backgroundColor = [UIColor whiteColor];
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.userInteractionEnabled = YES;
    self.scrollerView.contentSize = CGSizeMake(self.view.frame.size.width * self.imageArray.count, self.view.frame.size.height);
    [self.view addSubview:self.scrollerView];
    
    
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancleButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.cancleButton setTitleColor:[UIColor blackColor] forState:0];
    [self.cancleButton.titleLabel setFont:[WaterFont commen12]];
    self.cancleButton.frame = CGRectMake(kDeviceWidth - 60, 20, 50, 50);
    [self.cancleButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_cancleButton];
    
    
    [self loadImage];
}

- (void)loadImage {

    
//    NSArray * colors = @[[UIColor redColor] , [UIColor yellowColor] , [UIColor greenColor]];
    for (int i = 0; i < self.imageArray.count; i++) {
        

//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"nba_%d.jpg",i]];
        
        self.mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.mainImageView.image = _imageArray[i];
//        self.mainImageView.backgroundColor = colors[i];
        self.mainImageView.userInteractionEnabled = YES;
        
        if (i == self.imageArray.count - 1) {
       
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
              button.frame = CGRectMake(0, 500 * HeightIP6, kDeviceWidth, 100 * HeightIP6);
            [button addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
          
            [self.mainImageView addSubview:button];
        }
        

        [_scrollerView addSubview:_mainImageView];

    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
 
    if (scrollView.contentOffset.x ==   self.view.frame.size.width * (self.imageArray.count - 1)) {
        self.cancleButton.hidden = YES;
    }else {
        self.cancleButton.hidden = NO;
    }
}


@end
