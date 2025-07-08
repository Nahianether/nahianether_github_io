import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// App loading state provider
final isAppLoadingProvider = StateProvider<bool>((ref) => true);

// Maintenance banner state provider
final isMaintenanceBannerVisibleProvider = StateProvider<bool>((ref) => false);

// Hover state providers for interactive components
final socialLinkHoverProvider = StateProvider.family<bool, String>((ref, linkId) => false);
final socialCardHoverProvider = StateProvider.family<bool, String>((ref, cardId) => false);

// Contact form state providers
final contactFormKeyProvider = Provider<GlobalKey<FormState>>((ref) => GlobalKey<FormState>());
final nameControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final emailControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final messageControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final projectTypeControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final projectBudgetControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final descriptionControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final isContactFormSubmittingProvider = StateProvider<bool>((ref) => false);

// Loading screen animation state providers
final isLoadingScreenVisibleProvider = StateProvider<bool>((ref) => true);
final loadingProgressProvider = StateProvider<double>((ref) => 0.0);

// UI Actions for state mutations
class UIActions {
  UIActions(this.ref);
  
  final WidgetRef ref;
  
  // App loading actions
  void setAppLoading(bool isLoading) {
    ref.read(isAppLoadingProvider.notifier).state = isLoading;
  }
  
  void completeAppLoading() {
    ref.read(isAppLoadingProvider.notifier).state = false;
  }
  
  // Maintenance banner actions
  void showMaintenanceBanner() {
    ref.read(isMaintenanceBannerVisibleProvider.notifier).state = true;
  }
  
  void hideMaintenanceBanner() {
    ref.read(isMaintenanceBannerVisibleProvider.notifier).state = false;
  }
  
  // Hover state actions
  void setSocialLinkHover(String linkId, bool isHovered) {
    ref.read(socialLinkHoverProvider(linkId).notifier).state = isHovered;
  }
  
  void setSocialCardHover(String cardId, bool isHovered) {
    ref.read(socialCardHoverProvider(cardId).notifier).state = isHovered;
  }
  
  // Contact form actions
  void setContactFormSubmitting(bool isSubmitting) {
    ref.read(isContactFormSubmittingProvider.notifier).state = isSubmitting;
  }
  
  void clearContactForm() {
    ref.read(nameControllerProvider).clear();
    ref.read(emailControllerProvider).clear();
    ref.read(messageControllerProvider).clear();
    ref.read(projectTypeControllerProvider).clear();
    ref.read(projectBudgetControllerProvider).clear();
    ref.read(descriptionControllerProvider).clear();
  }
  
  // Loading screen actions
  void setLoadingScreenVisible(bool isVisible) {
    ref.read(isLoadingScreenVisibleProvider.notifier).state = isVisible;
  }
  
  void updateLoadingProgress(double progress) {
    ref.read(loadingProgressProvider.notifier).state = progress;
  }
  
  void completeLoading() {
    ref.read(isLoadingScreenVisibleProvider.notifier).state = false;
    ref.read(loadingProgressProvider.notifier).state = 1.0;
  }
}

// Animation controller providers (for proper disposal)
final appLoaderAnimationControllerProvider = Provider.autoDispose<AnimationController>((ref) {
  final controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: ref.watch(tickerProviderProvider),
  );
  
  ref.onDispose(() {
    controller.dispose();
  });
  
  return controller;
});

final loadingScreenAnimationControllersProvider = Provider.autoDispose<LoadingAnimationControllers>((ref) {
  final tickerProvider = ref.watch(tickerProviderProvider);
  
  final controllers = LoadingAnimationControllers(
    rotation: AnimationController(
      duration: const Duration(seconds: 3),
      vsync: tickerProvider,
    ),
    scale: AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: tickerProvider,
    ),
    fade: AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: tickerProvider,
    ),
    progress: AnimationController(
      duration: const Duration(seconds: 5),
      vsync: tickerProvider,
    ),
  );
  
  ref.onDispose(() {
    controllers.dispose();
  });
  
  return controllers;
});

// Custom ticker provider for Riverpod
final tickerProviderProvider = Provider<TickerProvider>((ref) => _RiverpodTickerProvider());

class _RiverpodTickerProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

// Animation controllers container for loading screen
class LoadingAnimationControllers {
  LoadingAnimationControllers({
    required this.rotation,
    required this.scale,
    required this.fade,
    required this.progress,
  });
  
  final AnimationController rotation;
  final AnimationController scale;
  final AnimationController fade;
  final AnimationController progress;
  
  void dispose() {
    rotation.dispose();
    scale.dispose();
    fade.dispose();
    progress.dispose();
  }
}