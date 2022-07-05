//
//  Student.m
//  Demo
//
//  Created by yingbo5 on 2020/12/25.
//

#import "Student.h"

@implementation Student
+ (instancetype)createWithName:(NSString *)name {
    Student *stu = [[Student alloc] init];
    stu.name = name;
    return stu;
}
@end
