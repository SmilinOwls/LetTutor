import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin Localization {
  static initialize(BuildContext context) {
    local = AppLocalizations.of(context);
  }
  static AppLocalizations? local;
}