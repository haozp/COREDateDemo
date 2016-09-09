//
//  CDWViewController.m
//  COREDateDemo
//
//  Created by leo on 16/6/14.
//  Copyright © 2016年 haozp. All rights reserved.
//

#import "CDWViewController.h"
#import "CDWPlayerViewModel.h"

@interface CDWViewController ()
@property(strong,nonatomic) CDWPlayerViewModel *viewModel;
@property(strong,nonatomic) UITextField        *nameField;
@property(strong,nonatomic) UITextField        *scoreField;
@property(strong,nonatomic) UIStepper          *scoreStepper;
@property(strong,nonatomic) UIButton           *uploadButton;

@property(assign) NSUInteger scoreUpdates;

@end

static NSUInteger const kMaxUploads = 5;

@implementation CDWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatUI];
    self.viewModel = [[CDWPlayerViewModel alloc]init];

    @weakify(self);

    //start binding our property
    RAC(self.nameField,text) = [RACObserve(self.viewModel,playerName) distinctUntilChanged];
    [[self.nameField.rac_textSignal distinctUntilChanged]
    subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.playerName = x;
    }];

    RAC(self.scoreField,text) = [RACObserve(self.viewModel,points)map:^id(NSNumber *value) {
        return [value stringValue];
    }];

    RAC(self.scoreStepper,stepValue) = RACObserve(self.viewModel, stepAmount);
    RAC(self.scoreStepper,maximumValue) = RACObserve(self.viewModel, maxPoints);
    RAC(self.scoreStepper,minimumValue) = RACObserve(self.viewModel, minPoints);

    RAC(self.scoreStepper,hidden) = [RACObserve(self, scoreUpdates)map:^id(NSNumber *x) {
        @strongify(self);
        return @(x.intValue >= self.viewModel.maxPointUpdates);
    }];

    [[[RACObserve(self.scoreStepper,value)
       skip:1]//忽略第一次执行，以后的都执行
       take:self.viewModel.maxPointUpdates]
       subscribeNext:^(id x) {
           @strongify(self);
           self.viewModel.points = [x doubleValue];
           self.scoreUpdates++;
       }];

    [self.viewModel.forbiddenNameSignal
       subscribeNext:^(NSString *name) {
           @strongify(self);
           UIAlertView *alert = [[UIAlertView alloc]   initWithTitle:@"Forbidden Name!"
                message:[NSString stringWithFormat:@"The name %@ has been forbidden!",name]
                delegate:nil
                cancelButtonTitle:@"Ok"
                otherButtonTitles:nil];
           [alert show];
           self.viewModel.playerName = @"";//因为对应的地方有监听 所以这里设置也会被监听到，所以对应的监听位置要做处理
       }];

    //let the upload(save) button only be enabled when the view model says its valid
    RAC(self.uploadButton,enabled) = self.viewModel.modelIsValidSignal;

    //set the control action for our button to be the ViewModels action method
    [self.uploadButton addTarget:self.viewModel
                          action:@selector(uploadData:)
                forControlEvents:UIControlEventTouchUpInside];

    //we can subscribe to the same thing in multiple locations
    //here we skip the first 4（kMaxUploads - 1） signals and take only 1 update
    //and then disable/hide certain UI elements as our app
    //only allows 5 updates
    [[[[self.uploadButton rac_signalForControlEvents:UIControlEventTouchUpInside]
       skip:(kMaxUploads - 1)] take:1] subscribeNext:^(id x) {
        @strongify(self);
        self.nameField.enabled = NO;
        self.scoreStepper.hidden = YES;
        self.uploadButton.hidden = YES;
    }];
}

-(void)creatUI
{
    _nameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 70, 70, 30)];
    _nameField.backgroundColor = [UIColor grayColor];

    _scoreField = [[UITextField alloc]initWithFrame:CGRectMake(20, 150, 70, 30)];
    _nameField.backgroundColor = [UIColor grayColor];

    _scoreStepper = [[UIStepper alloc]initWithFrame:CGRectMake(200, 70, 70, 40)];
    _scoreStepper.backgroundColor = [UIColor orangeColor];


    _uploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _uploadButton.frame = CGRectMake(70, 300, 300, 60);
    _uploadButton.backgroundColor = [UIColor redColor];

    [self.view addSubview:_nameField];
    [self.view addSubview:_scoreField];
    [self.view addSubview:_scoreStepper];
    [self.view addSubview:_uploadButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
