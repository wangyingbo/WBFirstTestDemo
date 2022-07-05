//
//  DemoVC.m
//  Demo
//
//  Created by yingbo5 on 2021/6/22.
//

#import "DemoVC.h"
#import "SecondDemoVC.h"
#import "Student.h"

@interface TestAView : UIView

@end

@interface TestBView : UIView

@end

@interface DemoVC ()<DemoVCProtocol>

@end

@implementation DemoVC
@synthesize testString = _testSting;

- (void)setTestString:(NSString *)testString {
    
}

- (NSString *)testString {
    return _testSting;
}

- (void)dealloc {
    NSLog(@"dealloc---%@被释放掉了",NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    //[self testSet];
    
    [self testObjectCopy];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@ did appear & modalPresentationStyle:%ld",NSStringFromClass(self.class),(long)self.modalPresentationStyle);
//    NSLog(@"%@的 did appear",NSStringFromClass(self.class));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@的 did disappear",NSStringFromClass(self.class));
    
    if ([self isBeingDismissed] || [self.navigationController isBeingDismissed] || [self isMovingFromParentViewController]) {
        // pop || dismiss
        NSLog(@"%@的 pop || dismiss",NSStringFromClass(self.class));
    }else {
        // push || present from here
        NSLog(@"%@的 push || present from here",NSStringFromClass(self.class));
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    SecondDemoVC *second = [[SecondDemoVC alloc] init];
//    [self.navigationController pushViewController:second animated:YES];
    
//    second.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:second animated:YES completion:nil];
}

- (void)testHit {
    
    NSLog(@"%@: <%p>-----didLoad-----",NSStringFromClass(self.class),self);
    
    TestAView *aView = [[TestAView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:aView];
    
    TestBView *bView = [[TestBView alloc] initWithFrame:aView.frame];
    bView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bView];
}

- (void)testObjectCopy {
    
    Student *stu1 = [Student createWithName:@"1"];
    Student *stu2 = [Student createWithName:@"2"];
    Student *stu3 = [Student createWithName:@"3"];
    NSMutableArray *mutArr = [NSMutableArray array];
    [mutArr addObject:stu1];
    [mutArr addObject:stu2];
    [mutArr addObject:stu3];
    
    NSArray *copyArr = [mutArr copy];
    
    NSLog(@"yb----copyArray:%@",((Student *)[copyArr firstObject]).name);
    stu1.name = @"name1:wyb";
    NSLog(@"yb----mutArr:%@",((Student *)[mutArr firstObject]).name);
    NSLog(@"yb----copyArray:%@",((Student *)[copyArr firstObject]).name);
}


- (void)testSet {
    Student *stu1 = [Student createWithName:@"1"];
    Student *stu2 = [Student createWithName:@"2"];
    Student *stu3 = [Student createWithName:@"3"];
    Student *stu5 = [Student createWithName:@"5"];
    Student *stu6 = [Student createWithName:@"6"];
    
    NSArray *array1 = @[stu1,stu2,stu3];
    NSArray *array2 = @[stu1,stu5,stu6];
    NSMutableSet *set1 = [NSMutableSet setWithArray:array1];
    NSMutableSet *set2 = [NSMutableSet setWithArray:array2];

//    [set1 unionSet:set2];       //取并集后 set1中为1，2，3，5，6
//    NSLog(@"====set====  并集");
//    [set1 intersectSet:set2];  //取交集后 set1中为1
//    NSLog(@"====set====  交集");
    [set1 minusSet:set2];      //取差集后 set1中为2，3
    NSLog(@"====set====  差集");
    
    [set1 enumerateObjectsUsingBlock:^(Student * _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"====set====  set1 name：%@",obj.name);
    }];
    [set2 enumerateObjectsUsingBlock:^(Student * _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"====set====  set2 name：%@",obj.name);
    }];
    
    
    
    NSArray *array3 = @[stu1,stu2];
    NSArray *array4 = @[stu1,stu5];
//    NSLog(@"====set====  isEqual %@",[array3 isEqual:array4]?@"yes":@"no");
//    NSLog(@"====set====  isEqualToArray %@",[array3 isEqualToArray:array4]?@"yes":@"no");
    NSMutableSet *set3 = [NSMutableSet setWithArray:array3];
    NSMutableSet *set4 = [NSMutableSet setWithArray:array4];
//    NSLog(@"====set====  isEqual %@",[set3 isEqual:set4]?@"yes":@"no");
//    NSLog(@"====set====  isEqualToSet %@",[set3 isEqualToSet:set4]?@"yes":@"no");
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

@implementation TestAView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"响应了A view");
    return [super hitTest:point withEvent:event];
}

@end

@implementation TestBView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"响应了B view");
    return [super hitTest:point withEvent:event];
}

@end
