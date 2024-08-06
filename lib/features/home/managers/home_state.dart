part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

/// Get All Banners
class GetAllBannersLoadingState extends HomeState {}

class GetAllBannersSuccessState extends HomeState {}

class GetAllBannersErrorState extends HomeState {}

/// Get All Categories
class GetAllCategoriesLoadingState extends HomeState {}

class GetAllCategoriesSuccessState extends HomeState {}

class GetAllCategoriesErrorState extends HomeState {}

/// Get All Companies
class GetAllCompaniesLoadingState extends HomeState {}

class GetAllCompaniesSuccessState extends HomeState {}

class GetAllCompaniesErrorState extends HomeState {}

/// Profile States
class ProfileLoadingState extends HomeState {}

class ProfileSuccessState extends HomeState {}

class ProfileErrorState extends HomeState {}

/// Add To Favorite
class AddToFavoriteLoadingState extends HomeState {}

class AddToFavoriteSuccessState extends HomeState {}

class AddToFavoriteErrorState extends HomeState {}

/// Remove From Favorite
class RemoveFromFavoriteLoadingState extends HomeState {}

class RemoveFromFavoriteSuccessState extends HomeState {}

class RemoveFromFavoriteErrorState extends HomeState {}

/// Get All Offers States
class GetAllOffersLoadingState extends HomeState {}

class GetAllOffersSuccessState extends HomeState {}

class GetAllOffersErrorState extends HomeState {}
