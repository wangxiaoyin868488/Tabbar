//
//  MudiController.m
//  Tabbar
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MudiController.h"

#define MaxSCale 2.0  //最大缩放比例
#define MinScale 0.5  //最小缩放比例


@interface MudiController ()<UITextViewDelegate>

@property (nonatomic,assign) CGFloat totalScale;

@end

@implementation MudiController{

    BOOL _isShow;
    UITextView *_textView;
    
    CGFloat lastScale;
    UIImageView *imaView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.headNavigationView setTitle:_titleStr];
    
    
    self.totalScale = 1.0;
    
        
//    self.view.backgroundColor = [UIColor colorWithHue:(arc4random()% 256 / 256.0) saturation: ( arc4random() % 128 / 256.0 ) + 0.5 brightness:( arc4random() % 128 / 256.0 ) + 0.5 alpha:1];
    
    [self addImageView];
    
}


- (void)addImageView{
    
    imaView = [[UIImageView alloc]init];
    imaView.frame = CGRectMake(0, 0, kwidth, kheight);
    
    imaView.userInteractionEnabled = YES;
    imaView.image = [UIImage imageNamed:@"碧落.jpg"];
//    [self.view addSubview:imaView];
    [self.view insertSubview:imaView atIndex:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
    
    [imaView addGestureRecognizer:tap];
    
    
    UIPinchGestureRecognizer *pinchTap = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchTapClick:)];
    
    [imaView addGestureRecognizer:pinchTap];
    
    
    
    CGFloat tHeight = 100;
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, kheight - tHeight, kwidth, tHeight)];
    
    _textView.text = @"这是一个很牛逼的说明，为什么牛逼呢？因为这是天哥写的，天哥写的谁说不牛逼？谁说不牛逼我揍谁。这张图片通体使用粉色底调，彰显着活泼的同时又不失庄重，大气之余又充满了可爱，这就是我，天下无双的天哥找的图片，是不是亮瞎了，就巴萨就不错撒好久才不会撒出vshjcvcav加计扣除撒检查卡省部级那数据库，才能啥借口不错撒娇吧，那时即可参加课程，查看撒娇的火车上的卡巴回家，八成从北京市。";
    
    _textView.textColor = [UIColor whiteColor];
    [_textView setFont:[UIFont systemFontOfSize:13]];
    _textView.backgroundColor = [UIColor blackColor];
    _textView.alpha = 0.8;
    _textView.userInteractionEnabled = YES;
    _textView.scrollEnabled = YES;
    
    [imaView addSubview:_textView];
}

-(void)pinchTapClick:(UIPinchGestureRecognizer *)recognizer{
    
    
    CGFloat scale = recognizer.scale;
    
    //放大情况
    if(scale > 1.0){
        if(self.totalScale > MaxSCale) return;
    }
    
    //缩小情况
    if (scale < 1.0) {
        if (self.totalScale < MinScale) return;
    }
    
    imaView.transform = CGAffineTransformScale(imaView.transform, scale, scale);
    self.totalScale *=scale;
    recognizer.scale = 1.0;
    
}

- (void)imageClick{
    
    _isShow = !_isShow;
    
    if (_isShow) {
        
        [UIView animateWithDuration:.5 animations:^{
            
            self.headNavigationView.alpha = 0;
            _textView.alpha = 0;
        }];
//        self.headNavigationView.hidden = YES;
//        _textView.hidden = YES;
        
    }else{
        [UIView animateWithDuration:.5 animations:^{
            
            self.headNavigationView.alpha = 1.f;
            _textView.alpha = .8f;
        }];
//        self.headNavigationView.hidden = NO;
//        _textView.hidden = NO;
    }
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
