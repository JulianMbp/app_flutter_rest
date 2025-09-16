import 'package:app_flutter_rest/models/user.dart';
import 'package:app_flutter_rest/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: user.avatarUrl != null
            ? ClipOval(
                child: Image.network(
                  user.avatarUrl!,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4.0),
            Text('@${user.username}'),
            const SizedBox(height: 4.0),
            Text(user.email),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailScreen(user: user),
            ),
          );
        },
      ),
    );
  }
}
