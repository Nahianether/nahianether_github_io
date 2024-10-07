import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/size_config/responsive.dart';
import '../../content/contact_section.dart';
import '../../content/footer.dart';
import '../../content/k_divider.dart';
import '../../content/recent_works.dart';
import '../../content/skills_and_experience.dart';
import '../../content/top_intro_section.dart';
import '../../content/top_menu_bar.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopMenuBar(key: topMenubarSectionKey),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding,
                  vertical: defaultPadding * 0.5),
              child: const Align(alignment: Alignment.centerRight, child: FooterAllSocialsLinks())),
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
    );
  }
}
