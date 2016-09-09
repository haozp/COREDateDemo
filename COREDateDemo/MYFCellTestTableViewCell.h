//
//  MYFCellTestTableViewCell.h
//  COREDateDemo
//
//  Created by leo on 16/4/12.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,MyFcellType){

    MyFcellTypeCoupon,
    MyFcellTypeTicket,

};

@interface MYFCellTestTableViewCell : UITableViewCell

+(MYFCellTestTableViewCell *)createMycellWithCellType:(MyFcellType)type;

@end
