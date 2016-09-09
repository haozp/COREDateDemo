//
//  UIScrowTestVC.m
//  COREDateDemo
//
//  Created by leo on 15/9/10.
//  Copyright (c) 2015年 haozp. All rights reserved.
//

#import "TEST_scrowView_VC.h"



@interface TEST_scrowView_VC ()<UIScrollViewDelegate>
{
    UIScrollView *myScrowView;
    UIImageView  *myImageView;

    UIView *bigBackView;
    UIView *grayBackView;
    UIView *titleView;
    UIView *greenView;

    UIView *redView;

    CGFloat redViewX;
    CGFloat redViewY;
    CGFloat redViewWidth;
    CGFloat redViewHeight;


    CGFloat scrowViewWidth;
    CGFloat scrowViewHeight;

    CGFloat grayBackViewWidth;
    CGFloat grayBackViewHeight;

    CGFloat seat_W;

    CGFloat offsetY;
    CGFloat m;

    int countRow;

}
@end

@implementation TEST_scrowView_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    m=0;
    grayBackViewWidth=100;
    grayBackViewHeight=100;
    scrowViewWidth = self.view.frame.size.width-35*2;
    scrowViewHeight = 300;

    myScrowView = [[UIScrollView alloc]initWithFrame:CGRectMake(35,94,scrowViewWidth,scrowViewHeight)];
    myScrowView.backgroundColor = [UIColor orangeColor];
    myScrowView.delegate = self;
    myScrowView.tag = 2;
    myScrowView.maximumZoomScale = 2.0;
    myScrowView.minimumZoomScale = 1.0;
    [self.view addSubview:myScrowView];


    bigBackView = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width-30*2, 300)];
    //bigBackView.backgroundColor = [UIColor redColor];
    myScrowView.contentSize = bigBackView.frame.size;


    grayBackView = [[UIView alloc]initWithFrame:CGRectMake(20, 84, grayBackViewWidth, grayBackViewHeight)];
    grayBackView.backgroundColor = [UIColor grayColor];
    grayBackView.alpha = 0.6;
    [self.view addSubview:grayBackView];
    redView = [[UIView alloc]initWithFrame:grayBackView.bounds];
    redView.layer.masksToBounds = YES;
    redView.layer.borderWidth = 1;
    redView.layer.borderColor = [[UIColor redColor] CGColor];
    redView.backgroundColor = [UIColor clearColor];

    [grayBackView addSubview:redView];

    int countLine = 10;
    countRow = 7;


    CGFloat labrelWidth = 15;
    CGFloat leftPading = 20;
    CGFloat topPading = 30;
    CGFloat seatPading = 5;
    CGFloat seatW = (scrowViewWidth-labrelWidth-leftPading*2-(countLine-1)*seatPading)/countLine;//高度与宽度一样
    seat_W = seatW;
    CGFloat smallSeatW = seatW*grayBackViewWidth/scrowViewWidth;
    CGFloat smallleftPading = leftPading*grayBackViewWidth/scrowViewWidth;
    CGFloat smalltopPading = topPading*grayBackViewWidth/scrowViewWidth;
    CGFloat smallseatPading = seatPading*grayBackViewWidth/scrowViewWidth;


    for (int i = 0; i<countLine; i++) {//列

        for (int j=0; j<countRow; j++) {//行

            UIButton *btnScrow = [UIButton buttonWithType:UIButtonTypeCustom];
            btnScrow.frame = CGRectMake(i*(seatW+seatPading)+leftPading,j*(seatW+seatPading)+topPading, seatW, seatW);
            btnScrow.backgroundColor = [UIColor redColor];
            [btnScrow setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
            btnScrow.tag = [[NSString stringWithFormat:@"1%d%d",i,j] intValue];
            [btnScrow addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
            [bigBackView addSubview:btnScrow];


            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
            btn.tag = [[NSString stringWithFormat:@"1%d%d",i,j] intValue];
            [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];

            btn.frame = CGRectMake(i*(smallSeatW+smallseatPading)+smallleftPading,j*(smallSeatW+smallseatPading)+smalltopPading, smallSeatW, smallSeatW);
            btn.userInteractionEnabled = NO;
            [grayBackView addSubview:btn];


        }

    }

    [myScrowView addSubview:bigBackView];
    grayBackView.hidden = YES;




    titleView = [[UIView alloc]initWithFrame:CGRectMake(2, 94,16, scrowViewHeight)];

    for (int i= 0; i<countRow; i++) {
        UILabel *labrel = [[UILabel alloc]initWithFrame:CGRectMake(2,30+i*(seatW+seatPading),seatW-8, seatW)];
        labrel.font = [UIFont systemFontOfSize:10];
        labrel.text = [NSString stringWithFormat:@"%d",i+1];
        labrel.backgroundColor = [UIColor redColor];
        [titleView addSubview:labrel];
    }
    titleView.alpha = 0.7;
    titleView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:titleView];


    greenView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)selectSeat:(UITapGestureRecognizer *)sender
{

    NSLog(@"fefkjkfksdfjsadlkfj");
}

