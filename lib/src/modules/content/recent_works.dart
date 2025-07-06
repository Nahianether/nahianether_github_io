import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import 'api/github_api.dart';
import 'models/git_repo.dart';

class RecentWorks extends StatelessWidget {
  const RecentWorks({
    super.key,
  });

  List<GitRepoModel> _sortRepositories(List<GitRepoModel> repos) {
    final sortedRepos = List<GitRepoModel>.from(repos);
    sortedRepos.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
    return sortedRepos.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            'Office Works',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: defaultPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: defaultPadding,
              runSpacing: defaultPadding,
              children: List.generate(
                officeProjects.length,
                (index) => Chip(
                  label: Text(officeProjects[index]),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: defaultPadding),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Text(
            'Others Works',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: size.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: FutureBuilder<ResultData>(
                future: GithubApi().getAllRepos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Some error occured'));
                  }
                  if (!snapshot.data!.success) {
                    return Center(
                      child: Text(
                        snapshot.data!.message,
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                  if (snapshot.data!.gitRepoModelList.isEmpty) {
                    return const Center(child: Text('No Repo found.'));
                  }
                  final gitRepoModelList = _sortRepositories(snapshot.data!.gitRepoModelList);
                  final length = gitRepoModelList.length;
                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: defaultPadding,
                      runSpacing: defaultPadding * 2,
                      children: List.generate(
                        length > 20 ? 20 : length, // Limit to 20 repos for performance
                        (index) => SizedBox(
                          width: Responsive.isDesktop(context) ? size.width * 0.25 : size.width - defaultPadding,
                          child: Card(
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              onTap: () async {
                                String link = gitRepoModelList[index].htmlUrl!;
          
                                if (!await launchUrl(Uri.parse(link))) {
                                  throw 'Could not launch';
                                }
                              },
                              leading: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(55),
                                  border: Border.all(
                                    color: Colors.grey[800]!,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  '${length - index}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                gitRepoModelList[index].name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    gitRepoModelList[index].description ?? 'No description added',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  gitRepoModelList[index].topics!.isEmpty
                                      ? const SizedBox.shrink()
                                      : Text(
                                          gitRepoModelList[index].topics!.map((e) => '#$e').join('  '),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.blueAccent[400],
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                              trailing: const Icon(Icons.touch_app_outlined),
                              hoverColor: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
