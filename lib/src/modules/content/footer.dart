import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import '../../providers/ui_providers.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF111113),
            Color(0xFF0A0A0B),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? spacing64 : spacing24,
          vertical: spacing48,
        ),
        child: Column(
          children: [
            // Footer Content
            if (Responsive.isDesktop(context))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFooterBrand(),
                  const FooterAllSocialsLinks(),
                ],
              )
            else
              Column(
                children: [
                  _buildFooterBrand(),
                  const SizedBox(height: spacing32),
                  const FooterAllSocialsLinks(),
                ],
              ),
            
            const SizedBox(height: spacing32),
            
            // Divider
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    primaryColor.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: spacing24),
            
            // Copyright
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© ${DateTime.now().year} ',
                  style: const TextStyle(
                    color: textMuted,
                    fontSize: textSM,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                ShaderMask(
                  shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                  child: const Text(
                    'Intishar-Ul Islam',
                    style: TextStyle(
                      color: white,
                      fontSize: textSM,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Text(
                  '. All rights reserved.',
                  style: TextStyle(
                    color: textMuted,
                    fontSize: textSM,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and Name
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: primaryGradient,
                borderRadius: BorderRadius.circular(radiusLG),
                boxShadow: neonGlow,
              ),
              child: const Center(
                child: Text(
                  'E',
                  style: TextStyle(
                    fontSize: text2XL,
                    fontWeight: FontWeight.w900,
                    color: white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: spacing16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => primaryGradient.createShader(bounds),
                  child: const Text(
                    'ETHER',
                    style: TextStyle(
                      fontSize: text2XL,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w900,
                      color: white,
                    ),
                  ),
                ),
                const Text(
                  'Flutter & Rust Developer',
                  style: TextStyle(
                    fontSize: textSM,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: spacing16),
        // Tagline
        const Text(
          'Building beautiful mobile experiences and\nsystem-level software with passion and precision.',
          style: TextStyle(
            fontSize: textSM,
            color: textMuted,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class FooterAllSocialsLinks extends StatelessWidget {
  const FooterAllSocialsLinks({
    super.key,
    this.isInDrawer = false,
  });

  final bool isInDrawer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isInDrawer) ...[
          const Text(
            'Connect With Me',
            style: TextStyle(
              fontSize: textLG,
              color: textPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: spacing16),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SocialLink(
              imgPath: 'assets/svgs/github.svg',
              link: 'https://github.com/Nahianether/',
              tooltip: 'GitHub - @Nahianether',
              isInDrawer: isInDrawer,
              color: const Color(0xFF333333),
            ),
            const SizedBox(width: spacing16),
            SocialLink(
              imgPath: 'assets/svgs/linkedin.svg',
              link: 'https://www.linkedin.com/in/nahinxp21/',
              tooltip: 'LinkedIn - @nahinxp21',
              isInDrawer: isInDrawer,
              color: const Color(0xFF0077B5),
            ),
            const SizedBox(width: spacing16),
            SocialLink(
              imgPath: 'assets/svgs/gmail.svg',
              link: 'mailto:nahianether3@gmail.com',
              tooltip: 'Email - nahianether3@gmail.com',
              isInDrawer: isInDrawer,
              color: const Color(0xFFEA4335),
            ),
          ],
        ),
      ],
    );
  }
}

class SocialLink extends ConsumerWidget {
  const SocialLink({
    super.key,
    required this.imgPath,
    required this.link,
    this.tooltip = 'Open in browser',
    this.isInDrawer = false,
    this.color = primaryColor,
  });

  final String imgPath;
  final String link;
  final String? tooltip;
  final bool isInDrawer;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linkId = '$imgPath-$link'; // Create unique ID for this social link
    final isHovered = ref.watch(socialLinkHoverProvider(linkId));
    final actions = UIActions(ref);
    
    return MouseRegion(
      onEnter: (_) => actions.setSocialLinkHover(linkId, true),
      onExit: (_) => actions.setSocialLinkHover(linkId, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(spacing12),
        decoration: BoxDecoration(
          gradient: isHovered
              ? LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.2),
                    color.withValues(alpha: 0.1),
                  ],
                )
              : isInDrawer
                  ? glassGradient
                  : const LinearGradient(
                      colors: [
                        cardColor,
                        surfaceColor,
                      ],
                    ),
          borderRadius: BorderRadius.circular(radiusLG),
          border: Border.all(
            color: isHovered
                ? color.withValues(alpha: 0.5)
                : isInDrawer
                    ? primaryColor.withValues(alpha: 0.3)
                    : borderColor,
            width: 1,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : shadowSM,
        ),
        child: InkWell(
          onTap: () async {
            if (isInDrawer) Navigator.pop(context);
            if (!await launchUrl(Uri.parse(link))) {
              throw 'Could not launch $link';
            }
          },
          borderRadius: BorderRadius.circular(radiusLG),
          child: Tooltip(
            message: tooltip,
            child: SvgPicture.asset(
              imgPath,
              height: 24.0,
              width: 24.0,
              colorFilter: ColorFilter.mode(
                isHovered
                    ? color
                    : isInDrawer
                        ? primaryColor
                        : textSecondary,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (BuildContext context) => Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(radiusXS),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
