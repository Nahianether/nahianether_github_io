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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
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
            List<GitRepoModel> gitRepoModelList = snapshot.data!.gitRepoModelList;
            gitRepoModelList.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
            gitRepoModelList = gitRepoModelList.reversed.toList();
            final length = gitRepoModelList.length;
            return SingleChildScrollView(
              child: Wrap(
                spacing: defaultPadding,
                runSpacing: defaultPadding * 2,
                children: List.generate(
                  length,
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
    );
  }
}
