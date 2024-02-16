// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthSubmitPressed extends AuthEvent {
  final String gender;
  final String country;
  final String state;
  final String city;
  AuthSubmitPressed({
    required this.gender,
    required this.country,
    required this.state,
    required this.city,
  });
}
