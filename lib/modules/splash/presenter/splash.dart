import 'package:complecionista/common/colors.dart';
import 'package:complecionista/config/app_flavor.dart';
import 'package:complecionista/config/app_preferences.dart';
import 'package:complecionista/core/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AppPreferences appPreferences = Modular.get<AppPreferences>();
  Api api = Modular.get<Api>();
  String appVersion = '';
  bool isVisible = true;
  AppColors appColors = getAppColors();

  @override
  void initState() {
    super.initState();
    config();
  }

  void config() async {
    AppFlavor appFlavor = AppFlavor();
    await appFlavor.initPackageInfo();
    appColors = getAppColors();
    setState(() {
      appVersion = appFlavor.getAppVersion();
    });
    appPreferences.getInstances();
    await api.initApi();
    openSecondPage();
  }

  void navigateWithFadeOut(String pageName) async {
    setState(() {
      isVisible = !isVisible;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    Modular.to.navigate(pageName);
  }

  void openSecondPage() async {
    // try {
    //   String token = await appPreferences.getToken();
    //   bool isExpired = JwtDecoder.isExpired(token);
    //   if (isExpired || token.isEmpty) {
    //     Modular.get<AppPreferences>().logout();
    //     Future.delayed(const Duration(seconds: 2)).then((value) => navigateWithFadeOut('/login'));
    //     Modular.to.navigate('/login');
    //   } else {
    //     Future.delayed(const Duration(seconds: 2)).then((value) => navigateWithFadeOut('/dashboard'));
    //   }
    // } catch (e) {
    //   Modular.get<AppPreferences>().logout();
    //   Future.delayed(const Duration(seconds: 2)).then((value) => navigateWithFadeOut('/login'));
    //   Modular.to.navigate('/login');
    // }
    Future.delayed(const Duration(seconds: 2)).then((value) => navigateWithFadeOut('/news'));
  }

  @override
  Widget build(BuildContext context) {
    appColors = getAppColors();
    return Container(
      // decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/launcher_screen.jpg'), fit: BoxFit.fill)),
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              // decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/launcher_screen.jpg'), fit: BoxFit.fill)),
              ),
        ),
      ),
    );
  }
}
