//
//  RTNavigationViewController.m
//  RichTap-Test
//
//  Created by Arthas on 2022/6/14.
//

#import "RTNavigationViewController.h"

@interface RTNavigationViewController ()

@end

@implementation RTNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *titleAttrs = @{
        NSFontAttributeName: [UIFont fontWithName:@"PingFangTC-Regular" size:16],
        NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
    };
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.shadowImage = [[UIImage alloc] init];
        appearance.shadowColor = nil;
        appearance.titleTextAttributes = titleAttrs;
        self.navigationBar.standardAppearance = appearance;
        self.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        // Fallback on earlier versions
        self.navigationBar.barTintColor = [UIColor whiteColor];
        [self.navigationBar setTitleTextAttributes:titleAttrs];
        [self.navigationBar setShadowImage:[UIImage new]];
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
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
