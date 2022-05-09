import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/language_bloc.dart';
import 'package:flutter_weather/bloc/language_event.dart';
import 'package:flutter_weather/localization/app_localizations.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  _changeLanguage(BuildContext context, String lang) {
    BlocProvider.of<LanguageBloc>(context).add(ChangeLanguageEvent(lang));
  }

  @override
  Widget build(BuildContext context) {
    var currentLang = BlocProvider.of<LanguageBloc>(context).state.lang;
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.translate("lang_vi")),
            onPressed: () => _changeLanguage(context, 'vi'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  currentLang == 'vi' ? Colors.blueAccent : Colors.grey),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.translate("lang_en")),
            onPressed: () => _changeLanguage(context, 'en'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  currentLang == 'en' ? Colors.blueAccent : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
