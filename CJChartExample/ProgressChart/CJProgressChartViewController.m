//
//  CJProgressChartViewController.m
//  CJChartDemo
//
//  Created by Jonathan on 2017/4/18.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJProgressChartViewController.h"
#import "CJProgressChartView.h"
#import "CJProgressChartTableViewCell.h"

@interface CJProgressChartViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataSource;



@end

@implementation CJProgressChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIEventSubtypeNone;
    
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor greenColor] CGColor]);
    CGContextFillRect(context, rect);
    UIGraphicsGetImageFromCurrentImageContext();
    
    self.title = @"ProgressChart";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.f) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CJProgressChartTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CJProgressChartTableViewCell"];
    self.tableView.rowHeight = 100.f;
    [self.view addSubview:self.tableView];
    
    self.dataSource = [NSMutableArray arrayWithArray:@[[CJChartModel progressChartCurrent:0.f total:10],
                                                       [CJChartModel progressChartCurrent:3.5f total:7],
                                                       [CJChartModel progressChartCurrent:2.1 total:5],
                                                       [CJChartModel progressChartCurrent:10.2 total:14],
                                                       [CJChartModel progressChartCurrent:9.0 total:9],
                                                       [CJChartModel progressChartCurrent:0.4 total:10],
                                                       [CJChartModel progressChartCurrent:8.5 total:10],
                                                       [CJChartModel progressChartCurrent:5.9 total:18],
                                                       [CJChartModel progressChartCurrent:4.5 total:13],
                                                       [CJChartModel progressChartCurrent:11.5 total:15],
                                                       [CJChartModel progressChartCurrent:7.8 total:12],
                                                       [CJChartModel progressChartCurrent:11.5 total:14],
                                                       [CJChartModel progressChartCurrent:12.5 total:16],
                                                       [CJChartModel progressChartCurrent:10.5 total:15],
                                                       [CJChartModel progressChartCurrent:5.5 total:13],
                                                       [CJChartModel progressChartCurrent:8.5 total:16],
                                                       [CJChartModel progressChartCurrent:5.5 total:18],
                                                       [CJChartModel progressChartCurrent:12.5 total:16],
                                                       [CJChartModel progressChartCurrent:4.5 total:10],
                                                       [CJChartModel progressChartCurrent:6.5 total:15],
                                                       [CJChartModel progressChartCurrent:7.0 total:16],
                                                       [CJChartModel progressChartCurrent:9.4 total:10],
                                                       [CJChartModel progressChartCurrent:1.0 total:13],
                                                       [CJChartModel progressChartCurrent:2.4 total:18],
                                                       [CJChartModel progressChartCurrent:0.3 total:22],
                                                       [CJChartModel progressChartCurrent:5.9 total:18],
                                                       [CJChartModel progressChartCurrent:4.5 total:13],
                                                       [CJChartModel progressChartCurrent:11.5 total:15],
                                                       [CJChartModel progressChartCurrent:7.8 total:12],
                                                       [CJChartModel progressChartCurrent:11.5 total:14],
                                                       [CJChartModel progressChartCurrent:12.5 total:16],
                                                       [CJChartModel progressChartCurrent:10.5 total:15],
                                                       [CJChartModel progressChartCurrent:5.5 total:13],
                                                       [CJChartModel progressChartCurrent:8.5 total:16],
                                                       [CJChartModel progressChartCurrent:5.5 total:18],
                                                       [CJChartModel progressChartCurrent:12.5 total:16]]];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJProgressChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CJProgressChartTableViewCell" forIndexPath:indexPath];
    if (cell) {
        CJChartModel *model = self.dataSource[indexPath.row];
        
        [cell.progressChartView setTotalProgress:model.totalProgress currentProgress:model.currentProgress];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath %ld", (long)indexPath.row);
}





@end
