import 'package:flutter/material.dart';
import 'package:riverpod_example/api_call_using_riverpod/models/post.dart';

@immutable
abstract class PostState {}

class InitialPostState extends PostState {}

class LoadingPostState extends PostState {}

class LoadedPostState extends PostState {
  LoadedPostState({
    required this.post,
  });

  final List<Post> post;
}

class ErrorPostState extends PostState {
  ErrorPostState({required this.errorMessage});
  final String errorMessage;
}
