//
//  MYFCellTestTableViewCell.m
//  COREDateDemo
//
//  Created by leo on 16/4/12.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "MYFCellTestTableViewCell.h"
#import "CellTypecoupon.h"
#import "CellTypeTicket.h"

@implementation MYFCellTestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(MYFCellTestTableViewCell *)createMycellWithCellType:(MyFcellType)type{
    switch (type) {
        case MyFcellTypeCoupon:
        return [[CellTypecoupon alloc]init];
            break;
        case MyFcellTypeTicket:
            return [[CellTypeTicket alloc]init];
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
