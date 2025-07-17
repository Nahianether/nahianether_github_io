import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import '../../providers/ui_providers.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
          vertical: spacing80,
        ),
        child: Column(
          children: [
            // Modern Section Header
            Container(
              margin: const EdgeInsets.only(bottom: spacing64),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => neonGradient.createShader(bounds),
                    child: const Text(
                      'Get In Touch',
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
                    'Ready to build amazing Flutter apps or robust Rust systems? Let\'s collaborate!',
                    style: TextStyle(
                      fontSize: textLG,
                      color: textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const ContactBox(),
          ],
        ),
      ),
    );
  }
}

class ContactBox extends StatelessWidget {
  const ContactBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Modern Contact Cards Section
        Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Contact Methods Grid
              if (Responsive.isDesktop(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildModernContactCard(
                      'Telegram',
                      '@nahinxp21',
                      'assets/images/telegram.png',
                      const Color(0xFF24A1DE),
                      () async {
                        if (!await launchUrl(Uri.parse('https://t.me/nahinxp21'))) {
                          throw 'Could not launch';
                        }
                      },
                    ),
                    const SizedBox(width: spacing48),
                    _buildModernContactCard(
                      'WhatsApp',
                      '+880 1687722962',
                      'assets/images/whatsapp.png',
                      const Color(0xFF25D366),
                      () async {
                        if (!await launchUrl(Uri.parse('https://wa.me/8801687722962'))) {
                          throw 'Could not launch';
                        }
                      },
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildModernContactCard(
                      'Telegram',
                      '@nahinxp21',
                      'assets/images/telegram.png',
                      const Color(0xFF24A1DE),
                      () async {
                        if (!await launchUrl(Uri.parse('https://t.me/nahinxp21'))) {
                          throw 'Could not launch';
                        }
                      },
                    ),
                    const SizedBox(height: spacing32),
                    _buildModernContactCard(
                      'WhatsApp',
                      '+880 1687722962',
                      'assets/images/whatsapp.png',
                      const Color(0xFF25D366),
                      () async {
                        if (!await launchUrl(Uri.parse('https://wa.me/8801687722962'))) {
                          throw 'Could not launch';
                        }
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: spacing80),
        // Modern Contact Form
        Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: EdgeInsets.all(Responsive.isDesktop(context) ? spacing48 : spacing24),
          decoration: BoxDecoration(
            gradient: cardGradient,
            borderRadius: BorderRadius.circular(radiusXXL),
            boxShadow: shadowXL,
            border: Border.all(
              color: primaryColor.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: const ContactForm(),
        ),
      ],
    );
  }

  Widget _buildModernContactCard(
    String title,
    String subtitle,
    String iconPath,
    Color accentColor,
    VoidCallback onTap,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = Responsive.isDesktop(context);
        
        return Container(
          width: isDesktop ? 320 : double.infinity,
          padding: EdgeInsets.all(isDesktop ? spacing32 : spacing24),
          decoration: BoxDecoration(
            gradient: cardGradient,
            borderRadius: BorderRadius.circular(radiusXXL),
            boxShadow: shadowLG,
            border: Border.all(
              color: accentColor.withValues(alpha: 0.2),
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(radiusXXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Container with Glow Effect
                Container(
                  width: isDesktop ? 80 : 64,
                  height: isDesktop ? 80 : 64,
                  padding: EdgeInsets.all(isDesktop ? spacing20 : spacing16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.2),
                        accentColor.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(radiusXL),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: isDesktop ? spacing24 : spacing16),
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isDesktop ? text2XL : textXL,
                    fontWeight: FontWeight.w700,
                    color: textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: isDesktop ? spacing8 : spacing6),
                // Subtitle
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: isDesktop ? textBase : textSM,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isDesktop ? spacing24 : spacing16),
                // Connect Button
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? spacing24 : spacing20,
                    vertical: isDesktop ? spacing12 : spacing8,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accentColor, accentColor.withValues(alpha: 0.8)],
                    ),
                    borderRadius: BorderRadius.circular(radiusLG),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    'Connect Now',
                    style: TextStyle(
                      fontSize: isDesktop ? textBase : textSM,
                      fontWeight: FontWeight.w600,
                      color: white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContactForm extends ConsumerWidget {
  const ContactForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(contactFormKeyProvider);
    final nameController = ref.watch(nameControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final projectTypeController = ref.watch(projectTypeControllerProvider);
    final projectBudgetController = ref.watch(projectBudgetControllerProvider);
    final descriptionController = ref.watch(descriptionControllerProvider);
    
    return Column(
      children: [
        // Form Header
        const Text(
          'Send Me a Message',
          style: TextStyle(
            fontSize: text2XL,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: spacing8),
        const Text(
          'Let\'s discuss your Flutter or Rust project and bring your ideas to life',
          style: TextStyle(
            fontSize: textBase,
            color: textSecondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: spacing40),
        // Form Fields
        Form(
          key: formKey,
          child: Column(
            children: [
              // Name and Email Row
              if (Responsive.isDesktop(context))
                Row(
                  children: [
                    Expanded(
                      child: _buildModernTextField(
                        controller: nameController,
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: spacing24),
                    Expanded(
                      child: _buildModernTextField(
                        controller: emailController,
                        label: 'Email Address',
                        hint: 'Enter your email address',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          } else if (!emailValidatorRegExp.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildModernTextField(
                      controller: nameController,
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: spacing20),
                    _buildModernTextField(
                      controller: emailController,
                      label: 'Email Address',
                      hint: 'Enter your email address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!emailValidatorRegExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              const SizedBox(height: spacing20),
              // Project Type and Budget Row
              if (Responsive.isDesktop(context))
                Row(
                  children: [
                    Expanded(
                      child: _buildModernTextField(
                        controller: projectTypeController,
                        label: 'Project Type',
                        hint: 'Flutter App, Rust System, Web App, etc.',
                        icon: Icons.work_outline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your project type';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: spacing24),
                    Expanded(
                      child: _buildModernTextField(
                        controller: projectBudgetController,
                        label: 'Project Budget',
                        hint: '\$5K - \$10K, \$10K+, etc.',
                        icon: Icons.attach_money_outlined,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your project budget';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildModernTextField(
                      controller: projectTypeController,
                      label: 'Project Type',
                      hint: 'Mobile App, Web App, etc.',
                      icon: Icons.work_outline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your project type';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: spacing20),
                    _buildModernTextField(
                      controller: projectBudgetController,
                      label: 'Project Budget',
                      hint: '\$5K - \$10K, \$10K+, etc.',
                      icon: Icons.attach_money_outlined,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your project budget';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              const SizedBox(height: spacing20),
              // Description Field
              _buildModernTextField(
                controller: descriptionController,
                label: 'Project Description',
                hint: 'Tell me about your Flutter or Rust project requirements...',
                icon: Icons.description_outlined,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your project description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: spacing40),
              // Submit Button
              Container(
                decoration: BoxDecoration(
                  gradient: primaryGradient,
                  borderRadius: BorderRadius.circular(radiusLG),
                  boxShadow: shadowLG,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String subject = '${nameController.text} - ${projectTypeController.text} - ${projectBudgetController.text}';
                      String body =
                          '${nameController.text}\n${projectTypeController.text}\n${projectBudgetController.text}\n${descriptionController.text}';
                      String uri =
                          'mailto:nahianether3@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

                      if (!await launchUrl(Uri.parse(uri))) {
                        debugPrint('Could not launch email client');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: spacing48,
                      vertical: spacing20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(radiusLG),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.send_outlined, color: white, size: 20),
                      SizedBox(width: spacing12),
                      Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: textLG,
                          fontWeight: FontWeight.w600,
                          color: white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: glassGradient,
        borderRadius: BorderRadius.circular(radiusLG),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        style: const TextStyle(
          color: textPrimary,
          fontSize: textBase,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: primaryColor),
          labelStyle: const TextStyle(
            color: textSecondary,
            fontSize: textSM,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: const TextStyle(
            color: textMuted,
            fontSize: textSM,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            borderSide: BorderSide(
              color: primaryColor.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            borderSide: const BorderSide(
              color: accentColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusLG),
            borderSide: const BorderSide(
              color: accentColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: spacing20,
            vertical: spacing16,
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
