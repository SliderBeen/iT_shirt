//
//  DIYPaintViewController.m
//  IT恤
//
//  Created by 荣刚 on 16/4/2.
//  Copyright © 2016年 rg. All rights reserved.
//

#import "DIYPaintViewController.h"
#import "DIYPaintView.h"
#import "Masonry.h"
#import "UIImage+Capture.h"
#import "ResultViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface DIYPaintViewController ()

@property (nonatomic, weak) IBOutlet DIYPaintView *diyView;

@end

@implementation DIYPaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.diyView.backgroundColor = [UIColor whiteColor];
    self.diyView.tShirtImage = [UIImage imageNamed:@"t_shirt.jpg"];
    [self.view addSubview:self.diyView];
    
    [self.diyView addPasteImage:[UIImage imageNamed:@"1.png"]];
    //[diyView addPasteImage:[UIImage imageNamed:@"1.png"]];
    
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)save
{
    //UIImageWriteToSavedPhotosAlbum([UIImage captureWithView:self.diyView], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    NSData *imageData = UIImagePNGRepresentation([UIImage captureWithView:self.diyView]);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/image.png"];
    NSLog(@"%@", path);
    [imageData writeToFile:path atomically:YES];
}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (!error) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功 " delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}

- (IBAction)doClick:(UIButton *)btn
{
    if (btn.tag == 10) {
        
    } else if (btn.tag == 11) {
    
    } else if (btn.tag == 12) {
    
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller
    ResultViewController *resultVC = [segue destinationViewController];
    // Pass the selected object to the new view controller.
    resultVC.image = [UIImage captureWithView:self.diyView];
    [self save];
}


@end
