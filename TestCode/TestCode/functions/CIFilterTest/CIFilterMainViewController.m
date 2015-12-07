//
//  CIFilterMainViewController.m
//  TestCode
//
//  Created by Encoder on 15/11/27.
//  Copyright © 2015年 Encoder. All rights reserved.
//



#import "CIFilterMainViewController.h"

@interface CIFilterMainViewController (){
    __weak IBOutlet UIImageView *imageShow;
    __weak IBOutlet UILabel *depthLabel;
}

@end

@implementation CIFilterMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    // Do any additional setup after loading the view from its nib.
    depthLabel.text = [NSString stringWithFormat:@"128"];
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
- (IBAction)makeOriginalButtonAction:(id)sender {
    imageShow.image=[UIImage imageNamed:@"ballon"];
}
- (IBAction)makeFilterButtonAction:(id)sender {
    
//    //将 UIImage 转换为 CIImage
//    CIImage *ciImage=[[CIImage alloc]initWithImage:[UIImage imageNamed:@"imageA"]];
//    
//    //创建滤镜
//    CIFilter *filter=[CIFilter filterWithName:@"CIPhotoEffectMono" keysAndValues:kCIInputImageKey,ciImage, nil];
//    
//    //已有的值不改变，其他的设为默认值
//    [filter setDefaults];
//    
//    //获取绘制上下文
//    CIContext *context=[CIContext contextWithOptions:nil];
//    
//    //渲染并输出CIImage
//    CIImage *outputImage=[filter outputImage];
//    
//    //创建CGImage句柄
//    CGImageRef cgImage=[context createCGImage:outputImage fromRect:[outputImage extent]];
//    
//    //获取图片
//    UIImage *image=[UIImage imageWithCGImage:cgImage];
//    
//    //释放CGImage句柄
//    CGImageRelease(cgImage);
//    
//    imageShow.image = image;
    
    imageShow.image=[self processUsingPixels:imageShow.image depth:[depthLabel.text integerValue]];
}

#pragma mark - Private

#define Mask8(x) ( (x) & 0xFF )
#define R(x) ( Mask8(x) )
#define G(x) ( Mask8(x >> 8 ) )
#define B(x) ( Mask8(x >> 16) )
#define A(x) ( Mask8(x >> 24) )
#define RGBAMake(r, g, b, a) ( Mask8(r) | Mask8(g) << 8 | Mask8(b) << 16 | Mask8(a) << 24 )
- (UIImage *)processUsingPixels:(UIImage*)inputImage depth:(NSUInteger)depth{
    
    // 1. Get the raw pixels of the image
    UInt32 * inputPixels;
    
    CGImageRef inputCGImage = [inputImage CGImage];
    NSUInteger inputWidth = CGImageGetWidth(inputCGImage);
    NSUInteger inputHeight = CGImageGetHeight(inputCGImage);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bitsPerComponent = 8;
    
    NSUInteger inputBytesPerRow = bytesPerPixel * inputWidth;
    
    inputPixels = (UInt32 *)calloc(inputHeight * inputWidth, sizeof(UInt32));
    
    CGContextRef context = CGBitmapContextCreate(inputPixels, inputWidth, inputHeight,
                                                 bitsPerComponent, inputBytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, inputWidth, inputHeight), inputCGImage);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UInt32 * currentPixel = inputPixels;
    for (NSUInteger j = 0; j < inputHeight; j++) {
        for (NSUInteger i = 0; i < inputWidth; i++) {
            UInt32 color = *currentPixel;
            //printf("%3.0f ", (R(color)+G(color)+B(color))/3.0);
            if ((R(color)+G(color)+B(color))/3.0<depth) {
                *currentPixel = 0xff000000;
            }
            else{
                *currentPixel = 0xffffffff;
            }
            currentPixel++;
        }
        printf("\n");
    }
    
    CGContextRef prossesedContext = CGBitmapContextCreateWithData(inputPixels, inputWidth, inputHeight, bitsPerComponent, inputBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big, nil, nil);
    
    CGImageRef processedCGImage=CGBitmapContextCreateImage(prossesedContext);
    
    inputImage = [UIImage imageWithCGImage:processedCGImage];
    
    CGContextRelease(prossesedContext);
    CGImageRelease(processedCGImage);
    
    free(inputPixels);
    
    return inputImage;
}

- (IBAction)changeDepth:(UISlider *)sender forEvent:(UIEvent *)event {
    //NSLog(@"=========%@---------%f",event,round(sender.value));
    NSUInteger depth = (NSUInteger)round(sender.value);
    imageShow.image=[self processUsingPixels:[UIImage imageNamed:@"ballon"] depth:depth];
    depthLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)depth];
}


@end
