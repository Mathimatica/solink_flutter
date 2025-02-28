import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solink_flutter/ui/state_holder/state_holder.dart';
import 'package:solink_flutter/view_model/user_view_model.dart';

class UserScreen extends StatelessWidget {
  final int userId;
  final int pageNum;
  final int pagePer;

  const UserScreen({super.key, required this.userId, required this.pageNum, required this.pagePer});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(userId: userId, pageNum: pageNum, pagePer: pagePer),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Consumer<UserViewModel>(
            builder: (context, provider, child) {
              switch (provider.state) {
                case Loading():
                  return CircularProgressIndicator();
                case Error(message: final message):
                  return Text('Error: $message');
                case Success(data: final data):
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name: ${data.name}'),
                      SizedBox(height: 20),
                      Text('Photo URL: ${data.name}'),
                      // Optionally display the image: Image.network(data.photoUrl),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}