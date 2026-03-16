import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../services/post_repo.dart';

final repositoryProvider = Provider((ref) => PostRepository());

final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  return FeedNotifier(ref.read(repositoryProvider));
});

class FeedState {
  final List<Post> posts;
  final bool isLoading;
  final bool isFetchingMore;
  final int currentPage;

  FeedState({
    this.posts = const [],
    this.isLoading = true,
    this.isFetchingMore = false,
    this.currentPage = 0,
  });

  FeedState copyWith({
    List<Post>? posts,
    bool? isLoading,
    bool? isFetchingMore,
    int? currentPage,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class FeedNotifier extends StateNotifier<FeedState> {
  final PostRepository _repository;

  FeedNotifier(this._repository) : super(FeedState()) {
    _initFetch();
  }

  Future<void> _initFetch() async {
    state = state.copyWith(isLoading: true);
    final posts = await _repository.fetchPosts(page: 0);
    state = state.copyWith(posts: posts, isLoading: false, currentPage: 0);
  }

  Future<void> fetchMore() async {
    if (state.isLoading || state.isFetchingMore) return;

    state = state.copyWith(isFetchingMore: true);
    final nextPage = state.currentPage + 1;
    final newPosts = await _repository.fetchPosts(page: nextPage);

    state = state.copyWith(
      posts: [...state.posts, ...newPosts],
      isFetchingMore: false,
      currentPage: nextPage,
    );
  }

  // Local state mutations for Like/Save
  void toggleLike(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        );
      }
      return post;
    }).toList();
    state = state.copyWith(posts: updatedPosts);
  }

  void toggleSave(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(isSaved: !post.isSaved);
      }
      return post;
    }).toList();
    state = state.copyWith(posts: updatedPosts);
  }
}