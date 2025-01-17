part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

/// Initail event that notifies teh bloc to subscribe to the `AuthenticationStatus` stream.
final class AuthenticationSubscriptionRequested extends AuthenticationEvent {}

/// Notifies the bloc of a user logout action.
final class AuthenticationLogoutPressed extends AuthenticationEvent {}
