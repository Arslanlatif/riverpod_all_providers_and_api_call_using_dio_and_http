import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/api_call_using_riverpod/models/post.dart';
import 'package:riverpod_example/api_call_using_riverpod/providers/post_provider.dart';
import 'package:riverpod_example/api_call_using_riverpod/states/post_state.dart';

class PostScreen extends ConsumerWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 234, 185),
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: const Text('Posts'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            PostState state = ref.watch(postProvider);
            if (state is InitialPostState) {
              return const Center(
                child: Text('Press button to Fetch Data'),
              );
            }
            if (state is LoadingPostState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.amber,
              ));
            }
            if (state is ErrorPostState) {
              log(state.errorMessage);
              return Center(
                  child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.redAccent),
              ));
            }
            if (state is LoadedPostState) {
              return RefreshIndicator(
                backgroundColor: Colors.amber,
                onRefresh: () async {
                  await ref.read(postProvider.notifier).fetchPosts();
                },
                child: _buildListView(state),
              );
            }
            return const Text('Something is fishy');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(postProvider.notifier).fetchPosts();
        },
        child: const Center(child: Text('Fetch')),
      ),
    );
  }

  Widget _buildListView(LoadedPostState state) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: state.post.length,
      itemBuilder: (context, index) {
        Post post = state.post[index];
        return ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.amberAccent,
              child: Text(post.id.toString())),
          title: Text(
            post.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          subtitle: Text(
            post.body,
            style: const TextStyle(fontSize: 11),
          ),
          trailing: Card(
              elevation: 6,
              shadowColor: Colors.black,
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(child: Text(post.userId.toString())))),
        );
      },
    );
  }
}
