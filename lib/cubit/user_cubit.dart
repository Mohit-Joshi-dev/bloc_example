import 'package:bloc_example/apis/users.dart';
import 'package:bloc_example/models/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<List<Users>> {
  // UserCubit(List<Users> initialState) : super(initialState);
  UserCubit() : super([]);

  final _userApis = UserApis();

  void getUsers() async => emit(await _userApis.getUser());
  void emptyUsers() async => emit([]);
}

abstract class UserEvents {}

class LoadUsersEvents extends UserEvents {}

class ClearUsersEvents extends UserEvents {}

abstract class UsersState {}

class LoadingUsersState extends UsersState {}

class ClearUsersState extends UsersState {}

class LoadedUsersState extends UsersState {
  late List<Users>? users;
  LoadedUsersState({this.users});
}

class FailedToLoadUsersState extends UsersState {
  Object? error;
  FailedToLoadUsersState({this.error});
}

class UsersBloc extends Bloc<UserEvents, UsersState> {
  final _userApis = UserApis();

  UsersBloc() : super(LoadingUsersState());

  @override
  Stream<UsersState> mapEventToState(UserEvents event) async* {
    if (event is ClearUsersEvents) {
      yield ClearUsersState();
    } else if (event is LoadUsersEvents) {
      yield LoadingUsersState();
      try {
        final users = await _userApis.getUser();
        yield LoadedUsersState(users: users);
      } catch (e) {
        yield FailedToLoadUsersState(error: e);
      }
    }
  }
}
