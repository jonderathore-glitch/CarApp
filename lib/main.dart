import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const CarcosApp());
}

class CarcosApp extends StatelessWidget {
  const CarcosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CARCOS',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

// ---------------- 1. FULL SCREEN SPLASH SCREEN ----------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Aapki Poori Splash Screen Image ka URL
  final String _splashImageUrl = 'https://i.ibb.co/MkyNn4Fn/20261001-161822.png';

  @override
  void initState() {
    super.initState();

    // 3 Seconds baad Login Screen par Auto-Navigate
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const CarcosLoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 700),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. FULL SCREEN SPLASH IMAGE
          Positioned.fill(
            child: Image.network(
              _splashImageUrl,
              fit: BoxFit.cover, // Poori screen par fit karne ke liye
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF62AADC),
                child: const Center(
                  child: Icon(Icons.emoji_events, size: 80, color: Colors.white),
                ),
              ),
            ),
          ),

          // 2. BOTTOM GHUMNE WALA LOADER (Progress Spinner)
          const Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: Colors.white, // White color spinner
                  strokeWidth: 3.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- 2. MAIN LOGIN SCREEN ----------------
class CarcosLoginScreen extends StatefulWidget {
  const CarcosLoginScreen({super.key});

  @override
  State<CarcosLoginScreen> createState() => _CarcosLoginScreenState();
}

class _CarcosLoginScreenState extends State<CarcosLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isAbove18Checked = false;

  double? _fixedScreenHeight;

  final String _logoImageUrl = 'https://i.ibb.co/MkvCbLRZ/20261002-080144.png';
  final String _bgImageUrl = 'https://i.ibb.co/pv4s29Mt/20261002-085101.png';

  static const Color skyBlueAccent = Color(0xFF00E5FF);

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    if (_fixedScreenHeight == null || currentHeight > _fixedScreenHeight!) {
      _fixedScreenHeight = currentHeight;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: _fixedScreenHeight,
        child: Stack(
          children: [
            // FIXED BOTTOM BACKGROUND IMAGE
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: _fixedScreenHeight! * 0.45,
              child: Opacity(
                opacity: 0.55,
                child: Image.network(
                  _bgImageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(),
                ),
              ),
            ),

            // GRADIENT OVERLAY
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: _fixedScreenHeight! * 0.50,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Color(0xCC000000),
                      Color(0x66000000),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.25, 0.55, 1.0],
                  ),
                ),
              ),
            ),

            // FORM CONTENT
            SafeArea(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.help_outline, color: Colors.white70, size: 24),
                    ),
                    const SizedBox(height: 20),

                    // LOGO
                    SizedBox(
                      height: 110,
                      width: double.infinity,
                      child: Transform.scale(
                        scale: 1.8,
                        child: Image.network(
                          _logoImageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text(
                              'CARCOS',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    // INPUT BOX
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF101216).withOpacity(0.90),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _phoneController.text.length == 10 
                              ? skyBlueAccent.withOpacity(0.6) 
                              : Colors.white24, 
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.network(
                              'https://flagcdn.com/w40/in.png',
                              width: 22,
                              height: 15,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '+91',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Enter mobile",
                                hintStyle: TextStyle(color: Colors.white38, fontSize: 16),
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // CHECKBOX
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _isAbove18Checked,
                            activeColor: skyBlueAccent,
                            checkColor: Colors.black,
                            side: const BorderSide(color: Colors.white38, width: 1.5),
                            onChanged: (val) {
                              setState(() {
                                _isAbove18Checked = val ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "I am above 18 years of age and accept the Terms & Conditions and Privacy policy",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (_phoneController.text.length == 10 && _isAbove18Checked)
                              ? skyBlueAccent
                              : const Color(0xFF23242A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        onPressed: (_phoneController.text.length == 10 && _isAbove18Checked)
                            ? () {}
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CONTINUE',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: (_phoneController.text.length == 10 && _isAbove18Checked)
                                    ? Colors.black
                                    : Colors.white38,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: (_phoneController.text.length == 10 && _isAbove18Checked)
                                  ? Colors.black
                                  : Colors.white38,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
