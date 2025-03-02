import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solink_flutter/ui/view/sl_button.dart';

class UserScreen extends StatelessWidget {
  final String name;
  final String imageUrl;

  const UserScreen({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return UserProfileView(name: name, imageUrl: imageUrl);
  }
}

class UserProfileView extends StatelessWidget {
  final String name;
  final String imageUrl;

  const UserProfileView({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Add this line
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SLButton(
            onClick: () {
              Navigator.pop(context); // Navigate back
            },
          ),
        ),
      ),
      body: Center(
        // Only Center is used here
        child: Column(
          mainAxisSize: MainAxisSize.min, // Add this
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ClipOval(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 250),
                  fadeOutDuration: const Duration(milliseconds: 250),
                  imageUrl: imageUrl,
                  placeholder:
                      (context, url) => Image.asset(
                        'assets/placeholder_profile_image.jpg',
                        fit: BoxFit.cover,
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Separate widget for the user profile information
class UserProfileInfo extends StatelessWidget {
  final String name;
  final String imageUrl;

  const UserProfileInfo({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Wrap with SafeArea
      child: Center(
        child: Expanded(
          // Wrap the Column with Expanded
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20),
              ClipOval(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 250),
                    fadeOutDuration: const Duration(milliseconds: 250),
                    imageUrl: imageUrl,
                    placeholder:
                        (context, url) => Image.asset(
                          'assets/placeholder_profile_image.jpg',
                          fit: BoxFit.cover,
                        ),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
