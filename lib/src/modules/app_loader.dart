import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ui_providers.dart';
import 'loading/loading_screen.dart';
import 'home/view/home.view.dart';

class AppLoader extends ConsumerWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isAppLoadingProvider);
    final animationController = ref.watch(appLoaderAnimationControllerProvider);
    final actions = UIActions(ref);
    
    // Create fade animation
    final fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    void onLoadingComplete() async {
      // Start fade out animation
      await animationController.forward();
      
      // Hide loading screen
      actions.completeAppLoading();
    }

    return Scaffold(
      body: Stack(
        children: [
          // Main app content
          if (!isLoading) const HomeView(),
          
          // Loading screen with fade transition
          if (isLoading)
            AnimatedBuilder(
              animation: fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: fadeAnimation.value,
                  child: LoadingScreen(
                    onLoadingComplete: onLoadingComplete,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}