import 'package:bloc_example/cubit/user_cubit.dart';
import 'package:bloc_example/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    var blocProvider = BlocProvider.of<UserCubit>(context);
    blocProvider.getUsers();
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserCubit, List<Users>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => blocProvider.getUsers(),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Center(child: Text('No Users Found'))
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => blocProvider.getUsers(),
            child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state[index].title!),
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: CircleAvatar(
        maxRadius: 28,
        child: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              print('here');
              // UserCubit().getUsers();
              blocProvider.emptyUsers();
            }),
      ),
    );
  }
}
