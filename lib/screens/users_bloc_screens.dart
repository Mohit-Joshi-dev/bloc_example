import 'package:bloc_example/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBlocPage extends StatefulWidget {
  const UsersBlocPage({Key? key}) : super(key: key);

  @override
  _UsersBlocPageState createState() => _UsersBlocPageState();
}

class _UsersBlocPageState extends State<UsersBlocPage> {
  @override
  Widget build(BuildContext context) {
    var blocProvider = BlocProvider.of<UsersBloc>(context);
    blocProvider.add(LoadUsersEvents());
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is ClearUsersState) {
          return RefreshIndicator(
              onRefresh: () async => blocProvider.add(LoadUsersEvents()),
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Center(child: Text('No Users Found')),
                ],
              ));
        } else if (state is LoadingUsersState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FailedToLoadUsersState) {
          return Center(child: Text('Error Found: ${state.error}'));
        } else if (state is LoadedUsersState) {
          return RefreshIndicator(
            onRefresh: () async => blocProvider.add(LoadUsersEvents()),
            child: ListView.builder(
                itemCount: state.users?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.users![index].title!),
                    ),
                  );
                }),
          );
        } else {
          return Container();
        }
      }),
      floatingActionButton: CircleAvatar(
        maxRadius: 28,
        child: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              print('here');
              blocProvider.add(ClearUsersEvents());
            }),
      ),
    );
  }
}
