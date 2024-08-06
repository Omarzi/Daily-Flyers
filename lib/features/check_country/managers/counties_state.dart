part of 'counties_cubit.dart';

@immutable
sealed class CountiesState {}

final class CountiesInitial extends CountiesState {}

/// Get All Counties
class GetAllCountiesLoadingState extends CountiesState {}

class GetAllCountiesSuccessState extends CountiesState {}

class GetAllCountiesErrorState extends CountiesState {}
