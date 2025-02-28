import 'package:cached_network_image/cached_network_image.dart';
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
                  return Column(mainAxisAlignment: MainAxisAlignment.center, 
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Name: ${data.name}', style: Theme.of(context).textTheme.headlineLarge),
                      SizedBox(height: 20),
                      ClipOval(child: SizedBox(width: 200, height: 200, child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 250), fadeOutDuration: Duration(milliseconds: 250),
            imageUrl: data.imageUrl,
            placeholder: (context, url) => Image.asset(
              'assets/placeholder_profile_image.jpg',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            ),
          )),
          ],);
          }
          },
          ),
        ),
      ),
    );
  }
}