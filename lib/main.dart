import 'package:flutter/material.dart';
import 'package:kids_games_pro/addition.dart';
import 'package:kids_games_pro/division.dart';
import 'package:kids_games_pro/multiply.dart';
import 'package:kids_games_pro/subtraction.dart';
import 'background_music.dart';
import 'package:lottie/lottie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool _isAnimating = false;
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BackgroundMusic.playMusic();
    _loadBannerAd();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-1229063300907623/9437030645',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {}); // Refresh the UI when the ad is loaded.
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Failed to load a banner ad: $error');
        },
      ),
    )..load();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-1229063300907623/9312137059',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('Failed to load an interstitial ad: $error');
          _isInterstitialAdLoaded = false;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _isInterstitialAdLoaded = false;
      _loadInterstitialAd(); // Load another interstitial ad for future use.
    }
  }

  void _navigateWithAnimation(BuildContext context, Widget destination) async {
    setState(() {
      _isAnimating = true;
    });

    try {
      await BackgroundMusic.stopMusic();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            _showInterstitialAd(); // Show the interstitial ad when navigating.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            ).then((_) {
              setState(() {
                _isAnimating = false;
              });
            });
          });

          return Center(
            child: Lottie.network(
              'https://lottie.host/1d4c07f0-9976-4dcd-bb6d-d5049795dc25/iHcPVMMx75.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          );
        },
      );
    } catch (e) {
      print('Error during navigation: $e');
      setState(() {
        _isAnimating = false;
      });
    }
  }

  void _navigateToAdditionScreen(BuildContext context) {
    _navigateWithAnimation(context, AdditionQuizGame());
  }

  void _navigateToSubtractionScreen(BuildContext context) {
    _navigateWithAnimation(context, SubtractionQuizGame());
  }

  void _navigateToMultiplicationScreen(BuildContext context) {
    _navigateWithAnimation(context, MultiplicationQuizGame());
  }

  void _navigateToDivisionScreen(BuildContext context) {
    _navigateWithAnimation(context, DivisionQuizGame());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/school-8766573.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Container(
                width: 300,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start Math Game',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black45,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildGameButton(context, 'Addition', Colors.green, _navigateToAdditionScreen),
                      SizedBox(height: 20),
                      _buildGameButton(context, 'Subtraction', Colors.red, _navigateToSubtractionScreen),
                      SizedBox(height: 20),
                      _buildGameButton(context, 'Multiplication', Colors.blue, _navigateToMultiplicationScreen),
                      SizedBox(height: 20),
                      _buildGameButton(context, 'Division', Colors.purple, _navigateToDivisionScreen),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bannerAd == null
          ? SizedBox.shrink()
          : Container(
              alignment: Alignment.center,
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
    );
  }

  Widget _buildGameButton(BuildContext context, String label, Color color, Function(BuildContext) navigate) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isAnimating = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isAnimating = false;
        });
        navigate(context);
      },
      onTapCancel: () {
        setState(() {
          _isAnimating = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _isAnimating ? 250 : 300,
        height: _isAnimating ? 60 : 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
