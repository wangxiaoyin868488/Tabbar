//
//  PhotoSelectController.m
//  Tabbar
//
//  Created by apple on 16/7/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PhotoSelectController.h"
#import "MOIReadHintView.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PhotoSelectController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation PhotoSelectController{


    UITableView *_myTableView;
    MOIReadHintView *_selectHint;
    NSArray *_allGroupArray;
    UIView *_groupSelectView;
    UITableView *_groupSelectTableView;
    NSMutableArray *_photoArray;
    NSMutableArray *_selectPhoto;
    UIView *_showCameraView;
    UIImagePickerController *_imagePickerController;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavigationView.hidden = YES;
    [self.headNavigationView changeStyle:kHeadNavigationStyle_white];
    
//    [self addTaBleView];
    [self setCamera];
//    [self selectImageFromCamera];
    [self selectImageFromAlbum];
    
    
    
    
}

- (void)setCamera{

    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
//    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
}
#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}






///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addTaBleView{

    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, kwidth, kheight - 65)];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"PhotoSelectCell" bundle:nil] forCellReuseIdentifier:@"PhotoSelectCell"];
    [self.view insertSubview:_myTableView atIndex:0];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == _groupSelectTableView) {
        return _allGroupArray.count;
    }
    
    return _photoArray.count/3 + ((_photoArray.count % 3) > 0);

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [UITableViewCell new];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;

}
- (IBAction)backBtnClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)jumpBtnClick:(UIButton *)sender {
    
    
    
    
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
