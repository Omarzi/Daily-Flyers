import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:daily_flyers_app/features/auth/models/user_data_model.dart';
import 'package:daily_flyers_app/utils/constants/api_constants.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  UserDataModel userDataModel = UserDataModel();

  Future<void> loginFunction({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.loginUrl,
        body: {
          'email': email,
          'password': password,
        },
      );

      final statusCode = response.statusCode;
      final responseData = response.data as Map<String, dynamic>;
      String messageError = '';

      if (statusCode == 201) {
        logSuccess(responseData.toString());
        userDataModel = UserDataModel.fromJson(responseData);
        logSuccess(userDataModel.toString());

        if (userDataModel.accessToken != null) {
          DCacheHelper.putString(key: CacheKeys.token, value: userDataModel.accessToken!);
        } else {
          logError('Access token is null');
        }
        emit(LoginSuccessState());
      }
      else if (statusCode == 404) {
        messageError = 'Not Found: ${responseData['message'] ?? 'Resource not found'}';
        logError(messageError);
        emit(LoginErrorState(message: messageError));
      }
      else if (statusCode == 401) {
        messageError = 'Un authorized: ${responseData['message'] ?? 'Resource not found'}';
        logError(messageError);
        emit(LoginErrorState(message: messageError));
      }
      else {
        logError('Unexpected status code: $statusCode');
        emit(LoginErrorState(message: 'Unexpected status code: $statusCode'));
      }
    } catch (error) {
      logError(error.toString());
      emit(LoginErrorState(message: error.toString()));
    }
  }

  Future<void> registerFunction({required String name, required String email, required String password, required int countryId}) async {
    emit(SignUpLoadingState());
    try {
      final response = await dioHelper.postData(
        endPoint: ApiConstants.registerUrl,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'country_id': countryId,
        },
      );

      final statusCode = response.statusCode;
      final responseData = response.data as Map<String, dynamic>;
      String messageError = '';

      if (statusCode == 201) {
        logSuccess(responseData.toString());
        userDataModel = UserDataModel.fromJson(responseData);
        logSuccess(userDataModel.toString());

        if (userDataModel.accessToken != null) {
          DCacheHelper.putString(key: CacheKeys.token, value: userDataModel.accessToken!);
        } else {
          logError('Access token is null');
        }
        emit(SignUpSuccessState());
      }
      else if (statusCode == 404) {
        messageError = 'Not Found: ${responseData['message'] ?? 'Resource not found'}';
        logError(messageError);
        emit(SignUpErrorState(message: messageError));
      }
      else if (statusCode == 400) {
        messageError = 'Password: ${responseData['message'] ?? 'Resource not found'}';
        logError(messageError);
        emit(SignUpErrorState(message: messageError));
      }
      else if (statusCode == 401) {
        messageError = 'Un authorized: ${responseData['message'] ?? 'Resource not found'}';
        logError(messageError);
        emit(SignUpErrorState(message: messageError));
      }
      else {
        logError('Unexpected status code: $statusCode');
        emit(SignUpErrorState(message: 'Unexpected status code: $statusCode'));
      }
    } catch (error) {
      logError(error.toString());
      emit(SignUpErrorState(message: error.toString()));
    }
  }
}
