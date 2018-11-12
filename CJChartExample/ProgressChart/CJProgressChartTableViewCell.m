//
//  CJProgressChartTableViewCell.m
//  CJChartExample
//
//  Created by Jonathan on 2017/4/18.
//  Copyright © 2017年 Jonathan. All rights reserved.
//

#import "CJProgressChartTableViewCell.h"

@implementation CJProgressChartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.progressChartView.frame = rect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





@end
