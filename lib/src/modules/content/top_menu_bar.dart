import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';

class TopMenuBar extends StatelessWidget {
  const TopMenuBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? spacing64 : spacing24,
          vertical: spacing12,
        ),
        child: Row(
          children: [
            if (Responsive.isMobile(context))
              InkWell(
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(spacing8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(radiusSM),
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/menu.svg',
                    colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                  ),
                ),
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
            // Modern logo section
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSM),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: neonGlow,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSM),
                    child: Image.asset('assets/icons/ether.jpeg'),
                  ),
                ),
                const SizedBox(width: spacing16),
                ShaderMask(
                  shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                  child: const Text(
                    'ETHER',
                    style: TextStyle(
                      fontSize: textXL,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w900,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (Responsive.isDesktop(context))
              Row(
                children: [
                  _buildNavButton(
                    'Home',
                    () async => await Scrollable.ensureVisible(
                      topIntroSectionKey.currentContext!,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  const SizedBox(width: spacing32),
                  _buildNavButton(
                    'About',
                    () async => await Scrollable.ensureVisible(
                      aboutSectionKey.currentContext!,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  const SizedBox(width: spacing32),
                  _buildNavButton(
                    'Projects',
                    () async => await Scrollable.ensureVisible(
                      recentWorksSectionKey.currentContext!,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  const SizedBox(width: spacing32),
                  _buildNavButton(
                    'Contact',
                    () async => await Scrollable.ensureVisible(
                      contactSectionKey.currentContext!,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCubic,
                    ),
                  ),
                  const SizedBox(width: spacing40),
                  // Modern CTA Button
                  Container(
                    decoration: BoxDecoration(
                      gradient: primaryGradient,
                      borderRadius: BorderRadius.circular(radiusLG),
                      boxShadow: neonGlow,
                    ),
                    child: ElevatedButton(
                      onPressed: () async => await Scrollable.ensureVisible(
                        contactSectionKey.currentContext!,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOutCubic,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: spacing24,
                          vertical: spacing12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radiusLG),
                        ),
                      ),
                      child: const Text(
                        'Hire Me',
                        style: TextStyle(
                          fontSize: textSM,
                          fontWeight: FontWeight.w600,
                          color: white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: spacing16,
          vertical: spacing8,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: textBase,
          fontWeight: FontWeight.w500,
          color: textSecondary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// Updated TopBarButton for consistency
class TopBarButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const TopBarButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: spacing20,
          vertical: spacing16,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: textBase,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}