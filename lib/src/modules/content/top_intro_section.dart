import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import '../../constants/size_config/size_config.dart';

class TopIntroSection extends StatelessWidget {
  const TopIntroSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: heroGradient,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? spacing64 : spacing24,
          vertical: Responsive.isDesktop(context) ? spacing80 : spacing48,
        ),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: mainCenter,
                crossAxisAlignment: crossStart,
                children: [
                // Modern Hero Title
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hi, I\'m ',
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context) ? text4XL : text3XL,
                          fontWeight: FontWeight.w300,
                          color: textSecondary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'Intishar-Ul Islam',
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context) ? text4XL : text3XL,
                          fontWeight: FontWeight.w700,
                          color: textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: spacing16),
                // Animated Gradient Text
                ShaderMask(
                  shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                  child: Text(
                    'Ether',
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ? text5XL : text4XL,
                      fontWeight: FontWeight.w900,
                      color: white,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
                const SizedBox(height: spacing24),
                // Modern Role Description
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: spacing20,
                    vertical: spacing12,
                  ),
                  decoration: BoxDecoration(
                    gradient: glassGradient,
                    borderRadius: BorderRadius.circular(radiusLG),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    '🚀 Senior Flutter & Rust Developer • 5+ Years Experience',
                    style: TextStyle(
                      fontSize: textLG,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: spacing32),
                // Modern Description
                const Text(
                  'Passionate about creating beautiful, performant mobile applications and robust system-level software. Currently leading Flutter & Rust development at Algorithm Generation Limited, building scalable solutions for diverse industries.',
                  style: TextStyle(
                    fontSize: textBase,
                    color: textSecondary,
                    height: 1.6,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: spacing40),
                // Modern Skills Section
                const Text(
                  'Tech Stack',
                  style: TextStyle(
                    fontSize: textXL,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: spacing20),
                Wrap(
                  spacing: spacing12,
                  runSpacing: spacing12,
                  children: List.generate(
                    skills.length,
                    (index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacing16,
                        vertical: spacing8,
                      ),
                      decoration: BoxDecoration(
                        gradient: cardGradient,
                        borderRadius: BorderRadius.circular(radiusSM),
                        boxShadow: shadowSM,
                        border: Border.all(
                          color: primaryColor.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: secondaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: spacing8),
                          Text(
                            skills[index],
                            style: const TextStyle(
                              fontSize: textSM,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: defaultPadding * 2),
                // const Text.rich(
                //   TextSpan(
                //     children: [
                //       TextSpan(
                //         text: 'An Undergraduate Student ',
                //         style: TextStyle(
                //           fontSize: 15,
                //           color: kDefaultColor,
                //           letterSpacing: 0.6,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       TextSpan(
                //         text: "from East West University.",
                //         style: TextStyle(
                //           fontSize: 15,
                //           letterSpacing: 0.6,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: defaultPadding * 0.35),
                // const Text(
                //   '(B.Sc in CSE from 2019 to Present [Dec 2022]*) ',
                //   style: TextStyle(
                //     fontSize: 13.5,
                //     // color: kDefaultColor,
                //     letterSpacing: 0.6,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: spacing48),
                // Modern CTA Buttons
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: primaryGradient,
                        borderRadius: BorderRadius.circular(radiusLG),
                        boxShadow: shadowLG,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (contactSectionKey.currentContext != null) {
                            await Scrollable.ensureVisible(
                              contactSectionKey.currentContext!,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOutCubic,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: spacing32,
                            vertical: spacing16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radiusLG),
                          ),
                        ),
                        child: const Text(
                          'Get In Touch',
                          style: TextStyle(
                            fontSize: textBase,
                            fontWeight: FontWeight.w600,
                            color: white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: spacing20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(radiusLG),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!await launchUrl(Uri.parse('https://github.com/Nahianether'))) {
                            throw 'Could not launch GitHub profile';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: spacing32,
                            vertical: spacing16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radiusLG),
                          ),
                        ),
                        child: const Text(
                          'View Projects',
                          style: TextStyle(
                            fontSize: textBase,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: spacing32),
                if (!Responsive.isDesktop(context)) 
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusXL),
                      boxShadow: shadowXL,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusXL),
                      child: Image.asset('assets/gifs/programmer.gif'),
                    ),
                  ),
              ],
            ),
          ),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusXXL),
                    boxShadow: shadowXL,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXXL),
                    child: Image.asset('assets/gifs/programmer.gif'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => primaryGradient.createShader(bounds),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: text3XL,
              fontWeight: FontWeight.w900,
              color: white,
              letterSpacing: -1.0,
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: textSM,
            color: textMuted,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
