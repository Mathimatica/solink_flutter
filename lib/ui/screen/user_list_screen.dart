import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solink_flutter/deep_link_handler.dart';
import 'package:solink_flutter/network/data/photo_response.dart';
import 'package:solink_flutter/network/service/server_locator.dart';
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
          (_) => locator.get<UserListViewModel>(param1: getRandomNumber(1, 10), param2: 50),
      child: Scaffold(
        appBar: AppBar(title: const Text('Solink Flutter Demo')),
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
    return Padding(
      // Add Padding widget
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: stateHolder.users.length,
        itemBuilder: (context, index) {
          final user = stateHolder.users[index];
          return UserListItemView(
            stateHolder: user,
            onClick: (photo) {
                final name = Uri.encodeComponent(photo.photographer); // Encode the name
                final imageUrl = Uri.encodeComponent(photo.src.original); // Encode the image URL
                final deepLinkUrl = 'com.example.solinkflutter://user?name=$name&imageUrl=$imageUrl';
                sendDeepLink(deepLinkUrl);
            },
          );
        },
      ),
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
      color: const Color(0xFF0288D1), // Set the card's background color
      shadowColor: const Color(0xFF01579B), // Set the card's shadow color
      elevation: 4.0,
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white, // Set the text color to white
                  ),
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
