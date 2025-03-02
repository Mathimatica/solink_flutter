
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solink_flutter/ui/screen/user_list_screen.dart';
import 'package:solink_flutter/view_model/user_list_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkHandler extends StatefulWidget {
  const DeepLinkHandler({super.key});

  @override
  State<DeepLinkHandler> createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  late AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      setState(() {
        _handleDeepLink(appLink);
      });
    }

    // Listen to link changes
    _appLinks.uriLinkStream.listen((uri) {
      setState(() {
        _handleDeepLink(uri);
      });
    });
  }

void _handleDeepLink(Uri uri) {
  final host = uri.host; // Use uri.host instead of uri.path
  final queryParams = uri.queryParameters;

  if (host == 'user') { // Compare with uri.host
    final name = queryParams['name'] ?? '';
    final imageUrl = queryParams['imageUrl'] ?? '';
    Navigator.push(context, UserRoute(name: name, imageUrl: imageUrl));
  }
}

  @override
  Widget build(BuildContext context) {
    return const UserListScreen(); // Replace with your actual home screen widget
  }
}

Future<void> sendDeepLink(String deepLinkUrl) async {
    final uri = Uri.parse(deepLinkUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (kDebugMode) {
        print('Could not launch deep link: $deepLinkUrl');
      }
    }
}