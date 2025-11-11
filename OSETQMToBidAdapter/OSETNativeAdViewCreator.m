//
//  OSETNativeAdViewCreator.m
//  YhsADSProject
//
//  Created by Shens on 11/7/2025.
//

#import "OSETNativeAdViewCreator.h"
#import <WindFoundation/WindFoundation.h>

@interface OSETNativeAdViewCreator()
@property (nonatomic, strong) OSETBaseView *expressAdView;
@property (nonatomic, strong) OSETNativeAd *expressAd;
@property (nonatomic, strong) UIImage *image;
@end
@implementation OSETNativeAdViewCreator

@synthesize adLogoView = _adLogoView;
@synthesize dislikeBtn = _dislikeBtn;
@synthesize imageView = _imageView;
@synthesize imageViewArray = _imageViewArray;
@synthesize mediaView = _mediaView;


- (instancetype)initWithExpressAd:(OSETNativeAd *)nativeAd adView:(OSETBaseView *)adView{
    self = [super init];
    if (self) {
        _expressAd  = nativeAd;
        _expressAdView = adView;
    }
    return self;
}

- (void)setRootViewController:(UIViewController *)viewController {
    self.expressAd.viewController = viewController;
}
- (void)refreshData {

}

- (void)registerContainer:(UIView *)containerView withClickableViews:(NSArray<UIView *> *)clickableViews {
//    NSLog(@"oset-registerContainer---%@",containerView);
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _image = placeholderImage;
}
#pragma mark - Getter
- (UIView *)adLogoView {
    return  [UIView new];
}
- (UIButton *)dislikeBtn {
    return  [UIButton new];
}
- (UIImageView *)imageView {
    return  [UIImageView new];
}
- (NSArray<UIImageView *> *)imageViewArray {
    return @[];
}
- (UIView *)mediaView {
    return [UIView new];
}
- (void)dealloc {
    WindmillLogDebug(@"OSET", @"%s", __func__);
}
@end
