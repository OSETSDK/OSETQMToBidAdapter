//
//  OSETNativeAdViewCreator.h
//  YhsADSProject
//
//  Created by Shens on 11/7/2025.
//

#import <Foundation/Foundation.h>
#import <WindMillSDK/WindMillSDK.h>

#import <OSETSDK/OSETSDK.h>


NS_ASSUME_NONNULL_BEGIN
@interface OSETNativeAdViewCreator : NSObject<AWMMediatedNativeAdViewCreator>
- (instancetype)initWithExpressAd:(OSETNativeAd *)nativeAd adView:(OSETBaseView *)adView;

@end

NS_ASSUME_NONNULL_END
