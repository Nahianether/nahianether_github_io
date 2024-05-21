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
        title: 'Senior Flutter Developer',
        startDate: DateTime.parse('2023-09-01 00:00:00.000'),
      ),
      Designation(
        title: 'Flutter Developer',
        startDate: DateTime.parse('2022-09-01 00:00:00.000'),
        endDate: DateTime.parse('2023-09-01 00:00:00.000'),
      ),
      Designation(
        title: 'Junior Flutter Developer',
        startDate: DateTime.parse('2021-06-01 00:00:00.000'),
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
];
