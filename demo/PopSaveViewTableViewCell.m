//
//  PopSaveViewTableViewCell.m
//  IOSFinaCustomer
//
//  Created by wwt on 15/4/1.
//  Copyright (c) 2015年 rongyu100. All rights reserved.
//

#import "PopSaveViewTableViewCell.h"

@implementation PopSaveViewTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PopSaveViewTableViewCell" owner:self options:nil];
        if (arrayOfViews.count < 1) {
            return nil;
        }
        if (![arrayOfViews[0] isKindOfClass:[PopSaveViewTableViewCell class]]) {
            return nil;
        }
        self = arrayOfViews[0];
        
        CGFloat distancex = 10;
        
        self.namelabel.frame = CGRectMake(distancex, 5, (frame.size.height - self.namelabel.frame.size.height - 10)/2, self.namelabel.frame.size.height);
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
