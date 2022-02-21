import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_ads/constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider extends ChangeNotifier {
  AdProvider() {
    createBottomBannerAd();
    createBigBottomBannerAd();
    loadInterstitialAd();
    loadRewardAd();
  }

  BannerAd get bottomBannerAd => _bottomBannerAd;
  late BannerAd _bottomBannerAd;
  void createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
    notifyListeners();
  }

  // Bigger banner ad
  BannerAd get bigBottomBannerAd => _bigBottomBannerAd;
  late BannerAd _bigBottomBannerAd;
  void createBigBottomBannerAd() {
    _bigBottomBannerAd = BannerAd(
      adUnitId: bannerId,
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bigBottomBannerAd.load();
    notifyListeners();
  }

  late InterstitialAd interstitialAd;

  loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;

          // Keep a reference to the ad so you can show it later.
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  showInterstitialAd() {
    interstitialAd.show();
    loadInterstitialAd();
  }

  late RewardedAd rewardedAd;
  // for reward ads (video ad)
  loadRewardAd() {
    RewardedAd.load(
      adUnitId: rewardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          log('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  showRewardAd() {
    rewardedAd.show(
      onUserEarnedReward: (ad, reward) {
        log("Reward Earned");
      },
    );
    loadRewardAd();
  }
}
