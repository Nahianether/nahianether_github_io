import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../constants/size_config/responsive.dart';
import '../../providers/github_providers.dart';
import 'api/github_api.dart';
import 'models/git_repo.dart';

class RecentWorks extends ConsumerWidget {
  const RecentWorks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = GitHubActions(ref);
    return _buildContent(context, ref, actions);
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, GitHubActions actions) {
    // Watch Riverpod providers
    final statsAsync = ref.watch(githubStatsProvider);
    final selectedYear = ref.watch(selectedYearProvider);
    final currentPage = ref.watch(currentPageProvider);
    final paginatedRepos = ref.watch(paginatedRepositoriesProvider);
    final totalPages = ref.watch(totalPagesProvider);
    final sortedRepos = ref.watch(sortedRepositoriesProvider);
    final isStatsLoading = ref.watch(isStatsLoadingProvider);
    final isReposLoading = ref.watch(isRepositoriesLoadingProvider);

    return _buildMainWidget(
      context,
      ref,
      actions,
      statsAsync,
      selectedYear,
      currentPage,
      paginatedRepos,
      totalPages,
      sortedRepos,
      isStatsLoading,
      isReposLoading,
    );
  }

  Widget _buildMainWidget(
    BuildContext context,
    WidgetRef ref,
    GitHubActions actions,
    AsyncValue<GitHubStats> statsAsync,
    int selectedYear,
    int currentPage,
    List<GitRepoModel> paginatedRepos,
    int totalPages,
    List<GitRepoModel> sortedRepos,
    bool isStatsLoading,
    bool isReposLoading,
  ) {
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
                      'My Portfolio',
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
                    'Showcasing my professional work and personal projects',
                    style: TextStyle(
                      fontSize: textLG,
                      color: textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Office Projects Section
            Container(
              margin: const EdgeInsets.only(bottom: spacing64),
              child: Column(
                children: [
                  // Office Projects Header
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
                          '🏢',
                          style: TextStyle(fontSize: textXL),
                        ),
                      ),
                      const SizedBox(width: spacing16),
                      const Text(
                        'Professional Projects',
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
                  // Office Projects Grid
                  Wrap(
                    spacing: spacing16,
                    runSpacing: spacing16,
                    children: List.generate(
                      officeProjects.length,
                      (index) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: spacing20,
                          vertical: spacing12,
                        ),
                        decoration: BoxDecoration(
                          gradient: cardGradient,
                          borderRadius: BorderRadius.circular(radiusLG),
                          boxShadow: shadowSM,
                          border: Border.all(
                            color: secondaryColor.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: secondaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: secondaryColor.withValues(alpha: 0.5),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: spacing12),
                            Text(
                              officeProjects[index],
                              style: const TextStyle(
                                fontSize: textSM,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // GitHub Profile Highlight Section
            Container(
              margin: const EdgeInsets.only(bottom: spacing64),
              child: statsAsync.when(
                data: (stats) => _buildGitHubStats(context, ref, actions, stats, selectedYear),
                loading: () => _buildGitHubStatsLoading(),
                error: (error, stack) => _buildErrorWidget('Failed to load GitHub stats'),
              ),
            ),

            // GitHub Projects Section
            Column(
              children: [
                // GitHub Projects Header
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
                        '🚀',
                        style: TextStyle(fontSize: textXL),
                      ),
                    ),
                    const SizedBox(width: spacing16),
                    const Text(
                      'Open Source Projects',
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
                // GitHub Projects Content with Pagination
                _buildProjectsSection(
                  context,
                  ref,
                  actions,
                  paginatedRepos,
                  totalPages,
                  sortedRepos,
                  currentPage,
                  isReposLoading,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(spacing32),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(radiusXXL),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: textSecondary,
          fontSize: textBase,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildGitHubStatsLoading() {
    return Container(
      padding: const EdgeInsets.all(spacing32),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(radiusXXL),
        boxShadow: shadowMD,
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: primaryColor),
            SizedBox(height: spacing16),
            Text(
              'Loading GitHub stats...',
              style: TextStyle(
                color: textSecondary,
                fontSize: textBase,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsSection(
    BuildContext context,
    WidgetRef ref,
    GitHubActions actions,
    List<GitRepoModel> paginatedRepos,
    int totalPages,
    List<GitRepoModel> sortedRepos,
    int currentPage,
    bool isLoading,
  ) {
    if (isLoading) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(radiusXL),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: primaryColor),
              SizedBox(height: spacing16),
              Text(
                'Loading projects...',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: textBase,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (sortedRepos.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(spacing32),
        decoration: BoxDecoration(
          gradient: cardGradient,
          borderRadius: BorderRadius.circular(radiusXL),
        ),
        child: const Text(
          'No repositories found',
          style: TextStyle(
            color: textSecondary,
            fontSize: textBase,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        // Project Grid with smooth transitions
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: GridView.builder(
            key: ValueKey(currentPage),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 3 : 1,
              childAspectRatio: Responsive.isDesktop(context) ? 1.2 : 0.8,
              crossAxisSpacing: spacing24,
              mainAxisSpacing: spacing24,
            ),
            itemCount: paginatedRepos.length,
            itemBuilder: (context, index) {
              final globalIndex = (currentPage - 1) * ref.read(projectsPerPageProvider) + index;
              final repo = paginatedRepos[index];
              return _buildModernProjectCard(repo, (sortedRepos.length - globalIndex) as int);
            },
          ),
        ),
        
        // Pagination
        if (totalPages > 1) ...[
          const SizedBox(height: spacing48),
          _buildPagination(context, ref, actions, totalPages, sortedRepos.length, currentPage),
        ],
      ],
    );
  }

  Widget _buildGitHubStats(BuildContext context, WidgetRef ref, GitHubActions actions, GitHubStats stats, int selectedYear) {
    return Container(
      padding: const EdgeInsets.all(spacing32),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(radiusXXL),
        boxShadow: shadowXL,
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // GitHub Profile Header
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
                  '⭐',
                  style: TextStyle(fontSize: textXL),
                ),
              ),
              const SizedBox(width: spacing16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GitHub Profile Highlights',
                      style: TextStyle(
                        fontSize: text2XL,
                        color: textPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'My open source contributions and achievements',
                      style: TextStyle(
                        fontSize: textSM,
                        color: textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  if (!await launchUrl(Uri.parse('https://github.com/Nahianether'))) {
                    throw 'Could not launch GitHub profile';
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: spacing20,
                    vertical: spacing12,
                  ),
                  decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.circular(radiusLG),
                    boxShadow: neonGlow,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.open_in_new, color: white, size: 16),
                      SizedBox(width: spacing8),
                      Text(
                        'View Profile',
                        style: TextStyle(
                          color: white,
                          fontSize: textSM,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: spacing32),
          
          // GitHub Contributions Highlight
          Container(
            margin: const EdgeInsets.only(bottom: spacing32),
            padding: const EdgeInsets.all(spacing24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  secondaryColor.withValues(alpha: 0.1),
                  primaryColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(radiusXL),
              border: Border.all(
                color: secondaryColor.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(spacing8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [secondaryColor, secondaryColor.withValues(alpha: 0.8)],
                        ),
                        borderRadius: BorderRadius.circular(radiusSM),
                        boxShadow: greenGlow,
                      ),
                      child: const Icon(Icons.analytics_outlined, color: white, size: 20),
                    ),
                    const SizedBox(width: spacing12),
                    const Text(
                      'GitHub Activity',
                      style: TextStyle(
                        fontSize: textXL,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: spacing20),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [secondaryColor, primaryColor],
                  ).createShader(bounds),
                  child: Text(
                    '${stats.yearlyContributions[selectedYear]?.totalContributions ?? 0} contributions in $selectedYear',
                    style: const TextStyle(
                      fontSize: text2XL,
                      fontWeight: FontWeight.w900,
                      color: white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: spacing16),
                // Simple Contribution Text Display
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.3, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: _buildSimpleContributionDisplay(context, ref, actions, stats.yearlyContributions, selectedYear, key: ValueKey(selectedYear)),
                ),
              ],
            ),
          ),
          
          // Stats Grid
          if (Responsive.isDesktop(context))
            Row(
              children: [
                Expanded(child: _buildStatCard('Public Repos', '${stats.publicRepos}', '📁', primaryColor)),
                const SizedBox(width: spacing16),
                Expanded(child: _buildStatCard('Total Stars', '${stats.totalStars}', '⭐', secondaryColor)),
                const SizedBox(width: spacing16),
                Expanded(child: _buildStatCard('Total Forks', '${stats.totalForks}', '🍴', accentColor)),
                const SizedBox(width: spacing16),
                Expanded(child: _buildStatCard('Followers', '${stats.followers}', '👥', purpleAccent)),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Repos', '${stats.publicRepos}', '📁', primaryColor)),
                    const SizedBox(width: spacing16),
                    Expanded(child: _buildStatCard('Stars', '${stats.totalStars}', '⭐', secondaryColor)),
                  ],
                ),
                const SizedBox(height: spacing16),
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Forks', '${stats.totalForks}', '🍴', accentColor)),
                    const SizedBox(width: spacing16),
                    Expanded(child: _buildStatCard('Followers', '${stats.followers}', '👥', purpleAccent)),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSimpleContributionDisplay(
    BuildContext context,
    WidgetRef ref,
    GitHubActions actions,
    Map<int, dynamic> yearlyData,
    int selectedYear,
    {Key? key}
  ) {
    final availableYears = yearlyData.keys.toList()..sort((a, b) => b.compareTo(a));
    final currentYearData = yearlyData[selectedYear];
    
    return Container(
      key: key,
      padding: const EdgeInsets.all(spacing24),
      decoration: BoxDecoration(
        color: bgColor.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(radiusXL),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Year Navigation
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: availableYears.map((year) {
                final isSelected = year == selectedYear;
                return Padding(
                  padding: const EdgeInsets.only(right: spacing8),
                  child: InkWell(
                    onTap: () => actions.selectYear(year),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacing16,
                        vertical: spacing8,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected ? primaryGradient : null,
                        color: isSelected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSM),
                        border: Border.all(
                          color: isSelected ? primaryColor : borderColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontSize: textSM,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? white : textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: spacing24),
          
          // Contribution Stats for Selected Year
          if (currentYearData != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(
                  '${currentYearData.totalContributions}',
                  'Total Contributions',
                  secondaryColor,
                ),
                _buildStatItem(
                  '${currentYearData.longestStreak}',
                  'Longest Streak',
                  primaryColor,
                ),
                _buildStatItem(
                  '${currentYearData.averagePerDay}',
                  'Daily Average',
                  accentColor,
                ),
              ],
            ),
          ] else ...[
            Text(
              'No contribution data available for $selectedYear',
              style: const TextStyle(
                color: textMuted,
                fontSize: textSM,
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [color, color.withValues(alpha: 0.7)],
          ).createShader(bounds),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: text3XL,
              fontWeight: FontWeight.w900,
              color: white,
              letterSpacing: -1.0,
            ),
          ),
        ),
        const SizedBox(height: spacing4),
        Text(
          label,
          style: const TextStyle(
            fontSize: textXS,
            color: textSecondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget _buildStatCard(String label, String value, String emoji, Color color) {
    return Container(
      padding: const EdgeInsets.all(spacing20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(radiusLG),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: text2XL),
          ),
          const SizedBox(height: spacing8),
          Text(
            value,
            style: TextStyle(
              fontSize: text2XL,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: spacing4),
          Text(
            label,
            style: const TextStyle(
              fontSize: textSM,
              color: textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, WidgetRef ref, GitHubActions actions, int totalPages, int totalRepos, int currentPage) {
    return Container(
      padding: const EdgeInsets.all(spacing24),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(radiusXL),
        boxShadow: shadowMD,
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Showing ${(currentPage - 1) * ref.read(projectsPerPageProvider) + 1} - ${currentPage * ref.read(projectsPerPageProvider) > totalRepos ? totalRepos : currentPage * ref.read(projectsPerPageProvider)} of $totalRepos projects',
            style: const TextStyle(
              color: textSecondary,
              fontSize: textSM,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: spacing20),
          Wrap(
            spacing: spacing8,
            alignment: WrapAlignment.center,
            children: [
              // Previous button
              InkWell(
                onTap: currentPage > 1 ? actions.previousPage : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: spacing16,
                    vertical: spacing8,
                  ),
                  decoration: BoxDecoration(
                    gradient: currentPage > 1 ? primaryGradient : null,
                    color: currentPage > 1 ? null : textMuted.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSM),
                    border: Border.all(
                      color: currentPage > 1 ? primaryColor : textMuted,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Previous',
                    style: TextStyle(
                      color: currentPage > 1 ? white : textMuted,
                      fontSize: textSM,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              // Page numbers
              ...List.generate(totalPages, (index) {
                final pageNum = index + 1;
                final isActive = pageNum == currentPage;
                
                return InkWell(
                  onTap: () => actions.goToPage(pageNum),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: isActive ? primaryGradient : null,
                      color: isActive ? null : Colors.transparent,
                      borderRadius: BorderRadius.circular(radiusSM),
                      border: Border.all(
                        color: isActive ? primaryColor : borderColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$pageNum',
                        style: TextStyle(
                          color: isActive ? white : textSecondary,
                          fontSize: textSM,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              
              // Next button
              InkWell(
                onTap: currentPage < totalPages ? actions.nextPage : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: spacing16,
                    vertical: spacing8,
                  ),
                  decoration: BoxDecoration(
                    gradient: currentPage < totalPages ? primaryGradient : null,
                    color: currentPage < totalPages ? null : textMuted.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(radiusSM),
                    border: Border.all(
                      color: currentPage < totalPages ? primaryColor : textMuted,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: currentPage < totalPages ? white : textMuted,
                      fontSize: textSM,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernProjectCard(GitRepoModel repo, int position) {
    return Container(
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(radiusXL),
        boxShadow: shadowLG,
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () async {
          if (!await launchUrl(Uri.parse(repo.htmlUrl!))) {
            throw 'Could not launch ${repo.htmlUrl}';
          }
        },
        borderRadius: BorderRadius.circular(radiusXL),
        child: Padding(
          padding: const EdgeInsets.all(spacing24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with position and link icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: primaryGradient,
                      borderRadius: BorderRadius.circular(radiusLG),
                      boxShadow: neonGlow,
                    ),
                    child: Center(
                      child: Text(
                        '#$position',
                        style: const TextStyle(
                          color: white,
                          fontSize: textSM,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (repo.stargazersCount != null && repo.stargazersCount! > 0) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: spacing8,
                            vertical: spacing4,
                          ),
                          decoration: BoxDecoration(
                            color: secondaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXS),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star, color: secondaryColor, size: 12),
                              const SizedBox(width: spacing4),
                              Text(
                                '${repo.stargazersCount}',
                                style: const TextStyle(
                                  color: secondaryColor,
                                  fontSize: textXS,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: spacing8),
                      ],
                      Container(
                        padding: const EdgeInsets.all(spacing8),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(radiusSM),
                        ),
                        child: const Icon(
                          Icons.open_in_new,
                          color: primaryColor,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: spacing20),
              
              // Project Name
              Text(
                repo.name!,
                style: const TextStyle(
                  fontSize: textLG,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                  letterSpacing: 0.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: spacing12),
              
              // Description
              Expanded(
                child: Text(
                  repo.description ?? 'No description available',
                  style: const TextStyle(
                    fontSize: textSM,
                    color: textSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // Language and Topics
              Row(
                children: [
                  if (repo.language != null && repo.language!.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacing8,
                        vertical: spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(radiusXS),
                        border: Border.all(
                          color: primaryColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        repo.language!,
                        style: const TextStyle(
                          fontSize: textXS,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: spacing8),
                  ],
                  if (repo.topics!.isNotEmpty)
                    Expanded(
                      child: Wrap(
                        spacing: spacing6,
                        runSpacing: spacing6,
                        children: repo.topics!.take(2).map((topic) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: spacing6,
                              vertical: spacing2,
                            ),
                            decoration: BoxDecoration(
                              color: secondaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(radiusXS),
                            ),
                            child: Text(
                              '#$topic',
                              style: const TextStyle(
                                fontSize: textXS,
                                color: secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
