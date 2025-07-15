import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import '../../providers/ui_providers.dart';

class LoadingScreen extends ConsumerWidget {
  final VoidCallback? onLoadingComplete;
  static bool _animationsStarted = false;
  
  const LoadingScreen({
    super.key,
    this.onLoadingComplete,
  });

  // Programming language icons and names
  static const List<Map<String, String>> programmingLanguages = [
    {'name': 'Flutter', 'icon': '💙', 'color': '0xFF0175C2'},
    {'name': 'Rust', 'icon': '🦀', 'color': '0xFFCE422B'},
    {'name': 'Dart', 'icon': '🎯', 'color': '0xFF0175C2'},
    {'name': 'JavaScript', 'icon': '⚡', 'color': '0xFFF7DF1E'},
    {'name': 'Python', 'icon': '🐍', 'color': '0xFF3776AB'},
    {'name': 'TypeScript', 'icon': '📘', 'color': '0xFF3178C6'},
    {'name': 'React', 'icon': '⚛️', 'color': '0xFF61DAFB'},
    {'name': 'Node.js', 'icon': '💚', 'color': '0xFF339933'},
  ];

  void _startAnimations(WidgetRef ref) async {
    if (_animationsStarted) return;
    _animationsStarted = true;
    
    final controllers = ref.read(loadingScreenAnimationControllersProvider);
    final actions = UIActions(ref);
    
    try {
      // Check if controllers are still mounted before starting animations
      if (controllers.fade.isCompleted || controllers.fade.isDismissed) {
        controllers.fade.reset();
      }
      if (controllers.scale.isCompleted || controllers.scale.isDismissed) {
        controllers.scale.reset();
      }
      if (controllers.progress.isCompleted || controllers.progress.isDismissed) {
        controllers.progress.reset();
      }
      
      // Start all animations with null checks
      if (!controllers.fade.isAnimating) {
        controllers.fade.forward();
      }
      
      await Future.delayed(const Duration(milliseconds: 300));
      
      if (!controllers.scale.isAnimating) {
        controllers.scale.forward();
      }
      if (!controllers.rotation.isAnimating) {
        controllers.rotation.repeat();
      }
      if (!controllers.progress.isAnimating) {
        controllers.progress.forward();
      }
      
      // Update loading progress
      actions.updateLoadingProgress(1.0);
      
      // Complete loading after animations
      await Future.delayed(const Duration(seconds: 3));
      if (onLoadingComplete != null) {
        onLoadingComplete!();
      }
    } catch (e) {
      // Handle animation controller disposal errors
      if (onLoadingComplete != null) {
        onLoadingComplete!();
      }
    } finally {
      _animationsStarted = false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = ref.watch(loadingScreenAnimationControllersProvider);
    
    // Create animations
    final rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: controllers.rotation,
      curve: Curves.linear,
    ));

    final scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controllers.scale,
      curve: Curves.elasticOut,
    ));

    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controllers.fade,
      curve: Curves.easeInOut,
    ));
    
    final progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controllers.progress,
      curve: Curves.easeInOut,
    ));

    // Start animations on first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimations(ref);
    });

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
            rotationAnimation,
            scaleAnimation,
            fadeAnimation,
            progressAnimation,
          ]),
          builder: (context, child) {
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;
            final isDesktop = Responsive.isDesktop(context);
            
            // Calculate responsive sizes
            final circleSize = isDesktop ? 300.0 : math.min(screenWidth * 0.8, 250.0);
            final centerIconSize = isDesktop ? 80.0 : 60.0;
            final orbitIconSize = isDesktop ? 60.0 : 45.0;
            final radius = isDesktop ? 120.0 : circleSize * 0.35;
            final progressBarWidth = isDesktop ? 300.0 : screenWidth * 0.8;
            
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? spacing64 : spacing24,
                      vertical: spacing32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Main logo/title
                        FadeTransition(
                          opacity: fadeAnimation,
                          child: ScaleTransition(
                            scale: scaleAnimation,
                            child: ShaderMask(
                              shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                              child: Text(
                                'Ether',
                                style: TextStyle(
                                  fontSize: isDesktop ? text6XL : text4XL,
                                  fontWeight: FontWeight.w900,
                                  color: white,
                                  letterSpacing: -2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: isDesktop ? spacing24 : spacing16),
                        
                        // Subtitle
                        FadeTransition(
                          opacity: fadeAnimation,
                          child: Text(
                            'Flutter & Rust Developer',
                            style: TextStyle(
                              fontSize: isDesktop ? textXL : textBase,
                              color: textSecondary,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        SizedBox(height: isDesktop ? spacing64 : spacing32),
                        
                        // Programming language icons circle
                        ScaleTransition(
                          scale: scaleAnimation,
                          child: SizedBox(
                            width: circleSize,
                            height: circleSize,
                            child: Stack(
                              children: [
                                // Center icon
                                Center(
                                  child: Container(
                                    width: centerIconSize,
                                    height: centerIconSize,
                                    decoration: BoxDecoration(
                                      gradient: primaryGradient,
                                      shape: BoxShape.circle,
                                      boxShadow: neonGlow,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '💻',
                                        style: TextStyle(fontSize: centerIconSize * 0.5),
                                      ),
                                    ),
                                  ),
                                ),
                                
                                // Rotating programming language icons
                                ...List.generate(programmingLanguages.length, (index) {
                                  final angle = (2 * math.pi / programmingLanguages.length) * index;
                                  final adjustedAngle = angle + rotationAnimation.value;
                                  
                                  return Positioned(
                                    left: circleSize/2 + radius * math.cos(adjustedAngle) - orbitIconSize/2,
                                    top: circleSize/2 + radius * math.sin(adjustedAngle) - orbitIconSize/2,
                                    child: Transform.rotate(
                                      angle: -rotationAnimation.value, // Counter-rotate to keep icons upright
                                      child: Container(
                                        width: orbitIconSize,
                                        height: orbitIconSize,
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
                                            style: TextStyle(fontSize: orbitIconSize * 0.4),
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
                        
                        SizedBox(height: isDesktop ? spacing64 : spacing32),
                        
                        // Loading progress bar
                        FadeTransition(
                          opacity: fadeAnimation,
                          child: Column(
                            children: [
                              const Text(
                                'Loading Portfolio...',
                                style: TextStyle(
                                  fontSize: textBase,
                                  color: textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: spacing16),
                              Container(
                                width: progressBarWidth,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: textMuted.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: progressBarWidth * progressAnimation.value,
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
                                '${(progressAnimation.value * 100).toInt()}%',
                                style: const TextStyle(
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
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}