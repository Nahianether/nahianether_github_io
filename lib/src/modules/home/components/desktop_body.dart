import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../providers/ui_providers.dart';
import '../../content/contact_section.dart';
import '../../content/cv_section.dart';
import '../../content/footer.dart';
import '../../content/k_divider.dart';
import '../../content/recent_works.dart';
import '../../content/skills_and_experience.dart';
import '../../content/top_intro_section.dart';
import '../../content/top_menu_bar.dart';
import '../../service-break/service_break_banner.dart';

class DesktopBody extends ConsumerWidget {
  const DesktopBody({super.key});

  static final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMaintenanceVisible = ref.watch(isMaintenanceBannerVisibleProvider);
    final actions = UIActions(ref);
    
    // Set initial maintenance state based on global config
    if (isGlobalMaintainence && !isMaintenanceVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        actions.showMaintenanceBanner();
      });
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
          controller: _scrollController,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: maxWidth),
              child: Column(
                children: [
                  // Maintenance banner with smooth animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    height: isMaintenanceVisible ? 38.0 : 0.0,
                    child: isMaintenanceVisible
                        ? ServiceBreakBanner(
                            height: 38.0,
                            onPressed: () {
                              actions.hideMaintenanceBanner();
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 80),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2, vertical: defaultPadding * 0.5),
                    child: Align(alignment: Alignment.centerRight, child: FooterAllSocialsLinks()),
                  ),
                  TopIntroSection(key: topIntroSectionKey),
                  const KDivider(),
                  SkillsAndExperience(key: aboutSectionKey),
                  const KDivider(),
                  RecentWorks(key: recentWorksSectionKey),
                  const SizedBox(height: defaultPadding * 2),
                  const KDivider(),
                  CVSection(key: cvSectionKey),
                  const KDivider(),
                  ContactSection(key: contactSectionKey),
                  const KDivider(),
                  Footer(key: socialLinksSectionKey)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: maxWidth),
              child: TopMenuBar(key: topMenubarSectionKey),
            ),
          ),
        ),
      ],
    ),
    );
  }
}
