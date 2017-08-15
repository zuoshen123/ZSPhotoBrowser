//
//  ViewController.m
//  ZSPhotoBrowser
//
//  Created by zuoshen on 16/10/27.
//  Copyright © 2016年 zuoshen. All rights reserved.
//

#import "ViewController.h"
#import <pop/POP.h>
#import "ZSLargeCell.h"
#import "ZSThreeCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray* mDataSource;
}

@property(nonatomic,strong) UITableView *mTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-20) style:UITableViewStylePlain];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_mTableView registerClass:[ZSLargeCell class] forCellReuseIdentifier:@"ZSLargeCell"];
    [_mTableView registerClass:[ZSThreeCell class] forCellReuseIdentifier:@"ZSThreeCell"];
    [self.view addSubview:_mTableView];
    
    [_mTableView reloadData];
    
    
//    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    
//    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
//    anim.toValue = [NSValue valueWithCGRect:CGRectMake(50, 50, 100, 100)];
//    [view.layer pop_addAnimation:anim forKey:@"mysize"];

//    POPDecayAnimation *anim = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//    anim.velocity = @(100.);
//    [view.layer pop_addAnimation:anim forKey:@"slide"];
    
//    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    anim.fromValue = @(0.0);
//    anim.toValue = @(1.0);
//    [view pop_addAnimation:anim forKey:@"fade"];
    
//    POPBasicAnimation *anim = [POPBasicAnimation animation];
//    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"com.foo.radio.alpha" initializer:^(POPMutableAnimatableProperty *prop) {
//        // read value
//        prop.readBlock = ^(id obj, CGFloat values[]) {
//            values[0] = [obj alpha];
//        };
//        // write value
//        prop.writeBlock = ^(id obj, const CGFloat values[]) {
//            [obj setAlpha:values[0]];
//        };
//        // dynamics threshold
//        prop.threshold = 0.01;
//    }];
//    
//    anim.property = prop;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    anim.fromValue = @(0.0);
//    anim.toValue = @(1.0);
//    [view pop_addAnimation:anim forKey:@"fade"];
}

-(void)initData{
    mDataSource = [[NSMutableArray alloc]init];
    NSArray* array = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502101043470&di=892eec214d2fdc7a1b465c7d0f8232c4&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201303%2F22%2F052833o6a9fwz5thutzt63.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502101121918&di=2c97abdaf312ba7fa99ae47e0403e835&imgtype=0&src=http%3A%2F%2Fcdnq.duitang.com%2Fuploads%2Fitem%2F201405%2F06%2F20140506022123_2hF8N.thumb.700_0.jpeg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502101213516&di=26c3d574a46d0013e7bb7faac6c1a27c&imgtype=0&src=http%3A%2F%2Fi-3.yiwan.com%2F2016%2F9%2F16%2F41a62c22-44ac-4f7c-b0ba-d6df94665998.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502101227603&di=a87610ae27e4ea744df5eb822147eaf7&imgtype=0&src=http%3A%2F%2Fff.topitme.com%2Ff%2F2a%2Ffa%2F1165423204517fa2afo.jpg",
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502101247173&di=d23d8ae424f46330091c2ee2b2a9e92d&imgtype=0&src=http%3A%2F%2Fimg.99danji.com%2Fuploadfile%2F2017%2F0727%2F20170727104421422.jpg"];
    [mDataSource addObjectsFromArray:array];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mDataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        ZSLargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZSLargeCell"];
        [cell setImageUrl:[mDataSource objectAtIndex:indexPath.row]];
        return cell;
    }else{
        ZSThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZSThreeCell"];
        [cell setImageUrls:[mDataSource objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return [tableView fd_heightForCellWithIdentifier:@"ZSLargeCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            if ([cell isKindOfClass:[ZSLargeCell class]]) {
                [(ZSLargeCell*)cell setImageUrl:[mDataSource objectAtIndex:indexPath.row]];
            }
        }];
    }else{
        return [tableView fd_heightForCellWithIdentifier:@"ZSThreeCell" cacheByIndexPath:indexPath configuration:^(id cell) {
            // configurations
            if ([cell isKindOfClass:[ZSThreeCell class]]) {
                [(ZSThreeCell*)cell setImageUrls:[mDataSource objectAtIndex:indexPath.row]];
            }
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
