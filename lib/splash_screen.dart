import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _pulseController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoTilt;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _progressWidth;
  late final Animation<double> _pulseGlow;

  Timer? _holdTimer;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // Main entrance animation timeline (1800ms)
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Continuous subtle ambient breathing pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    // 1. Logo scale entrance with playful spring
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.50, curve: Curves.easeOutBack),
      ),
    );

    // 2. Playful mortarboard tilt settling to upright
    _logoTilt = Tween<double>(begin: -0.18, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.05, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    // 3. App Title fade & slide up
    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.35, 0.72, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.35, 0.72, curve: Curves.easeOutCubic),
      ),
    );

    // 4. Tagline & university badge fade & slide
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.55, 0.90, curve: Curves.easeOut),
      ),
    );
    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.55, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    // 5. Sleek loading progress bar
    _progressWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.20, 0.98, curve: Curves.easeInOutCubic),
      ),
    );

    // 6. Ambient breathing glow
    _pulseGlow = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Once entrance animation finishes, hold for 800ms before navigating
    // giving the user ~2.6s of visible, beautiful animation time on cold start
    _mainController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _holdTimer?.cancel();
        _holdTimer = Timer(const Duration(milliseconds: 800), () {
          _navigateToHome();
        });
      }
    });

    // CRITICAL: Only start animation after the first frame has painted on screen!
    // This prevents cold-boot engine load time from consuming the splash screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _mainController.forward(from: 0.0);
      }
    });
  }

  void _navigateToHome() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.98, end: 1.0).animate(curved),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 650),
      ),
    );
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildAmbientGlowEffect(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                _buildAnimatedLogo(),
                const SizedBox(height: 28),
                _buildBrandTitle(),
                const SizedBox(height: 8),
                _buildTagline(),
                const Spacer(flex: 2),
                _buildLoadingProgressBar(),
                const SizedBox(height: 20),
                _buildFooterBadge(),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 1. Warm coral gradient background
  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFF5A26), // Electric Coral
            Color(0xFFE23D0C), // Vibrant Mid-Tone
            Color(0xFF9E2200), // Deep Brand Crimson
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
    );
  }

  /// 2. Ambient radial glow circles in the background
  Widget _buildAmbientGlowEffect() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: _SplashGlowPainter(scale: _pulseGlow.value),
          ),
        );
      },
    );
  }

  /// 3. Scaled, tilted, pulsing animated project logo
  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScale.value,
          child: Transform.rotate(
            angle: _logoTilt.value,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, _) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: [
                      // Deep ground shadow
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 14),
                      ),
                      // Vibrant ambient coral bloom
                      BoxShadow(
                        color: Colors.white.withValues(
                          alpha: 0.35 * _pulseGlow.value,
                        ),
                        blurRadius: 28 * _pulseGlow.value,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Resilient fallback icon
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            color: Colors.white,
                            size: 56,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// 4. Animated CampusEats Brand Title
  Widget _buildBrandTitle() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _titleFade,
          child: SlideTransition(
            position: _titleSlide,
            child: Column(
              children: [
                Text(
                  'CampusEats',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.8,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 5. Animated Collegiate Tagline & Campus Chip
  Widget _buildTagline() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _taglineFade,
          child: SlideTransition(
            position: _taglineSlide,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.28),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    color: AppColors.secondary,
                    size: 15,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Fast Campus Delivery • Hot & Fresh',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 6. Sleek animated loading progress bar
  Widget _buildLoadingProgressBar() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _taglineFade,
          child: Container(
            width: 140,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 140 * _progressWidth.value,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.8),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 7. Collegiate Footer Badge
  Widget _buildFooterBadge() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _taglineFade,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.school_outlined,
                size: 13,
                color: Colors.white.withValues(alpha: 0.75),
              ),
              const SizedBox(width: 5),
              Text(
                'COLLEGIATE DINING NETWORK',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withValues(alpha: 0.75),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom painter for background ambient bloom
class _SplashGlowPainter extends CustomPainter {
  final double scale;

  _SplashGlowPainter({required this.scale});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.45);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.12 * scale),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: 180 * scale),
      );

    canvas.drawCircle(center, 180 * scale, paint);
  }

  @override
  bool shouldRepaint(covariant _SplashGlowPainter oldDelegate) {
    return oldDelegate.scale != scale;
  }
}
