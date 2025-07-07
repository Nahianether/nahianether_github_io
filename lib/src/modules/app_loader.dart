import 'package:flutter/material.dart';

import 'loading/loading_screen.dart';
import 'home/view/home.view.dart';

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late AnimationController _transitionController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _transitionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _transitionController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  void _onLoadingComplete() async {
    // Start fade out animation
    await _transitionController.forward();
    
    // Hide loading screen
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main app content
          if (!_isLoading) const HomeView(),
          
          // Loading screen with fade transition
          if (_isLoading)
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: LoadingScreen(
                    onLoadingComplete: _onLoadingComplete,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}