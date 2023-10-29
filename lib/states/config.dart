import 'package:lyrxer/pages/color_picker.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/text.dart';
import 'package:lyrxer/states/file_watcher.dart';

//
//
//
// --------- Configuration --------- //

toJson() {
  return {
    'text': {'textSize': textSize.value, 'alignState': alignState},
    'colors': {
      'backgroundColor': backgroundColor.value,
      'subcolor': subcolor.value,
      'textColor': textColor.value
    }
  };
}

void fromYaml(Map conf) async {
  var text = conf['text'];
  textSize.value = text['textSize'];
  alignState = text['alignState'];
  textAlign.value = textAlignTypes[alignState];

  var colors = conf['colors'];
  backgroundColor.value = colors['backgroundColor'];
  subcolor.value = colors['subcolor'];
  textColor.value = colors['textColor'];

  updateTextStyle();
}

updateConfig() async {
  await yamlWrite(configFile, toJson());
  return true;
}
