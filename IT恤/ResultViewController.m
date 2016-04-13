//
//  ResultViewController.m
//  IT恤
//
//  Created by 荣刚 on 16/4/7.
//  Copyright © 2016年 rg. All rights reserved.
//

#import "ResultViewController.h"
#import "UMSocial.h"

@interface ResultViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClick:(UIButton *)btn {
    if ([btn.currentTitle isEqualToString:@"不满意？返回修改"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([btn.currentTitle isEqualToString:@"收入我的衣橱"]) {
    
    } else if ([btn.currentTitle isEqualToString:@"分享给好友"]) {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:nil
                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能，www.umeng.com/social"
                                         shareImage:[UIImage imageNamed:@"icon.png"]
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline, UMShareToSina, UMShareToQzone, UMShareToRenren]
                                           delegate:nil];
    } else if ([btn.currentTitle isEqualToString:@"联系厂商制作"]) {
        
    }
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
