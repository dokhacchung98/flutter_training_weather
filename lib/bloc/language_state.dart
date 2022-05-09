import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable {
  final String lang;

  LanguageState(this.lang);

  @override
  List<Object?> get props => [lang];
}

class InitialLanguageState extends LanguageState {
  InitialLanguageState() : super('vi');
}

class LanguageChangeState extends LanguageState {
  LanguageChangeState(String lang) : super(lang);
}
