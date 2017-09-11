//
//  Tabbar4Controller.m
//  Tabbar
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Tabbar4Controller.h"
#import "BtnCollectionViewCell.h"
#import "EqualSpaceFlowLayout.h"
#import "MudiController.h"
#import "PhotoSelectController.h"
#import "CustomTitleView.h"


#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "CopyLabelController.h"
#import "XYPickerView.h"


@interface Tabbar4Controller ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,EqualSpaceFlowLayoutDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation Tabbar4Controller{


    NSMutableArray *_shujuArray;
    UICollectionView *_collectionView;
    
    
    UIImagePickerController *_imagePickerController;
    
    UIImageView *_imagePicker;
    
     AVPlayer *_videoPlayer;
    UIImageView *_playholderImage;

    XYPickerView *_xyPickerView;

    NSArray *_adressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.headNavigationView setTitle:@"我的"];
    _shujuArray = [NSMutableArray arrayWithObjects:@"测试",@"hello，树先生",@"我也不知带哦",@"就这样吧",@"一办粑粑般",@"hhmlmklnkhhh",@"hhhhh",@"hhhnjasnbjcbhh",@"糖水不好喝",@"蜂蜜还是很不错的",@"我稀罕你",@"嘎嘎", nil];
    _adressArray = [NSArray arrayWithObjects:@"北京",@"上海",@"巴黎",@"香港",@"澳门",@"纽约", nil];
    
    //标签
    [self setFlowLayout];
    
    //相机
//    [self setCamera];
//    [self setImagePlayer];
    
    [self setPickerView];

    
}


- (void)setFlowLayout{
    
    EqualSpaceFlowLayout *flowLayout=[[EqualSpaceFlowLayout alloc]init];

    flowLayout.delegate = self;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //设置横向还是竖向
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, kwidth ,kheight-130) collectionViewLayout:flowLayout];
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"BtnCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"BtnCollectionViewCell"];
    
    [self.view addSubview:_collectionView];
    
}

- (void)setImagePlayer{
    
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, 80, 40)];
    photoBtn.centerX = self.view.centerX;
    [photoBtn setTitle:@"获取相机" forState:UIControlStateNormal];
    photoBtn.backgroundColor = [UIColor blueColor];
    
    [photoBtn addTarget:self action:@selector(photoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoBtn];
    
    
    _imagePicker = [[UIImageView alloc]initWithFrame:CGRectMake((kwidth - 200)*0.5, 350, 200, 200)];
    [self.view addSubview:_imagePicker];
    


}

- (void)photoBtnClick{
    
//    PhotoSelectController *phoVc = [[PhotoSelectController alloc]init];
//    
//    [self.navigationController pushViewController:phoVc animated:YES];
   
    CustomTitleView *tView = [[CustomTitleView alloc]initWithClickBlock:^(NSInteger index, NSString *btnTitle, UIButton *btn) {
        
        if ([btnTitle isEqualToString:@"相机"]) {
            
            [self selectImageFromCamera];
            
        }else{
            [self selectImageFromAlbum];
        
        }
        
    } dismissBlock:nil isQuanBu:YES];
    
    
    [tView showViewInView:self.view];
    
    
    
}

- (void)setCamera{
    
    if (!_imagePickerController) {
        
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
        

    }
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


#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //如果是图片
        _imagePicker.image = info[UIImagePickerControllerEditedImage];
        //压缩图片
        NSData *fileData = UIImageJPEGRepresentation(_imagePicker.image, 1.0);
        //保存图片至相册
        UIImageWriteToSavedPhotosAlbum(_imagePicker.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //上传图片
//        [self uploadImageWithData:fileData];
        
    }else{
       // 如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        //播放视频
        
        _playholderImage.hidden = YES;
        [self addPlayerViewWithUrl:url];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_videoPlayer.currentItem];

        
        //保存视频至相册（异步线程）
        NSString *urlStr = [url path];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
                
                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            }
        });
//        NSData *videoData = [NSData dataWithContentsOfURL:url];
        //视频上传
//        [self uploadVideoWithData:videoData];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addPlayerViewWithUrl:(NSURL *)_url{
    
    
    UIView *playView = [[UIView alloc]initWithFrame:CGRectMake((kwidth - 200)*0.5, 85, 200,  200)];
    playView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:playView];
    
    _videoPlayer = [[AVPlayer alloc]initWithURL:_url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_videoPlayer];
    playerLayer.frame = CGRectMake(0, 0, 200,  200);
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//视频填充模式
    [playView.layer addSublayer:playerLayer];
    [_videoPlayer play];
    
    
    _playholderImage = [[UIImageView alloc]initWithFrame:CGRectMake((kwidth - 200)*0.5, 85, 200,  200)];
    _playholderImage.image = [UIImage imageNamed:@"帖子视频播放"];
    _playholderImage.contentMode = UIViewContentModeCenter;
    [self.view addSubview:_playholderImage];
    
    
    _playholderImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(videoPaly)];
    
    [_playholderImage addGestureRecognizer:tap];
    
    _playholderImage.hidden = YES;
    
}

- (void)videoPaly{
    
    _playholderImage.hidden = YES;
    [_videoPlayer seekToTime:CMTimeMake(0, 1)];
    [_videoPlayer play];

}

-(void)playbackFinished:(NSNotification *)notification{
    _playholderImage.hidden = NO;
}

- (void)dealloc
{
    [self removeNotification];
}
-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- UICollectionView代理 数据

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{


    return 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _shujuArray.count;

}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BtnCollectionViewCell" forIndexPath:indexPath];
    
//    [cell setBtnCollectionViewCellWithDict:_btnArray[indexPath.row]];
    
        [cell setBtnCollectionViewCellWithStr:_shujuArray[indexPath.row]];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height=30;
    
    NSString *str = _shujuArray[indexPath.row];
    
    UIFont * font = [UIFont systemFontOfSize:15];
    NSDictionary *att = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect sizeStr = [str boundingRectWithSize:CGSizeMake(kwidth -2*10, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    
    return  CGSizeMake( sizeStr.size.width <= 30 ? 70:sizeStr.size.width + 40, height);  //设置cell宽高
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row <= 5) {
        CopyLabelController *copyVc = [[CopyLabelController alloc]init];
        
        [self.navigationController pushViewController:copyVc animated:YES];

    }else if(indexPath.row > 5 && indexPath.row <= 8){
    
        MudiController *mVc = [[MudiController alloc]init];
        
        mVc.titleStr = _shujuArray[indexPath.row];
        
        [self.navigationController pushViewController:mVc animated:YES];
    }else{
        [_xyPickerView popPickerView];
    }
        
}

- (void)setPickerView{
    
    _xyPickerView = [[XYPickerView alloc] initWithFrame:CGRectMake(0, kheight, kwidth, kheight)];
    _xyPickerView.arrPickerData = _adressArray;
    [_xyPickerView.pickerView selectRow:1 inComponent:0 animated:YES]; //pickerview默认选中行、
    [self.view addSubview:_xyPickerView];
    
//    __weak Tabbar4Controller *__weakSelf = self;
    _xyPickerView.selectBlock = ^(NSString *str){
        if (str.length > 0) {
//            __weakSelf.readlyAdress.text = str;
            
            NSLog(@"----%@",str);
            
        }
    };
}

@end
