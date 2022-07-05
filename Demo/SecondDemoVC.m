//
//  SecondDemoVC.m
//  Demo
//
//  Created by yingbo5 on 2021/12/23.
//

#import "SecondDemoVC.h"
#import "ThirdDemoVC.h"

@interface SecondDemoVC ()

@end

@implementation SecondDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@的 did disappear",NSStringFromClass(self.class));
    
    NSLog(@"topVC状态:%@",self.navigationController.topViewController);

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    ThirdDemoVC *third = [[ThirdDemoVC alloc] init];
    [self.navigationController pushViewController:third animated:YES];
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
