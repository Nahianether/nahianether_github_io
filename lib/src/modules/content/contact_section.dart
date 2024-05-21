import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/default_button.dart';
import '../../components/section_title.dart';
import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import 'social_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context) ? 0 : defaultPadding),
      child: const Column(
        children: [
          SizedBox(height: defaultPadding * 2),
          SectionTitle(
            title: 'Contact Me',
            subTitle: 'For Project inquiry and information',
            color: Color(0xFF07E24A),
          ),
          ContactBox(),
          SizedBox(height: defaultPadding * 2),
        ],
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
    return Container(
      constraints: const BoxConstraints(maxWidth: 1110),
      margin: const EdgeInsets.only(top: defaultPadding * 2),
      padding: const EdgeInsets.all(defaultPadding * 3),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          Wrap(
            spacing: defaultPadding,
            runSpacing: defaultPadding * 2,
            children: [
              SocalCard(
                color: const Color(0xFFD9FFFC),
                iconSrc: 'assets/images/telegram.png',
                name: 'Intishar-Ul Islam',
                onTap: () async {
                  if (!await launchUrl(Uri.parse('https://t.me/nahinxp21'))) {
                    throw 'Could not launch';
                  }
                },
              ),
              SocalCard(
                color: const Color(0xFFE4FFC7),
                iconSrc: 'assets/images/whatsapp.png',
                name: 'Intishar-Ul Islam',
                onTap: () async {
                  if (!await launchUrl(Uri.parse('https://wa.me/8801687722962'))) {
                    throw 'Could not launch';
                  }
                },
              ),
              SocalCard(
                color: const Color(0xFFE8F0F9),
                iconSrc: 'assets/images/messanger.png',
                name: 'Intishar-Ul Islam',
                onTap: () async {
                  if (!await launchUrl(Uri.parse('https://m.me/nahinxp21'))) {
                    throw 'Could not launch';
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: defaultPadding * 2),
          const ContactForm(),
        ],
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({
    super.key,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController projectTypeController = TextEditingController();
  TextEditingController projectBudgetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? name;
  String? email;
  String? projectType;
  String? projectBudget;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        spacing: defaultPadding * 2.5,
        runSpacing: defaultPadding * 1.5,
        children: [
          SizedBox(
            width: 470,
            child: TextFormField(
              controller: nameController,
              onChanged: (value) => setState(() => name = value),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                hintText: 'Enter Your Name',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            width: 470,
            child: TextFormField(
              controller: emailController,
              onChanged: (value) => setState(() => email = value),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email address',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
          SizedBox(
            width: 470,
            child: TextFormField(
              controller: projectTypeController,
              onChanged: (value) => setState(() => projectType = value),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Project Type',
                hintText: 'Select Project Type',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your project type';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            width: 470,
            child: TextFormField(
              controller: projectBudgetController,
              onChanged: (value) => setState(() => projectBudget = value),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Project Budget',
                hintText: 'Select Project Budget',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your project budget';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            child: TextFormField(
              controller: descriptionController,
              onChanged: (value) => setState(() => description = value),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Write some description',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your description';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          Center(
            child: FittedBox(
              child: DefaultButton(
                imageSrc: 'assets/images/contact_icon.png',
                text: 'Contact Me!',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // ios specification
                    String subject = 'Website Project Details';
                    String body =
                        'Name: $name\nProject Type: $projectType\nProject Budget: $projectBudget\nDescription: $description';
                    String uri =
                        'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

                    if (!await launchUrl(Uri.parse(uri))) {
                      throw 'Could not launch';
                    } else {
                      debugPrint('No email client found');
                    }
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
