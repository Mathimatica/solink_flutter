import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solink_flutter/network/data/photo_response.dart';
import 'package:solink_flutter/ui/state_holder/state_holder.dart';

import 'dart:math';

import 'package:solink_flutter/view_model/user_list_view_model.dart';

int getRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) =>
              UserListViewModel(pageNum: getRandomNumber(1, 10), pagePer: 50),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Consumer<UserListViewModel>(
            builder: (context, provider, child) {
              switch (provider.state) {
                case Loading():
                  return CircularProgressIndicator();
                case Error(message: final message):
                  return Text('Error: $message');
                case Success(data: final data):
                  return UserListView(stateHolder: data);
              }
            },
          ),
        ),
      ),
    );
  }
}

class UserListView extends StatelessWidget {
  final UserListStateHolder stateHolder;

  const UserListView({super.key, required this.stateHolder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stateHolder.users.length,
      itemBuilder: (context, index) {
        final user = stateHolder.users[index];
        return UserListItemView(
          stateHolder: user,
          onClick: (photo) {
            // Navigate to the user screen using the custom route
            Navigator.push(context, UserRoute(name: photo.photographer, imageUrl: photo.src.original));
          },
        );
      },
    );
  }
}

class UserListItemView extends StatelessWidget {
  final UserListItemStateHolder stateHolder;
  final void Function(Photo) onClick;

  const UserListItemView({
    super.key,
    required this.stateHolder,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        // Use InkWell for tap functionality
        onTap: () {
          stateHolder.processOnClick(onClick);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                // Use Expanded to allow Text to take available space
                child: Text(
                  stateHolder.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(width: 16),
              CachedNetworkImage(
                imageUrl: stateHolder.imageUrl,
                placeholder:
                    (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder:
                    (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 32, // Adjust size as needed
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
