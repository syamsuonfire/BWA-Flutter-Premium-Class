part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel userModel;
  AuthSuccess(this.userModel);
  @override
  // TODO: implement props
  List<Object> get props => [
        userModel,
      ];
}

class AuthFail extends AuthState {
  final String error;

  AuthFail(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [
        error,
      ];
}
