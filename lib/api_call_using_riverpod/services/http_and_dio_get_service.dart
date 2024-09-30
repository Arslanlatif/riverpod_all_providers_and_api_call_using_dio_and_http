//! API call using HTTP

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_example/api_call_using_riverpod/models/post.dart';

class HttpGetPost {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const _endPoint = '/posts';

  Future<List<Post>> getPost() async {
    List<Post> posts = [];

    try {
      bool isConnected = await HttpNetworkChecker().hasNetwork();
      log('Network Connectivity: $isConnected');

      if (!isConnected) {
        // No internet connection, load from local storage
        posts = await _loadPostsFromLocalStorage();
        log('Loaded ${posts.length} posts from local storage (offline mode)');
      } else {
        // Fetch from API if online
        Uri postUri = Uri.parse('$_baseUrl$_endPoint'); 

        Response response =
            await get(postUri).timeout(const Duration(seconds: 10));
        log('API Response status: ${response.statusCode}');

        if (response.statusCode == 200) {
          try {
            // Decode JSON response
            List<dynamic> postList = jsonDecode(response.body);
            log('Received ${postList.length} posts from API');

            // Convert JSON to Post objects
            for (var postListItem in postList) {
              Post post = Post.fromMap(postListItem);
              posts.add(post);
            }

            // Save posts to local storage
            await _savePostsToLocalStorage(posts);
            log('Saved ${posts.length} posts to local storage');
          } catch (jsonError) {
            log('Error parsing JSON: $jsonError');
          }
        } else {
          log('Failed to load posts: ${response.statusCode}');
        }
      }
    } catch (e, stackTrace) {
      log('Error fetching posts: $e', error: e, stackTrace: stackTrace);
    }
    return posts;
  }

  // Save posts to local storage as a single JSON string
  Future _savePostsToLocalStorage(List<Post> posts) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String postsJson = jsonEncode(posts.map((post) => post.toMap()).toList());
      await prefs.setString('posts', postsJson);
      log('Posts saved to SharedPreferences');
    } catch (e) {
      log('Error saving posts to local storage: $e');
    }
  }

  // Load posts from local storage
  Future<List<Post>> _loadPostsFromLocalStorage() async {
    List<Post> posts = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? postsJson = prefs.getString('posts');

      if (postsJson != null) {
        log('Loaded posts JSON from SharedPreferences');
        List<dynamic> postList = jsonDecode(postsJson);
        posts = postList.map((postJson) => Post.fromMap(postJson)).toList();
        log('Parsed ${posts.length} posts from local storage');
      } else {
        log('No posts found in SharedPreferences');
      }
    } catch (e) {
      log('Error loading posts from local storage: $e');
    }
    return posts;
  }
}

class HttpNetworkChecker {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const _endPoint = '/posts';

  Future<bool> hasNetwork() async {
    try {
      final response = await get(Uri.parse(_baseUrl + _endPoint))
          .timeout(const Duration(seconds: 4));
      return response.statusCode == 200;
    } catch (e) {
      log('Error checking network: $e');
      return false;
    }
  }
}

//! API call using Dio
// import 'dart:convert';
// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:riverpod_example/api_call_using_riverpod/models/post.dart';

// class DioHttpGetPost {
//   static const _baseUrl = 'https://jsonplaceholder.typicode.com';
//   static const _endPoint = '/posts';

//   final Dio _dio = Dio();

//   Future<List<Post>> getPost() async {
//     List<Post> posts = [];

//     try {
//       // Check if there is internet access
//       bool isConnected = await DioNetworkChecker().hasNetwork();
//       log('Network Connectivity: $isConnected');

//       if (!isConnected) {
//         // No internet connection, load from local storage
//         posts = await _loadPostsFromLocalStorage();
//         log('Loaded ${posts.length} posts from local storage (offline mode)');
//       } else {
//         // Fetch from API if online
//         Uri postUri = Uri.parse('$_baseUrl$_endPoint');
//         log('Fetching posts from API at $postUri');

//         Response response = await _dio.get(postUri.toString());
//         log('API Response status: ${response.statusCode}');

//         if (response.statusCode == 200) {
//           try {
//             // Decode JSON response
//             List<dynamic> postList = response.data;
//             log('Received ${postList.length} posts from API');

//             // Convert JSON to Post objects
//             for (var postListItem in postList) {
//               Post post = Post.fromMap(postListItem);
//               posts.add(post);
//             }

//             // Save posts to local storage
//             await _savePostsToLocalStorage(posts);
//             log('Saved ${posts.length} posts to local storage');
//           } catch (jsonError) {
//             log('Error parsing JSON: $jsonError');
//           }
//         } else {
//           log('Failed to load posts: ${response.statusCode}');
//         }
//       }
//     } catch (e, stackTrace) {
//       log('Error fetching posts: $e', error: e, stackTrace: stackTrace);
//     }

//     return posts;
//   }

//   // Save posts to local storage as a single JSON string
//   Future _savePostsToLocalStorage(List<Post> posts) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String postsJson = jsonEncode(posts.map((post) => post.toMap()).toList());
//       await prefs.setString('posts', postsJson);
//       log('Posts saved to SharedPreferences');
//     } catch (e) {
//       log('Error saving posts to local storage: $e');
//     }
//   }

//   // Load posts from local storage
//   Future<List<Post>> _loadPostsFromLocalStorage() async {
//     List<Post> posts = [];
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? postsJson = prefs.getString('posts');

//       if (postsJson != null) {
//         log('Loaded posts JSON from SharedPreferences');
//         List<dynamic> postList = jsonDecode(postsJson);
//         posts = postList.map((postJson) => Post.fromMap(postJson)).toList();
//         log('Parsed ${posts.length} posts from local storage');
//       } else {
//         log('No posts found in SharedPreferences');
//       }
//     } catch (e) {
//       log('Error loading posts from local storage: $e');
//     }
//     return posts;
//   }
// }

// class DioNetworkChecker {
//   static const _baseUrl = 'https://jsonplaceholder.typicode.com';
//   static const _endPoint = '/posts';

//   final Dio _dio = Dio();

//   Future<bool> hasNetwork() async {
//     try {
//       final response = await _dio.get(_baseUrl + _endPoint,
//           options: Options(receiveTimeout: const Duration(seconds: 5)));
//       return response.statusCode == 200;
//     } catch (e) {
//       log('Error checking network: $e');
//       return false;
//     }
//   }
// }
