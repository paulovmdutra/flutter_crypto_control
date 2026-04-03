import 'package:flutter/material.dart';

export 'dialog_widgets.dart';
export 'search_field.dart';
export 'input_field.dart';
export 'progress_widget.dart';
export 'form_button.dart';
export 'app_textstyles.dart';
export 'app_form.dart';
export 'app_scaffold.dart';
export 'app_colors.dart';
export 'circular_button_widget.dart';
export 'app_consumer_scaffold.dart';
export 'dasboard_card.dart';
export 'dynamic_popup_menu_button.dart';

Widget spacer(double factor) => SizedBox(height: factor);

enum DisplayType { scaffold, dialog, bottomSheet }
