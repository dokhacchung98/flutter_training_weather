import 'package:flutter/material.dart';
import 'package:flutter_weather/localization/app_localizations.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  _changeLanguageEnglish() {}

  _changeLanguageVietnamese() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.translate("lang_vi")),
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.translate("lang_en")),
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }
}
