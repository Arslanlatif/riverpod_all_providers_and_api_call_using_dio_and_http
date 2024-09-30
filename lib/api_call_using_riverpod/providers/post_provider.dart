import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/api_call_using_riverpod/models/post.dart';
import 'package:riverpod_example/api_call_using_riverpod/services/http_and_dio_get_service.dart';
import 'package:riverpod_example/api_call_using_riverpod/states/post_state.dart';
import 'dart:developer';

final postProvider = StateNotifierProvider<PostNotifier, PostState>(
  (ref) {
    return PostNotifier();
  },
);

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier() : super(InitialPostState());
  final HttpGetPost _httpGetPost = HttpGetPost();

  fetchPosts() async {
    try {
      log('Fetching posts...');
      state = LoadingPostState();
      List<Post> posts = await _httpGetPost.getPost();
      if (posts.isNotEmpty) {
        log('Posts fetched successfully');
        state = LoadedPostState(post: posts);
      } else {
        log('No posts found');
        state = ErrorPostState(errorMessage: 'No posts found');
      }
    } catch (e) {
      log('Error in fetchPosts: $e');
      state = ErrorPostState(errorMessage: e.toString());
    }
  }
}
