import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
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

  WindowOptions windowOptions = const WindowOptions(
    size: Size(320, 320),
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
    return Obx(
      () => GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: theme.value,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: appRoutes(),
        builder: (context, child) {
          return GlobalWindow(
            child: child!,
          );
        },
      ),
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
              duration: 140.milliseconds,
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
                    right: 5 * h.value,
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        opacity: stayFocused.value ? 1 : 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_note_outlined,
                              color: Color(subcolor.value),
                              size: 21,
                            ),
                            Text(' Edit', style: appTextStyle.value),
                          ],
                        )),
                  ),
                ],
              )),
        ),
      ),
    ));
  }
}