-(IBAction)tapBtn:(id)sender
{

    UIButton *btn = (UIButton *)sender;
    NSLog(@"%ld",(long)btn.tag);

    UIButton *grayBtn = (UIButton *)[grayBackView viewWithTag:(long)btn.tag];

    if (btn.selected) {
        btn.selected = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
        [grayBtn setBackgroundImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];

    }else{
        btn.selected = YES;
        [btn setBackgroundImage:[UIImage imageNamed:@"02"] forState:UIControlStateSelected];
        [grayBtn setBackgroundImage:[UIImage imageNamed:@"02"] forState:UIControlStateNormal];

    }


}

//scrowview 子view64偏移量的问题解决
-(BOOL)automaticallyAdjustsScrollViewInsets{
    return false;
}

#pragma mark-scrowView delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
           return bigBackView;
}

//获得 redview的宽度 高度
-(void)changeRedViewFrameWidthAndHeight:(UIScrollView *)scrowView
{

    CGFloat scroWidth = scrowView.frame.size.width;
    CGFloat scroHeight = scrowView.frame.size.height;

    CGSize contentSize = scrowView.contentSize;
    CGFloat contentSizeW = contentSize.width;
    CGFloat contentSizeH = contentSize.height;

    redViewWidth = grayBackViewWidth/contentSizeW*scroWidth;
    redViewHeight = grayBackViewHeight/contentSizeH*scroHeight;
    [self chRed];

    m = contentSize.height/scrowViewHeight;
    [self changTitleView:scrowView];
}

-(void)changeRedViewFrameXAndY:(UIScrollView *)scroView{

    UIScrollView *scrow = scroView;

    CGFloat contetOffX = scrow.contentOffset.x;
    CGFloat contetOffY = scrow.contentOffset.y;

    CGSize contentSize = scrow.contentSize;
    CGFloat contentSizeW = contentSize.width;

    CGFloat RedViewX = grayBackViewWidth/contentSizeW*contetOffX;
    CGFloat RedViewY = grayBackViewHeight/contentSizeW*contetOffY;

    redViewX = RedViewX;
    redViewY = RedViewY;

    [self chRed];

    offsetY = scrow.contentOffset.y;
    [self changTitleView:scroView];
}

-(void)chRed
{

    CGFloat x,y,w,h;

    if (redViewX<0) {
        x=0;
        w=redViewWidth+redViewX<grayBackViewWidth?redViewWidth+redViewX:grayBackViewWidth;
    }else if (redViewX>=0&&redViewX+redViewWidth>grayBackViewWidth){
        x=redViewX;
        w=grayBackViewWidth-redViewX;
    }else{
        x=redViewX;
        w=redViewWidth;
    }

    if (redViewY<0) {
        y=0;
        h=redViewHeight+redViewY<grayBackViewHeight?redViewHeight+redViewY:grayBackViewHeight;
    }else if (redViewY>=0&&redViewHeight+redViewY>grayBackViewHeight){
        y=redViewY;
        h=grayBackViewHeight-redViewY;
    }else{
        y=redViewY;
        h=redViewHeight;
    }

    redView.frame = CGRectMake(x, y, w, h);

}


-(void)changTitleView:(UIScrollView *)s
{
    for(id tmpView in [titleView subviews])
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UILabel class]])
        {
        [tmpView removeFromSuperview]; //删除子视图
        }
    }

    if (m==0) {
        m=1;
    }

   //重新创建视图
    for (int i= 0; i<countRow; i++) {
        UILabel *labrel = [[UILabel alloc]initWithFrame:CGRectMake(2,(30+i*(seat_W+5))*m-offsetY,seat_W-8 , seat_W*m)];
        labrel.font = [UIFont systemFontOfSize:10];
        labrel.text = [NSString stringWithFormat:@"%d",i+1];
        labrel.backgroundColor = [UIColor grayColor];
        [titleView addSubview:labrel];
    }

    titleView.backgroundColor = [UIColor redColor];
    titleView.alpha = 0.7;
    [self.view addSubview:titleView];
    [greenView removeFromSuperview];
    greenView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];

    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 400, 300, 200)];
    whiteView.backgroundColor = [UIColor redColor];
    [self.view addSubview:whiteView];

}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self changeRedViewFrameWidthAndHeight:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeRedViewFrameXAndY:scrollView];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    grayBackView.hidden = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    grayBackView.hidden = YES;
}




@end
