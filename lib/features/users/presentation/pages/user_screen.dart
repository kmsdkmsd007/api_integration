import 'package:dummy/features/users/presentation/cubit/users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("User Screen "),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.read<UsersCubit>().clearUserData(),
          ),
        ],
      ),
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar.toString()),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email.toString()),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            );
          } else if (state is UserError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: ElevatedButton(
              onPressed: () => context.read<UsersCubit>().clearUserData(),
              child: const Text('Load Users'),
            ),
          );
        },
      ),
    );
  }
}
