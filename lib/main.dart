import 'package:flutter/material.dart';
import 'package:solink_flutter/deep_link_handler.dart';
import 'package:solink_flutter/network/service/server_locator.dart';
import 'package:solink_flutter/repository/repository_locator.dart';
import 'package:solink_flutter/view_model/view_model_locator.dart';

void main() {
  setupLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // This could be any route you choose
      routes: {
        '/': (context) => DeepLinkHandler(), // Route to handle deep links
      },
    );
  }
}

void setupLocators() {
  setupServiceLocator();
  setupRepositoryLocator();
  setupViewModelLocator();
}
