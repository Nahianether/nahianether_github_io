import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import '../../providers/ui_providers.dart';

class LoadingScreen extends ConsumerWidget {
  final VoidCallback? onLoadingComplete;
  
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
    final controllers = ref.read(loadingScreenAnimationControllersProvider);
    final actions = UIActions(ref);
    
    // Start all animations
    controllers.fade.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    controllers.scale.forward();
    controllers.rotation.repeat();
    controllers.progress.forward();
    
    // Update loading progress
    actions.updateLoadingProgress(1.0);
    
    // Complete loading after animations
    await Future.delayed(const Duration(seconds: 3));
    if (onLoadingComplete != null) {
      onLoadingComplete!();
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
            return Center(
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
                    opacity: fadeAnimation,
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
                    scale: scaleAnimation,
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
                            final adjustedAngle = angle + rotationAnimation.value;
                            final radius = Responsive.isDesktop(context) ? 120.0 : 100.0;
                            
                            return Positioned(
                              left: 150 + radius * math.cos(adjustedAngle) - 30,
                              top: 150 + radius * math.sin(adjustedAngle) - 30,
                              child: Transform.rotate(
                                angle: -rotationAnimation.value, // Counter-rotate to keep icons upright
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
                          width: Responsive.isDesktop(context) ? 300 : 250,
                          height: 4,
                          decoration: BoxDecoration(
                            color: textMuted.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: (Responsive.isDesktop(context) ? 300 : 250) * progressAnimation.value,
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
            );
          },
        ),
      ),
    );
  }
}