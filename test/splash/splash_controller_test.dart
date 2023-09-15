import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillspro/common/splash/splash_controller.dart';
import 'package:skillspro/features/auth/auth_holder.dart';

void main() {
  test('has seen intro should be false initially', () async {
    var storage = const FlutterSecureStorage();
    var authHolder = AuthHolder(storage: storage);
    final Map<String, Object> values = <String, Object>{'something': true};
    SharedPreferences.setMockInitialValues(values);

    bool seen = await SplashController(
            prefs: SharedPreferences.getInstance(), authHolder: authHolder)
        .hasSeenIntro();

    expect(seen, false);
  });

  test('Given seen intro called, has seen intro should be true', () async {
    var storage = const FlutterSecureStorage();
    var authHolder = AuthHolder(storage: storage);
    final Map<String, Object> values = <String, Object>{'something': true};
    SharedPreferences.setMockInitialValues(values);
    SplashController splashController = SplashController(
        prefs: SharedPreferences.getInstance(), authHolder: authHolder);

    await splashController.seenIntro();
    bool seen = await splashController.hasSeenIntro();

    expect(seen, true);
  });
}
