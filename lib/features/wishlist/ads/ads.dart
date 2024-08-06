import 'package:daily_flyers_app/utils/constants/ad_managers.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  InterstitialAd? interstitialAd;

  void showAd() {
    InterstitialAd.load(
      adUnitId: AdManagers.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          if(interstitialAd != null) {
            interstitialAd!.show();
          }
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdWillDismissFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (error) {
          logError(error.toString());
        },
      ),
    );
  }
}
