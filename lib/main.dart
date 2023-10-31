import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/focus.dart';
import 'package:lyrxer/states/key_binds.dart';
import 'package:lyrxer/states/text.dart';
import 'package:lyrxer/states/file_watcher.dart';
import 'package:lyrxer/pages/index.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: defaultSize,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  // For hot reload, `unregisterAll()` needs to be called.
  await hotKeyManager.unregisterAll();
  runApp(const MyApp());
  await getConfig();
  Future.delayed(5000.milliseconds);
  await windowManager.setSize(const Size(600, 400));
  await registerKeys();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: appRoutes(),
      builder: (context, child) {
        return GlobalWindow(
          child: child!,
        );
      },
    );
  }
}

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextAnimator(
        'LYRXER',
        initialDelay: const Duration(milliseconds: 500),
        characterDelay: const Duration(milliseconds: 80),
        incomingEffect: WidgetTransitionEffects.outgoingScaleUp(
            duration: const Duration(milliseconds: 100)),
        outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
        style: GoogleFonts.getFont(fontList[0],
            color: Color(textColor.value), fontSize: 32),
      ),
    );
  }
}

class GlobalWindow extends StatelessWidget {
  final Widget child;
  const GlobalWindow({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    h.value = size.height / 100;
    w.value = size.width / 100;
    return MouseCatcher(
        child: Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: AnimatedContainer(
              duration: 300.milliseconds,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                  color: stayFocused.value
                      ? Color(backgroundColor.value)
                      : Colors.transparent,
                  border: Border.all(
                    color: hover.value
                        ? Color(subcolor.value)
                        : Colors.transparent,
                  )),
              width: isReady.isFalse ? 320 : 100 * w.value,
              height: isReady.isFalse ? 320 : 100 * h.value,
              child: Stack(
                children: [
                  child,
                  Positioned(
                    top: 5 * h.value,
                    right: 5 * w.value,
                    left: 5 * w.value,
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        opacity: stayFocused.value ? 1 : 0,
                        child: mode.value != 0 ? topBar() : const SizedBox()),
                  ),
                ],
              )),
        ),
      ),
    ));
  }
}

Obx topBar() => Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.help,
                size: 21,
              ),
              Text('     ', style: appTextStyle.value),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.arrow_back_ios,
                size: 21,
              ),
              SvgPicture.asset(
                'assets/q.svg',
                width: 24,
                height: 24,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              SizedBox(
                height: 24,
                width: 140,
                child: CarouselSlider(
                    items: modeTypes.entries.map((e) {
                      return Text(
                        '${e.value} Mode',
                        style: appTextStyle.value,
                      );
                    }).toList(),
                    disableGesture: true,
                    carouselController: myCarousel,
                    options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      padEnds: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 14,
                    )),
              ),
              SvgPicture.asset(
                'assets/e.svg',
                width: 24,
                height: 24,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 21,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.edit_note_outlined,
                size: 21,
              ),
              Text(' Edit', style: appTextStyle.value),
            ],
          ),
        ],
      );
    });
