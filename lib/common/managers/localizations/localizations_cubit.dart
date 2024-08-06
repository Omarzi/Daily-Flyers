import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../utils/constants/exports.dart';
part 'localizations_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(SelectedLocale(Locale(DCacheHelper.getString(key: CacheKeys.lang) == '' ? 'en' : DCacheHelper.getString(key: CacheKeys.lang)!)));

  void toArabic() => emit(SelectedLocale(const Locale('ar')));

  void toEnglish() => emit(SelectedLocale(const Locale('en')));
}
