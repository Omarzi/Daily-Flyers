import 'package:daily_flyers_app/features/check_country/models/get_all_countries.dart';
import 'package:daily_flyers_app/utils/constants/api_constants.dart';
import 'package:daily_flyers_app/utils/constants/exports.dart';
import 'package:meta/meta.dart';

part 'counties_state.dart';

class CountiesCubit extends Cubit<CountiesState> {
  CountiesCubit() : super(CountiesInitial());

  static CountiesCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  List<GetAllCountriesModel> getAllCountriesModel = [];

  Future<void> getAllCountriesFunction() async {
    emit(GetAllCountiesLoadingState());
    await dioHelper.getData(endPoint: ApiConstants.getAllCountriesUrl).then(
      (response) {
        // getAllCountriesModel = GetAllCountriesModel.fromJson(response.data);
        getAllCountriesModel = GetAllCountriesModel.fromJsonList(response.data);

        emit(GetAllCountiesSuccessState());
      },
    ).catchError((error) {
      logError(error.toString());
      emit(GetAllCountiesErrorState());
    });
  }
}
