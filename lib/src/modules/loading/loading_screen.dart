import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';

class LoadingScreen extends StatefulWidget {
  final VoidCallback? onLoadingComplete;
  
  const LoadingScreen({
    super.key,
    this.onLoadingComplete,
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _progressController;
  
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _progressAnimation;

  // Programming language icons and names
  final List<Map<String, String>> programmingLanguages = [
    {'name': 'Flutter', 'icon': '💙', 'color': '0xFF0175C2'},
    {'name': 'Rust', 'icon': '🦀', 'color': '0xFFCE422B'},
    {'name': 'Dart', 'icon': '🎯', 'color': '0xFF0175C2'},
    {'name': 'JavaScript', 'icon': '⚡', 'color': '0xFFF7DF1E'},
    {'name': 'Python', 'icon': '🐍', 'color': '0xFF3776AB'},
    {'name': 'TypeScript', 'icon': '📘', 'color': '0xFF3178C6'},
    {'name': 'React', 'icon': '⚛️', 'color': '0xFF61DAFB'},
    {'name': 'Node.js', 'icon': '💚', 'color': '0xFF339933'},
  ];

  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _progressController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    // Start all animations
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();
    _rotationController.repeat();
    _progressController.forward();
    
    // Complete loading after animations
    await Future.delayed(const Duration(seconds: 3));
    if (widget.onLoadingComplete != null) {
      widget.onLoadingComplete!();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _fadeController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _rotationAnimation,
            _scaleAnimation,
            _fadeAnimation,
            _progressAnimation,
          ]),
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main logo/title
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ShaderMask(
                        shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                        child: Text(
                          'Ether',
                          style: TextStyle(
                            fontSize: Responsive.isDesktop(context) ? text6XL : text5XL,
                            fontWeight: FontWeight.w900,
                            color: white,
                            letterSpacing: -2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: spacing24),
                  
                  // Subtitle
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Flutter & Rust Developer',
                      style: TextStyle(
                        fontSize: Responsive.isDesktop(context) ? textXL : textLG,
                        color: textSecondary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: spacing64),
                  
                  // Programming language icons circle
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: SizedBox(
                      width: Responsive.isDesktop(context) ? 300 : 250,
                      height: Responsive.isDesktop(context) ? 300 : 250,
                      child: Stack(
                        children: [
                          // Center icon
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: primaryGradient,
                                shape: BoxShape.circle,
                                boxShadow: neonGlow,
                              ),
                              child: const Center(
                                child: Text(
                                  '💻',
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ),
                          
                          // Rotating programming language icons
                          ...List.generate(programmingLanguages.length, (index) {
                            final angle = (2 * math.pi / programmingLanguages.length) * index;
                            final adjustedAngle = angle + _rotationAnimation.value;
                            final radius = Responsive.isDesktop(context) ? 120.0 : 100.0;
                            
                            return Positioned(
                              left: 150 + radius * math.cos(adjustedAngle) - 30,
                              top: 150 + radius * math.sin(adjustedAngle) - 30,
                              child: Transform.rotate(
                                angle: -_rotationAnimation.value, // Counter-rotate to keep icons upright
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: cardGradient,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(int.parse(programmingLanguages[index]['color']!)).withValues(alpha: 0.3),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(int.parse(programmingLanguages[index]['color']!)).withValues(alpha: 0.2),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      programmingLanguages[index]['icon']!,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: spacing64),
                  
                  // Loading progress bar
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          'Loading Portfolio...',
                          style: TextStyle(
                            fontSize: textBase,
                            color: textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: spacing16),
                        Container(
                          width: Responsive.isDesktop(context) ? 300 : 250,
                          height: 4,
                          decoration: BoxDecoration(
                            color: textMuted.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: (Responsive.isDesktop(context) ? 300 : 250) * _progressAnimation.value,
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: primaryGradient,
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: spacing12),
                        Text(
                          '${(_progressAnimation.value * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: textSM,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}