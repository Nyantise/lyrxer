import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/config.dart';
import 'package:lyrxer/states/key_binds.dart';
import 'package:process_run/shell_run.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

var shell = Shell();

var filepath = getHome() + '/Documents/Projects/generics/bash/';
File lyricstify = File(filepath + 'lyricstify.txt');
File configFile = File(filepath + 'fakonfig.yaml');
late RxMap config;

getHome() {
  String? home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = envVars['HOME'];
  } else if (Platform.isLinux) {
    home = envVars['HOME'];
  } else if (Platform.isWindows) {
    home = envVars['UserProfile'];
  }
  return home;
}

readLastLine() async {
  List<ProcessResult> gotcha =
      await shell.run('tail -n 1 $filepath/lyricstify.txt').then((val) => val);
  return gotcha.first.stdout;
}

getConfig() async {
  try {
    String yamlString = await configFile.readAsString();
    Map yaml = await loadYaml(yamlString);
    fromYaml(yaml);
    await Future.delayed(2500.milliseconds);
    isReady.value = true;
    goTo('lyrics');
    initWatchingFile();
  } catch (e) {
    if (e.toString().contains('PathNotFoundException')) {
      yamlWrite(configFile, toJson());
    }
  }
}

yamlWrite(File file, dynamic json) async {
  YAMLWriter yamlWriter = YAMLWriter();
  var yaml = yamlWriter.convert(json);
  await file.writeAsString(yaml);
  return true;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

RxString hey = 'No Lyrics'.obs;
RxInt noLyricsTimeout = 0.obs;

void initWatchingFile() async {
  lyricstify.watch().listen((event) async {
    String newString = await readLastLine();
    noLyricsTimeout.value = 0;
    hey.value = newString.trim() == '' ? '...' : newString;
  });
  Timer.periodic(const Duration(seconds: 5), (timer) {
    noLyricsTimeout++;
    if (noLyricsTimeout.value >= 3) {
      hey.value = '...';
      if (noLyricsTimeout.value >= 6) {
        hey.value = 'No Lyrics';
      }
    }
  });
}
