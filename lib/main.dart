import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lyrxer/components/topbar.dart';
import 'package:lyrxer/states/app.dart';
import 'package:lyrxer/states/color.dart';
import 'package:lyrxer/states/focus.dart';
import 'package:lyrxer/states/key_binds.dart';
import 'package:lyrxer/states/text.dart';
import 'package:lyrxer/states/file_watcher.dart';
import 'package:lyrxer/pages/index.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:screen_retriever/screen_retriever.dart';
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

  device = await screenRetriever.getPrimaryDisplay();
  h.value = device.size.height / 100; //Look Later
  w.value = device.size.width / 100; //Look Later
  await windowManager.setSize(device.size);
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        width: w.value * 100, //Look Later
        height: h.value * 100, //Look Later
        child: Stack(
          children: [
            child,
            Positioned(
              top: 12, //Look Later
              right: 8, //Look Later
              left: 8, //Look Later
              child: Obx(
                () => AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    opacity: stayFocused.value ? 1 : 0,
                    child: mode.value != 0 ? const TopBar() : const SizedBox()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
