//
//  OSETCustomToBidNativeAdapter.m
//  YhsADSProject
//
//  Created by Shens on 9/7/2025.
//

#import "OSETCustomToBidNativeAdapter.h"
#import "OSETNativeAdViewCreator.h"
#import <WindFoundation/WindFoundation.h>
#import <OSETSDK/OSETSDK.h>
@interface OSETCustomToBidNativeAdapter ()<OSETNativeAdDelegate>
@property (nonatomic, weak) id<AWMCustomNativeAdapterBridge> bridge;
@property (nonatomic,strong) OSETNativeAd *nativeAd;
@property (nonatomic, strong) NSArray<OSETNativeAd *> *nativeAdDataArray;

@end

@implementation OSETCustomToBidNativeAdapter
- (instancetype)initWithBridge:(id<AWMCustomNativeAdapterBridge>)bridge {
    self = [super init];
    if (self) {
        _bridge = bridge;
    }
    return self;
}

- (void)loadAdWithPlacementId:(NSString *)placementId adSize:(CGSize)size parameter:(AWMParameter *)parameter {
    
    self.nativeAd = [[OSETNativeAd alloc] initWithSlotId:placementId size:size rootViewController:nil];
    self.nativeAd.delegate = self;
    [self.nativeAd loadAdData];

}

- (BOOL)mediatedAdStatus {
    return YES;
}

- (void)didReceiveBidResult:(AWMMediaBidResult *)result {
    if (result.win) {
        WindmillLogDebug(@"OSET-WindWill-竞价成功", @"%@", NSStringFromSelector(_cmd));
    }else{
        WindmillLogDebug(@"OSET-WindWill-竞价失败", @"%@", NSStringFromSelector(_cmd));
    }
    self.nativeAdDataArray = nil;
}


- (void)nativeExpressAdLoadSuccessWithNative:(id)native nativeExpressViews:(NSArray *)nativeExpressViews{
    
    WindmillLogDebug(@"OSET", @"%@", NSStringFromSelector(_cmd));
    OSETBaseView *adView = nativeExpressViews.firstObject;
    NSString *price = [NSString stringWithFormat:@"%ld",(long)adView.eCPM];
    [self.bridge nativeAd:self didAdServerResponseWithExt:@{
        AWMMediaAdLoadingExtECPM: price
    }];
    NSMutableArray *adArray = [[NSMutableArray alloc] init];
    self.nativeAd.delegate = self;
    AWMMediatedNativeAd *mNativeAd = [[AWMMediatedNativeAd alloc] init];
    mNativeAd.originMediatedNativeAd = self.nativeAd;
    mNativeAd.viewCreator = [[OSETNativeAdViewCreator alloc] initWithExpressAd:self.nativeAd adView:adView];
    mNativeAd.view = adView;
    [adArray addObject:mNativeAd];
    [self.bridge nativeAd:self didLoadWithNativeAds:adArray];
}

- (void)nativeExpressAdRenderSuccess:(id)nativeExpressView{
    WindmillLogDebug(@"OSET", @"%@", NSStringFromSelector(_cmd));
    if([nativeExpressView isKindOfClass:[UIView class]]){
        [self.bridge nativeAd:self renderSuccessWithExpressView:nativeExpressView];
    }else{
    }
}
- (void)nativeExpressAdFailedToLoad:(nonnull id)nativeExpressAd error:(nonnull NSError *)error {
    WindmillLogDebug(@"OSET", @"%@", NSStringFromSelector(_cmd));
    [self.bridge nativeAd:self didLoadFailWithError:error];

}
- (void)nativeExpressAdFailedToRender:(nonnull id)nativeExpressView {
    WindmillLogDebug(@"OSET", @"%@", NSStringFromSelector(_cmd));
    [self.bridge nativeAd:self renderFailWithExpressView:nativeExpressView andError:nil];

}
- (void)nativeExpressAdDidClick:(nonnull id)nativeExpressView {
    WindmillLogDebug(@"OSET", @"%@", NSStringFromSelector(_cmd));
    [self.bridge nativeAd:self didClickWithMediatedNativeAd:nativeExpressView];

}
- (void)nativeExpressAdDidClose:(nonnull id)nativeExpressView {
    WindmillLogDebug(@"OSET", @"%@", NSStringFromSelector(_cmd));
    [self.bridge nativeAd:self didClose:nativeExpressView closeReasons:@[]];

}



@end
