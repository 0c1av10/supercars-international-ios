import 'package:flutter/material.dart';

import 'main.dart';
import 'theme.dart';

/// Intro screen: the logo fades in and settles, a gold hairline draws
/// itself beneath it, then the wordmark letters appear one by one.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _wordmark = 'SUPER CARS INTERNATIONAL';

  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..forward();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, a1, a2) => const RootScreen(),
          transitionsBuilder: (context, a, a2, child) =>
              FadeTransition(opacity: a, child: child),
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paper,
      body: Center(
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            final t = _c.value;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Opacity(
                  opacity: _seg(t, 0.0, 0.45),
                  child: Transform.translate(
                    offset: Offset(0, 14 * (1 - _seg(t, 0.0, 0.45))),
                    child: Transform.scale(
                      scale: 0.96 + 0.04 * _seg(t, 0.0, 0.45),
                      child: Image.asset('assets/images/logo.png', height: 110),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: 150,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: _seg(t, 0.35, 0.7),
                      child: Container(height: 1.5, color: AppTheme.heroGold),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 16,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < _wordmark.length; i++)
                        Opacity(
                          opacity: _seg(t, 0.55 + i * 0.012, 0.65 + i * 0.012),
                          child: Text(
                            _wordmark[i],
                            style: const TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.5,
                              color: AppTheme.mid,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static double _seg(double t, double a, double b) =>
      ((t - a) / (b - a)).clamp(0.0, 1.0);
}
