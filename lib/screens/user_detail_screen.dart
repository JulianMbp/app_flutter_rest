import 'package:app_flutter_rest/models/user.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user.avatarUrl != null)
              Center(
                child: ClipOval(
                  child: Image.network(
                    user.avatarUrl!,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.blue,
                      child: Text(
                        user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                        style: const TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16.0),
            _buildInfoCard('Personal Information', [
              _buildInfoRow('Name', user.name),
              _buildInfoRow('Username', '@${user.username}'),
              _buildInfoRow('Email', user.email),
              if (user.phone != null) _buildInfoRow('Phone', user.phone!),
              if (user.location != null) _buildInfoRow('Location', user.location!),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.0,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
