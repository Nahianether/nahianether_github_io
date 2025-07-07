import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../modules/content/api/github_api.dart';
import '../modules/content/models/git_repo.dart';

// State providers for UI state
final selectedYearProvider = StateProvider<int>((ref) => DateTime.now().year);
final currentPageProvider = StateProvider<int>((ref) => 1);
final projectsPerPageProvider = StateProvider<int>((ref) => 9);

// GitHub API instance provider
final githubApiProvider = Provider<GithubApi>((ref) => GithubApi());

// GitHub repositories provider with caching
final githubRepositoriesProvider = FutureProvider<ResultData>((ref) async {
  final api = ref.read(githubApiProvider);
  return await api.getAllRepos();
});

// GitHub stats provider with caching
final githubStatsProvider = FutureProvider<GitHubStats>((ref) async {
  final api = ref.read(githubApiProvider);
  return await api.getGitHubStats();
});

// Computed provider for sorted repositories
final sortedRepositoriesProvider = Provider<List<GitRepoModel>>((ref) {
  final repositoriesAsync = ref.watch(githubRepositoriesProvider);
  
  return repositoriesAsync.when(
    data: (resultData) {
      if (!resultData.success || resultData.gitRepoModelList.isEmpty) {
        return [];
      }
      
      final sortedRepos = List<GitRepoModel>.from(resultData.gitRepoModelList);
      sortedRepos.sort((a, b) => a.updatedAt!.compareTo(b.updatedAt!));
      return sortedRepos.reversed.toList();
    },
    loading: () => [],
    error: (error, stack) => [],
  );
});

// Computed provider for paginated repositories
final paginatedRepositoriesProvider = Provider<List<GitRepoModel>>((ref) {
  final sortedRepos = ref.watch(sortedRepositoriesProvider);
  final currentPage = ref.watch(currentPageProvider);
  final projectsPerPage = ref.watch(projectsPerPageProvider);
  
  final startIndex = (currentPage - 1) * projectsPerPage;
  final endIndex = startIndex + projectsPerPage;
  
  if (startIndex >= sortedRepos.length) return [];
  
  return sortedRepos.sublist(
    startIndex,
    endIndex > sortedRepos.length ? sortedRepos.length : endIndex,
  );
});

// Computed provider for total pages
final totalPagesProvider = Provider<int>((ref) {
  final sortedRepos = ref.watch(sortedRepositoriesProvider);
  final projectsPerPage = ref.watch(projectsPerPageProvider);
  
  if (sortedRepos.isEmpty) return 1;
  return (sortedRepos.length / projectsPerPage).ceil();
});

// Computed provider for current year contributions
final currentYearContributionsProvider = Provider<dynamic>((ref) {
  final githubStatsAsync = ref.watch(githubStatsProvider);
  final selectedYear = ref.watch(selectedYearProvider);
  
  return githubStatsAsync.when(
    data: (stats) => stats.yearlyContributions[selectedYear],
    loading: () => null,
    error: (error, stack) => null,
  );
});

// Loading state providers
final isRepositoriesLoadingProvider = Provider<bool>((ref) {
  final repositoriesAsync = ref.watch(githubRepositoriesProvider);
  return repositoriesAsync.isLoading;
});

final isStatsLoadingProvider = Provider<bool>((ref) {
  final statsAsync = ref.watch(githubStatsProvider);
  return statsAsync.isLoading;
});

// Error state providers
final repositoriesErrorProvider = Provider<String?>((ref) {
  final repositoriesAsync = ref.watch(githubRepositoriesProvider);
  return repositoriesAsync.hasError ? repositoriesAsync.error.toString() : null;
});

final statsErrorProvider = Provider<String?>((ref) {
  final statsAsync = ref.watch(githubStatsProvider);
  return statsAsync.hasError ? statsAsync.error.toString() : null;
});

// Actions for state mutations
class GitHubActions {
  GitHubActions(this.ref);
  
  final WidgetRef ref;
  
  void selectYear(int year) {
    ref.read(selectedYearProvider.notifier).state = year;
  }
  
  void goToPage(int page) {
    ref.read(currentPageProvider.notifier).state = page;
  }
  
  void nextPage() {
    final currentPage = ref.read(currentPageProvider);
    final totalPages = ref.read(totalPagesProvider);
    
    if (currentPage < totalPages) {
      ref.read(currentPageProvider.notifier).state = currentPage + 1;
    }
  }
  
  void previousPage() {
    final currentPage = ref.read(currentPageProvider);
    
    if (currentPage > 1) {
      ref.read(currentPageProvider.notifier).state = currentPage - 1;
    }
  }
  
  void refreshRepositories() {
    ref.invalidate(githubRepositoriesProvider);
  }
  
  void refreshStats() {
    ref.invalidate(githubStatsProvider);
  }
  
  void refreshAll() {
    ref.invalidate(githubRepositoriesProvider);
    ref.invalidate(githubStatsProvider);
  }
}