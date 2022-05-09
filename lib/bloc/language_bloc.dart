import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/language_event.dart';
import 'package:flutter_weather/bloc/language_state.dart';
import 'package:flutter_weather/repository/language_repository.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository? languageRepository;

  LanguageBloc(this.languageRepository) : super(InitialLanguageState()) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<InitalLanguageEvent>(_onGetLanguageFromDB);
  }

  _onChangeLanguage(
      ChangeLanguageEvent languageEvent, Emitter<LanguageState> emitter) {
    emitter(LanguageChangeState(languageEvent.lang));
    if (languageRepository != null) {
      languageRepository!.setCurrentLanguage(languageEvent.lang);
    }
  }

  Future _onGetLanguageFromDB(
      InitalLanguageEvent event, Emitter<LanguageState> emitter) async {
    String lang = await languageRepository!.getCurrentLang();
    emitter(LanguageChangeState(lang));
  }
}
