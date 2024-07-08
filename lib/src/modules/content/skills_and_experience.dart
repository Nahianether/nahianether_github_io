import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/animated_progress_indicator.dart';
import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import '../../constants/size_config/size_config.dart';
import 'models/experience.dart';

class SkillsAndExperience extends StatelessWidget {
  const SkillsAndExperience({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding,
          0,
          Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding,
          Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                flex: 3,
                child: Skills(),
              ),
              if (Responsive.isDesktop(context))
                const Expanded(
                  flex: 2,
                  child: Experience(),
                ),
            ],
          ),
          if (!Responsive.isDesktop(context)) const Experience(),
        ],
      ),
    );
  }
}

class Skills extends StatelessWidget {
  const Skills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Responsive.isDesktop(context) ? defaultPadding * 2 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(
              'Skills & Coding',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. Flutter',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          1. State Management',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '                    1. Riverpod',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '                    2. Provider',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '                    3. Bloc',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          2. DB',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '                    1. Isar',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '                    2. Hive',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '                    3. Firebase',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          3. Multi-Threading',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          4. FFi with Rust, and C',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          5. Method Chanel',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          6. Custom Painting',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          7. Workmanager',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          8. API integration',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '          9. Custom Animation',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '2. Dart',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '3. Android',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '4. Rust',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '5. JAVA',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '6. C/C++',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 130,
                        width: 100,
                        child: AnimatedCircularProgressIndicator(
                          percentage: 0.9,
                          label: 'Flutter',
                        ),
                      ),
                      SizedBox(height: Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding),
                      const SizedBox(
                        height: 130,
                        width: 100,
                        child: AnimatedCircularProgressIndicator(
                          percentage: 0.8,
                          label: 'Dart',
                        ),
                      ),
                      SizedBox(height: Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding),
                      const SizedBox(
                        height: 130,
                        width: 100,
                        child: AnimatedCircularProgressIndicator(
                          percentage: 0.6,
                          label: 'Android',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding),
                  Column(
                    children: [
                      const SizedBox(
                        height: 130,
                        width: 100,
                        child: AnimatedCircularProgressIndicator(
                          percentage: 0.4,
                          label: 'Rust',
                        ),
                      ),
                      SizedBox(height: Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding),
                      const SizedBox(
                        height: 130,
                        width: 100,
                        child: AnimatedCircularProgressIndicator(
                          percentage: 0.5,
                          label: 'JAVA',
                        ),
                      ),
                      SizedBox(height: Responsive.isDesktop(context) ? defaultPadding * 2 : defaultPadding),
                      const SizedBox(
                        height: 130,
                        width: 100,
                        child: AnimatedCircularProgressIndicator(
                          percentage: 0.4,
                          label: 'C/C++',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: defaultPadding),
          //   child: Text(
          //     'Coding',
          //     style: TextStyle(
          //       fontSize: 20.0,
          //       color: Colors.black87,
          //       fontWeight: FontWeight.w700,
          //       letterSpacing: 0.8,
          //     ),
          //   ),
          // ),
          // const AnimatedLinearProgressIndicator(
          //   percentage: 0.75,
          //   label: 'Dart',
          // ),
          // const AnimatedLinearProgressIndicator(
          //   percentage: 0.6,
          //   label: 'Python',
          // ),
          // const AnimatedLinearProgressIndicator(
          //   percentage: 0.8,
          //   label: 'Java',
          // ),
          // const AnimatedLinearProgressIndicator(
          //   percentage: 0.65,
          //   label: 'HTML',
          // ),
          // const AnimatedLinearProgressIndicator(
          //   percentage: 0.5,
          //   label: 'CSS',
          // ),
          // const AnimatedLinearProgressIndicator(
          //   percentage: 0.4,
          //   label: 'Bootstrap',
          // ),
        ],
      ),
    );
  }
}

