import 'package:complecionista/common/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppFlavor {
  late PackageInfo packageInfo;

  Future<void> initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  Future<Map<String, String>> getUrlBase() async {
    await initPackageInfo();
    String enviroment = getEnvironment();
    String partner = getPartner();

    Map<String, Map<String, String>> maps = {};
    switch (partner) {
      case "complecionista":
        maps = UrlsApi.complecionista;
        break;
    }

    switch (enviroment) {
      case "dev":
        return maps["dev"]!;
      case "intg":
        return maps["intg"]!;
    }
    return maps["prod"]!;
  }

  String getAppName() {
    return packageInfo.appName;
  }

  String getPartner() {
    List<String> names = packageInfo.packageName.replaceAll(".dev", "").replaceAll(".intg", "").split(".");
    if (names.length > 3) return names.last;
    return "complecionista";
  }

  String getEnvironment() {
    List<String> possibleEnviroments = ["dev", "intg"];
    String lastName = packageInfo.packageName.split(".").last;
    if (possibleEnviroments.contains(lastName)) return lastName;
    return "prod";
  }

  String getAppVersion() {
    return packageInfo.version;
  }
}
