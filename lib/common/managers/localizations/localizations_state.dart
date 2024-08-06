part of 'localizations_cubit.dart';

@immutable
abstract class LocaleState {
  final Locale locale;

  const LocaleState(this.locale);
}

class SelectedLocale extends LocaleState {
  SelectedLocale(super.locale);
}