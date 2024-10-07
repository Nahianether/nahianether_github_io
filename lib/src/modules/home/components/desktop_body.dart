import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../content/contact_section.dart';
import '../../content/footer.dart';
import '../../content/k_divider.dart';
import '../../content/recent_works.dart';
import '../../content/skills_and_experience.dart';
import '../../content/top_intro_section.dart';
import '../../content/top_menu_bar.dart';
import '../../service-break/service_break_banner.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _BodyState();
}

class _BodyState extends State<DesktopBody> {
  bool isMaintainence = isGlobalMaintainence;
  double height = 38.0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              if (isMaintainence)
                ServiceBreakBanner(
                  height: height,
                  onPressed: () => setState(() {
                    height = 0.0;
                    Future.delayed(const Duration(milliseconds: 350), () {
                      isMaintainence = false;
                    });
                  }),
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
              ContactSection(key: contactSectionKey),
              const KDivider(),
              Footer(key: socialLinksSectionKey)
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: TopMenuBar(key: topMenubarSectionKey),
        ),
      ],
    );
  }
}
