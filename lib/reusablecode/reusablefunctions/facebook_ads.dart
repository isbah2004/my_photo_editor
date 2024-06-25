import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:my_photo_editor/provider/ads_provider.dart';
import 'package:provider/provider.dart';

class FacebookAds {
  static showInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#1294301481548858_1294624654849874",
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd();
        }
      },
    );
  }

  static showRewardedAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId:
          "VID_HD_16_9_15S_APP_INSTALL#408076848318642_408077341651926",
      listener: (result, value) {
        if (result == RewardedVideoAdResult.LOADED) {
          FacebookRewardedVideoAd.showRewardedVideoAd();
        }
      },
    );
  }

  static Widget pickerNativeAd() {
    return Consumer<PickerAdProvider>(
      builder: (context, providerValue, child) {
        return SizedBox(
          height: providerValue.pickerAdLoaded ? 50 : 0,
          width: double.maxFinite,
          child: FacebookNativeAd(
            placementId:
                "IMG_16_9_APP_INSTALL#1294301481548858_1294302068215466",
            adType: NativeAdType.NATIVE_BANNER_AD,
            bannerAdSize: NativeBannerAdSize.HEIGHT_50,
            width: double.infinity,
            backgroundColor: Colors.black,
            listener: (result, value) {
              if (result == NativeAdResult.LOADED) {
                providerValue.setPickerAdState(true);
              }
            },
          ),
        );
      },
    );
  }

  static Widget homeNativeAd() {
    return Consumer<HomeAdProvider>(
      builder: (context, providerValue, child) {
        return SizedBox(
          height: providerValue.homeAdLoaded ? 50 : 0,
          width: double.maxFinite,
          child: FacebookNativeAd(
            placementId:
                "IMG_16_9_APP_INSTALL#1294301481548858_1294302068215466",
            adType: NativeAdType.NATIVE_BANNER_AD,
            bannerAdSize: NativeBannerAdSize.HEIGHT_50,
            width: double.infinity,
            backgroundColor: Colors.black,
            listener: (result, value) {
              if (result == NativeAdResult.LOADED) {
                providerValue.setHomeAdState(true);
              }
            },
          ),
        );
      },
    );
  }
}
