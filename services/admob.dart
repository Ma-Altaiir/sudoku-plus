import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AdStatus { loading, loaded, failed }

class Admob {
  Admob._private();

  //Initialize
  static Future<void> init({@required bool testing}) async {
    //Declarations
    _appId = testing ? FirebaseAdMob.testAppId : "REAL_AD_UNIT";
    _videoId = testing ? RewardedVideoAd.testAdUnitId : "REAL_AD_UNIT";
    _bannerId = testing ? BannerAd.testAdUnitId : "REAL_AD_UNIT";
    _targetingInfo = MobileAdTargetingInfo(
      childDirected: false,
      nonPersonalizedAds: true,
      testDevices: testing ? ["DEVICE_ID"] : null,
      keywords: [],
    );
    //FirebaseAdmob
    await FirebaseAdMob.instance.initialize(
      appId: _appId,
      analyticsEnabled: true,
    );
  }

  //Properties
  static MobileAdTargetingInfo _targetingInfo;
  static String _appId;
  static String _videoId;

  static String _bannerId;

  //RewardedVideo
  static RewardedVideoAd _video;
  static bool _videoLoaded = false;

  static void _rewardVideoAdListener(RewardedVideoAdEvent event, {int rewardAmount, String rewardType}) {
    if (event == RewardedVideoAdEvent.failedToLoad) {
      _videoLoaded = false;
      if (_videoAdStatusListener != null) _videoAdStatusListener(AdStatus.failed);
    } else if (event == RewardedVideoAdEvent.loaded) {
      _videoLoaded = true;
      if (_videoAdStatusListener != null) _videoAdStatusListener(AdStatus.loaded);
    } else if (event == RewardedVideoAdEvent.rewarded) {
      if (_videoAdRewardListener != null) _videoAdRewardListener();
    } else if (event == RewardedVideoAdEvent.closed) {
      _videoLoaded = false;
      _video.load(adUnitId: _videoId, targetingInfo: _targetingInfo);
    }
  }

  static void Function(AdStatus) _videoAdStatusListener;
  static Future<void> loadVideoAd(void Function(AdStatus status) videoAdStatusListener) async {
    if (_videoLoaded) {
      videoAdStatusListener(AdStatus.loaded);
    } else {
      _video = RewardedVideoAd.instance;
      _video.listener = _rewardVideoAdListener;
      _videoAdStatusListener = videoAdStatusListener;
      _videoAdStatusListener(AdStatus.loading);
      _video.load(adUnitId: _videoId, targetingInfo: _targetingInfo);
    }
  }

  static void Function() _videoAdRewardListener;
  static void showVideoAd(void Function() videoAdRewardListener) {
    if (_videoLoaded) {
      _videoLoaded = false;
      _videoAdRewardListener = videoAdRewardListener;
      _video.show();
    }
  }

  //Banner
  static bool _bannerLoaded = false;
  static BannerAd _banner;

  static Future<void> loadBanner({@required void Function() onLoaded}) async {
    _banner = BannerAd(
      adUnitId: _bannerId,
      size: AdSize.largeBanner,
      targetingInfo: _targetingInfo,
      listener: _bannerAdListener,
    );
    _bannerLoadListener = onLoaded;
    await _banner.load();
  }

  static void Function() _bannerLoadListener;
  static void _bannerAdListener(MobileAdEvent event) {
    if (event == MobileAdEvent.loaded) {
      _bannerLoaded = true;
      _bannerLoadListener();
    } else if (event == MobileAdEvent.failedToLoad) {
      _bannerLoaded = false;
      Future.delayed(Duration(seconds: 30), () {
        loadBanner(onLoaded: _bannerLoadListener);
      });
    }
  }

  static Future<void> showBanner(double bottomOffset) async {
    if (_bannerLoaded) {
      await _banner.show(
        anchorType: AnchorType.bottom,
        anchorOffset: bottomOffset,
        horizontalCenterOffset: 0.0,
      );
    }
  }

  static void destroyBanner() {
    _banner.dispose();
    _banner = null;
  }
}
