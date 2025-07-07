import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import 'models/experience.dart';

class SkillsAndExperience extends StatelessWidget {
  const SkillsAndExperience({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? spacing64 : spacing24,
          vertical: spacing48,
        ),
        child: Column(
          children: [
            // Section Header
            Container(
              margin: const EdgeInsets.only(bottom: spacing48),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => neonGradient.createShader(bounds),
                    child: const Text(
                      'Skills & Experience',
                      style: TextStyle(
                        fontSize: text4XL,
                        fontWeight: FontWeight.w900,
                        color: white,
                        letterSpacing: -1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: spacing16),
                  const Text(
                    'My technical expertise and professional journey',
                    style: TextStyle(
                      fontSize: textLG,
                      color: textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Content Layout
            if (Responsive.isDesktop(context))
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Skills(),
                  ),
                  SizedBox(width: spacing48),
                  Expanded(
                    flex: 4,
                    child: Experience(),
                  ),
                ],
              )
            else
              const Column(
                children: [
                  Skills(),
                  SizedBox(height: spacing48),
                  Experience(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Skills extends StatelessWidget {
  const Skills({
    super.key,
  });

  // Modern skill categories with proficiency levels
  final List<Map<String, dynamic>> skillCategories = const [
    {
      'title': 'Mobile Development',
      'icon': '📱',
      'skills': [
        {'name': 'Flutter', 'level': 0.95},
        {'name': 'Dart', 'level': 0.95},
        {'name': 'Android', 'level': 0.85},
        {'name': 'iOS', 'level': 0.75},
      ],
    },
    {
      'title': 'Systems Programming',
      'icon': '🦀',
      'skills': [
        {'name': 'Rust', 'level': 0.75},
        {'name': 'C/C++', 'level': 0.70},
        {'name': 'System Design', 'level': 0.80},
        {'name': 'WebAssembly', 'level': 0.65},
      ],
    },
    {
      'title': 'State Management',
      'icon': '⚙️',
      'skills': [
        {'name': 'Riverpod', 'level': 0.90},
        {'name': 'Provider', 'level': 0.85},
        {'name': 'Bloc', 'level': 0.80},
        {'name': 'GetX', 'level': 0.70},
      ],
    },
    {
      'title': 'Backend & Database',
      'icon': '💾',
      'skills': [
        {'name': 'Firebase', 'level': 0.90},
        {'name': 'Rust Backend', 'level': 0.75},
        {'name': 'REST APIs', 'level': 0.95},
        {'name': 'Database', 'level': 0.85},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Skills Title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(spacing12),
              decoration: BoxDecoration(
                gradient: primaryGradient,
                borderRadius: BorderRadius.circular(radiusSM),
                boxShadow: neonGlow,
              ),
              child: const Text(
                '⚡',
                style: TextStyle(
                  fontSize: textXL,
                ),
              ),
            ),
            const SizedBox(width: spacing16),
            const Text(
              'Technical Skills',
              style: TextStyle(
                fontSize: text2XL,
                color: textPrimary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: spacing32),
        // Compact Skills Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
            childAspectRatio: 2.2,
            crossAxisSpacing: spacing20,
            mainAxisSpacing: spacing20,
          ),
          itemCount: skillCategories.length,
          itemBuilder: (context, index) {
            final category = skillCategories[index];
            return Container(
              padding: const EdgeInsets.all(spacing20),
              decoration: BoxDecoration(
                gradient: cardGradient,
                borderRadius: BorderRadius.circular(radiusLG),
                boxShadow: shadowMD,
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Compact Category Header
                  Row(
                    children: [
                      Text(
                        category['icon'],
                        style: const TextStyle(fontSize: textXL),
                      ),
                      const SizedBox(width: spacing8),
                      Expanded(
                        child: Text(
                          category['title'],
                          style: const TextStyle(
                            fontSize: textBase,
                            fontWeight: FontWeight.w700,
                            color: textPrimary,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: spacing16),
                  // Compact Skills List
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: (category['skills'] as List).map<Widget>((skill) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: spacing6),
                            child: Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withValues(alpha: 0.3),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: spacing6),
                                Expanded(
                                  child: Text(
                                    skill['name'],
                                    style: const TextStyle(
                                      fontSize: textXS,
                                      fontWeight: FontWeight.w500,
                                      color: textSecondary,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${(skill['level'] * 100).toInt()}%',
                                  style: const TextStyle(
                                    fontSize: textXS,
                                    fontWeight: FontWeight.w600,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class Experience extends StatelessWidget {
  const Experience({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Experience Title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(spacing12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [secondaryColor, primaryColor],
                ),
                borderRadius: BorderRadius.circular(radiusSM),
                boxShadow: greenGlow,
              ),
              child: const Text(
                '🏆',
                style: TextStyle(
                  fontSize: textXL,
                ),
              ),
            ),
            const SizedBox(width: spacing16),
            const Text(
              'Experience',
              style: TextStyle(
                fontSize: text2XL,
                color: textPrimary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: spacing32),
        // Compact Experience Timeline
        Column(
          children: experiences.take(4).map((experience) {
            return Container(
              margin: const EdgeInsets.only(bottom: spacing16),
              padding: const EdgeInsets.all(spacing16),
              decoration: BoxDecoration(
                gradient: cardGradient,
                borderRadius: BorderRadius.circular(radiusLG),
                boxShadow: shadowSM,
                border: Border.all(
                  color: secondaryColor.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Header
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusXS),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radiusXS),
                          child: Image.asset(
                            experience.imgPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: spacing12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.companyName,
                              style: const TextStyle(
                                fontSize: textBase,
                                color: textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              experience.location,
                              style: const TextStyle(
                                fontSize: textXS,
                                color: textMuted,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: spacing12),
                  // Latest Position
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: spacing12,
                      vertical: spacing6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(radiusXS),
                      border: Border.all(
                        color: primaryColor.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experience.designations.first.title,
                          style: const TextStyle(
                            fontSize: textSM,
                            color: textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: spacing2),
                        Text(
                          experience.designations.first.endDate == null
                              ? '${getFormatedDate(experience.designations.first.startDate)} - Present'
                              : '${getFormatedDate(experience.designations.first.startDate)} - ${getFormatedDate(experience.designations.first.endDate!)}',
                          style: const TextStyle(
                            fontSize: textXS,
                            color: secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}