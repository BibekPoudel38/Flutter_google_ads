import 'package:flutter/material.dart';
import 'package:flutter_google_ads/constants.dart';
import 'package:flutter_google_ads/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Google Mobile Ads Test'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is a test app for Flutter Google Ads',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              "This app includes Banner Ad and Interstitial Ad",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: context
                  .watch<AdProvider>()
                  .bigBottomBannerAd
                  .size
                  .height
                  .toDouble(),
              width: context
                  .watch<AdProvider>()
                  .bigBottomBannerAd
                  .size
                  .width
                  .toDouble(),
              child:
                  AdWidget(ad: context.watch<AdProvider>().bigBottomBannerAd),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AdProvider>().showRewardAd();
              },
              child: Text(
                "Show Reward Ad",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height:
            context.watch<AdProvider>().bottomBannerAd.size.height.toDouble(),
        width: context.watch<AdProvider>().bottomBannerAd.size.width.toDouble(),
        child: AdWidget(ad: context.watch<AdProvider>().bottomBannerAd),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AdProvider>().showInterstitialAd();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
