import 'package:bloc/bloc.dart';
import 'package:daily_flyers_app/features/home/models/banners/get_all_banners_model.dart';
import 'package:daily_flyers_app/features/home/models/categories/get_all_categories.dart';
import 'package:daily_flyers_app/features/home/models/companies/get_all_companies.dart';
import 'package:daily_flyers_app/features/home/models/offers/all_offers_model.dart';
import 'package:daily_flyers_app/features/home/models/profile/profile_model.dart';
import 'package:daily_flyers_app/utils/constants/api_constants.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  int totalCompaniesCount = 0;

  GetAllBannersModel getAllBannersModel = GetAllBannersModel();
  ProfileDataModel profileDataModel = ProfileDataModel();
  AllOffersModel allOffersModel = AllOffersModel();
  // GetAllCategoriesModel getAllCategoriesModel = GetAllCategoriesModel();
  List<CategoryData> categoriesList = [];
  List<CompanyData> companiesList = [];
  List<FavCompanies> favCompanies = [];
  List<OffersData> offersDataList = [];

  Future<void> getAllBannersFunction() async {
    emit(GetAllBannersLoadingState());
    await dioHelper.getData(endPoint: '${ApiConstants.getAllBannersUrl}/${DCacheHelper.getString(key: CacheKeys.countryId)}').then((response) {
      getAllBannersModel = GetAllBannersModel.fromJson(response.data);
      emit(GetAllBannersSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(GetAllBannersErrorState());
    });
  }

  // Future<void> getAllCategoriesFunction() async {
  //   emit(GetAllCategoriesLoadingState());
  //   await dioHelper.getData(endPoint: ApiConstants.getAllCategoriesUrl).then((response) {
  //     getAllCategoriesModel = GetAllCategoriesModel.fromJson(response.data);
  //     emit(GetAllCategoriesSuccessState());
  //   }).catchError((error) {
  //     logError(error.toString());
  //     emit(GetAllCategoriesErrorState());
  //   });
  // }
  Future<void> getAllCategoriesFunction() async {
    emit(GetAllCategoriesLoadingState());
    try {
      final response = await dioHelper.getData(endPoint: ApiConstants.getAllCategoriesUrl);
      categoriesList = (response.data['data'] as List)
          .map((category) => CategoryData.fromJson(category))
          .toList();
      categoriesList.insert(0, CategoryData(id: 0, enName: 'All', arName: 'الكل'));
      emit(GetAllCategoriesSuccessState());
    } catch (error) {
      logError(error.toString());
      emit(GetAllCategoriesErrorState());
    }
  }

  // Future<void> getAllCompaniesFunction({String? search, int limit = 8, int page = 1}) async {
  //   emit(GetAllCompaniesLoadingState());
  //   try {
  //     // String endPoint = ApiConstants.getAllCompaniesUrl;
  //     String endPoint = '${ApiConstants.getAllCompaniesUrl}?limit=$limit&page=$page';
  //     if (search != null && search.isNotEmpty) {
  //       endPoint += '?search=$search';
  //     }
  //
  //     // final response = await dioHelper.getData(endPoint: endPoint);
  //     // companiesList = (response.data['data'] as List)
  //     //     .map((category) => CompanyData.fromJson(category))
  //     //     .toList();
  //     // emit(GetAllCompaniesSuccessState());
  //     final response = await dioHelper.getData(endPoint: endPoint);
  //     if (page == 1) {
  //       logSuccess(ApiConstants.baseUrl + endPoint.toString());
  //       companiesList = (response.data['data'] as List).map((category) => CompanyData.fromJson(category)).toList();
  //       totalCompaniesCount = response.data['meta']['totalItems'];
  //     } else {
  //       logSuccess(ApiConstants.baseUrl + endPoint.toString());
  //       companiesList.addAll((response.data['data'] as List)
  //           .map((category) => CompanyData.fromJson(category))
  //           .toList());
  //     }
  //   } catch (error) {
  //     logError(error.toString());
  //     String endPoint = '${ApiConstants.getAllCompaniesUrl}?limit=$limit&page=$page';
  //     logSuccess(ApiConstants.baseUrl + endPoint.toString());
  //     emit(GetAllCompaniesErrorState());
  //   }
  // }
  Future<void> getAllCompaniesFunction({String? search, String? filter, int limit = 8, int page = 1}) async {
    companiesList.clear();
    emit(GetAllCompaniesLoadingState());
    try {
      String endPoint = '${ApiConstants.getAllCompaniesUrl}/${DCacheHelper.getString(key: CacheKeys.countryId)}?limit=$limit&page=$page';
      if (search != null && search.isNotEmpty) {
        endPoint += '&search=$search';
      }
      if (filter != null && filter.isNotEmpty) {
        endPoint += '&filter.categories.id=$filter';
        logWarning('filter : $filter');
      }

      final response = await dioHelper.getData(endPoint: endPoint);
      if (page == 1) {
        logSuccess(ApiConstants.baseUrl + endPoint.toString());
        logSuccess('Response data: ${response.data}');
        companiesList = (response.data['data'] as List).map((category) => CompanyData.fromJson(category)).toList();
        totalCompaniesCount = response.data['meta']['totalItems'];
      } else {
        logSuccess(ApiConstants.baseUrl + endPoint.toString());
        companiesList.addAll((response.data['data'] as List)
            .map((category) => CompanyData.fromJson(category))
            .toList());
      }
      emit(GetAllCompaniesSuccessState());
    } catch (error) {
      logError('Error fetching companies: $error');
      emit(GetAllCompaniesErrorState());
    }
  }

  Future<void> profileDataFunction() async {
    favCompanies.clear();
    emit(ProfileLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.profileUrl).then((response) {
      profileDataModel = ProfileDataModel.fromJson(response.data);
      favCompanies.addAll((response.data['fav_companies'] as List)
          .map((favCom) => FavCompanies.fromJson(favCom))
          .toList());
      emit(ProfileSuccessState());
    }).catchError((error) {
      logError('Error fetching companies: $error');
      emit(ProfileErrorState());
    });
  }

  Future<void> addToFavoriteFunction({required String companyId}) async {
    emit(AddToFavoriteLoadingState());
    await dioHelper.patchData(endPoint: 'customers/$companyId/add').then((response) {
      if(response.data['message'] == 'Company added to favorites') {
        emit(AddToFavoriteSuccessState());
      }
    }).catchError((error) {
      logError('Error fetching companies: $error');
      emit(AddToFavoriteErrorState());
    });
  }

  Future<void> removeFromFavoriteFunction({required String companyId}) async {
    emit(RemoveFromFavoriteLoadingState());
    await dioHelper.patchData(endPoint: 'customers/$companyId/remove').then((response) async {
      if(response.data['message'] == 'Company removed from favorites') {
        emit(RemoveFromFavoriteSuccessState());
      }
    }).catchError((error) {
      logError('Error fetching companies: $error');
      emit(RemoveFromFavoriteErrorState());
    });
  }

  Future<void> getAllOffersFunction({required String countryId, required String companyId}) async {
    offersDataList.clear();
    emit(GetAllOffersLoadingState());
    await dioHelper.getData(endPoint: '${ApiConstants.offersUrl}$countryId/$companyId').then((response) {
      allOffersModel = AllOffersModel.fromJson(response.data);
      offersDataList.addAll((response.data['data'] as List)
          .map((favCom) => OffersData.fromJson(favCom))
          .toList());
      emit(GetAllOffersSuccessState());
    }).catchError((error) {
      logError('Error fetching companies: $error');
      emit(GetAllOffersErrorState());
    });
  }
}