class Experience extends StatelessWidget {
  const Experience({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Responsive.isDesktop(context) ? defaultPadding * 2 : 0, 0,
          Responsive.isDesktop(context) ? defaultPadding * 2 : 0, 0),
      child: Column(
        mainAxisSize: mainMin,
        crossAxisAlignment: crossStart,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(
              'Experience',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const Text(
            'Playing with software development for the last 4 and half years (almost) & trying to update me daily with the new technologies.',
            style: TextStyle(
              fontSize: 11.5,
              color: bodyTextColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: defaultPadding * 0.7),
          Column(
            mainAxisSize: mainMin,
            crossAxisAlignment: crossStart,
            children: List.generate(
              experiences.length,
              (index) => experiences[index].designations.length == 1
                  ? Row(
                      crossAxisAlignment: crossStart,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Image.asset(
                            experiences[index].imgPath,
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        SizedBox(
                          height: 100.0,
                          child: Column(
                            mainAxisSize: mainMin,
                            crossAxisAlignment: crossStart,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 1.0))),
                                child: InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(Uri.parse(experiences[index].link))) {
                                      throw 'Could not launch';
                                    }
                                  },
                                  child: Text(
                                    experiences[index].companyName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3.0),
                              Text(
                                experiences[index].designations.first.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: black,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                "${getFormatedDate(experiences[index].designations.first.startDate)} - ${experiences[index].designations.first.endDate == null ? 'Present' : getFormatedDate(experiences[index].designations.first.endDate!)} • ${diffDate(startDate: experiences[index].designations.first.startDate, endDate: experiences[index].designations.first.endDate ?? DateTime.now())}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: bodyTextColor,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              Text(
                                experiences[index].location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: bodyTextColor,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: mainMin,
                      children: [
                        Row(
                          crossAxisAlignment: crossStart,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Image.asset(
                                experiences[index].imgPath,
                                height: 40.0,
                                width: 40.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              mainAxisSize: mainMin,
                              crossAxisAlignment: crossStart,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 1.0))),
                                  child: InkWell(
                                    onTap: () async {
                                      if (!await launchUrl(Uri.parse(experiences[index].link))) {
                                        throw 'Could not launch';
                                      }
                                    },
                                    child: Text(
                                      experiences[index].companyName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3.0),
                                Text(
                                  diffDate(
                                      startDate: experiences[index].designations.last.startDate,
                                      endDate: experiences[index].designations.first.endDate ?? DateTime.now()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: bodyTextColor,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                Text(
                                  experiences[index].location,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: bodyTextColor,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Column(
                                  crossAxisAlignment: crossStart,
                                  children: List.generate(
                                    experiences[index].designations.length,
                                    (idx) => SizedBox(
                                      height: 60.0,
                                      child: Row(
                                        crossAxisAlignment: crossStart,
                                        children: [
                                          Column(
                                            mainAxisSize: mainMin,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                child: Container(
                                                    height: 8.0,
                                                    width: 8.0,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[600],
                                                        borderRadius: BorderRadius.circular(45.0))),
                                              ),
                                              if (idx != experiences[index].designations.length - 1)
                                                Expanded(
                                                  child: Container(
                                                    width: 1.8,
                                                    height: 20.0,
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                            ],
                                          ),
                                          const SizedBox(width: 15.0),
                                          Column(
                                            crossAxisAlignment: crossStart,
                                            mainAxisSize: mainMin,
                                            children: [
                                              Text(
                                                experiences[index].designations[idx].title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: black,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                              Text(
                                                (experiences[index].designations[idx].endDate != null
                                                    ? '${getFormatedDate(experiences[index].designations[idx].startDate)} - ${getFormatedDate(experiences[index].designations[idx].endDate!)} • ${diffDate(startDate: experiences[index].designations[idx].startDate, endDate: experiences[index].designations[idx].endDate!)}'
                                                    : '${getFormatedDate(experiences[index].designations[idx].startDate)} - Present • ${diffDate(startDate: experiences[index].designations[idx].startDate, endDate: DateTime.now())}'),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 11.5,
                                                  color: bodyTextColor,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
