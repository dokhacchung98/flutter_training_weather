import 'package:equatable/equatable.dart';

class LanguageEvent extends Equatable {
  final String lang;

  const LanguageEvent(this.lang);

  @override
  List<Object?> get props => [lang];
}

class ChangeLanguageEvent extends LanguageEvent {
  ChangeLanguageEvent(String lang) : super(lang);
}

class InitalLanguageEvent extends LanguageEvent {
  InitalLanguageEvent() : super('vi');
}
