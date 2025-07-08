class Experience {
  final List<Designation> designations;
  final String companyName;
  final String link;
  final String imgPath;
  final String location;

  Experience({
    required this.designations,
    required this.companyName,
    required this.link,
    required this.imgPath,
    required this.location,
  });
}

class Designation {
  final String title;
  final DateTime startDate;
  final DateTime? endDate;

  Designation({
    required this.title,
    required this.startDate,
    this.endDate,
  });
}

List<Experience> experiences = [
  Experience(
    designations: [
      Designation(
        title: 'Software Engineer',
        startDate: DateTime.parse('2024-10-15 00:00:00.000'),
      ),
    ],
    companyName: 'AKIJ iBOS Limited',
    link: 'https://ibos.io/',
    imgPath: 'assets/experiences/akij-ibos.png',
    location: 'Dhaka, Bangladesh',
  ),
  Experience(
    designations: [
      Designation(
        title: 'Senior Developer',
        startDate: DateTime.parse('2023-09-01 00:00:00.000'),
        endDate: DateTime.parse('2024-10-01 00:00:00.000'),
      ),
      Designation(
        title: 'Developer',
        startDate: DateTime.parse('2022-09-01 00:00:00.000'),
        endDate: DateTime.parse('2023-09-01 00:00:00.000'),
      ),
      Designation(
        title: 'Junior Developer',
        startDate: DateTime.parse('2021-07-01 00:00:00.000'),
        endDate: DateTime.parse('2022-09-01 00:00:00.000'),
      ),
    ],
    companyName: 'Algorithm Generation Ltd',
    link: 'https://algorithmgeneration.com/',
    imgPath: 'assets/experiences/algorithm-generation.png',
    location: 'Dhaka, Bangladesh',
  ),
  Experience(
    designations: [
      Designation(
        title: 'Junior Flutter Developer',
        startDate: DateTime.parse('2020-12-01 00:00:00.000'),
        endDate: DateTime.parse('2021-05-01 00:00:00.000'),
      ),
    ],
    companyName: 'App Coder XYZ',
    link: 'https://appcoder.xyz/',
    imgPath: 'assets/experiences/app-coder-xyz.png',
    location: 'Dhaka, Bangladesh',
  ),
  Experience(
    designations: [
      Designation(
        title: 'Junior Flutter Developer',
        startDate: DateTime.parse('2020-03-01 00:00:00.000'),
        endDate: DateTime.parse('2020-12-01 00:00:00.000'),
      ),
    ],
    companyName: 'Dhaka Boss Pvt. Limited',
    link: 'https://www.facebook.com/dhakabosss/',
    imgPath: 'assets/experiences/Dhaka-boss.png',
    location: 'Dhaka, Bangladesh',
  ),
  Experience(
    designations: [
      Designation(
        title: 'Guest Employee',
        startDate: DateTime.parse('2018-10-01 00:00:00.000'),
        endDate: DateTime.parse('2019-06-01 00:00:00.000'),
      ),
    ],
    companyName: 'PiLabs Bd. Limited',
    link: 'https://www.pilabsbd.com/',
    imgPath: 'assets/experiences/pilabs.png',
    location: 'Dhaka, Bangladesh',
  ),
];
