import 'package:app_flutter_rest/models/user.dart';
import 'package:app_flutter_rest/services/api_service.dart';
import 'package:app_flutter_rest/widgets/error_message.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService _apiService = ApiService();
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      // por defecto traer 1 usuario aleatorio
      _userFuture = _apiService.getRandomUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // cada vez que se pulsa el botón, solicitamos nuevos usuarios
          _loadUsers();
        },
        tooltip: 'Cargar usuarios aleatorios',
        child: const Icon(Icons.refresh),
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorMessage(
              message: 'Failed to load user: ${snapshot.error}',
              onRetry: _loadUsers,
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  if (user.avatarUrl != null)
                    Center(
                      child: ClipOval(
                        child: Image.network(
                          user.avatarUrl!,
                          width: 128,
                          height: 128,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.blue,
                            child: Text(
                              user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                              style: const TextStyle(color: Colors.white, fontSize: 32),
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Center(
                      child: CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.blue,
                        child: Text(
                          user.name.isNotEmpty ? user.name.substring(0, 1) : '?',
                          style: const TextStyle(color: Colors.white, fontSize: 32),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Card(
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('@${user.username}'),
                            const SizedBox(height: 8),
                            Text(user.email),
                            if (user.phone != null) ...[
                              const SizedBox(height: 8),
                              Text('Phone: ${user.phone}')
                            ],
                            if (user.location != null) ...[
                              const SizedBox(height: 8),
                              Text('Location: ${user.location}')
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
