
import 'package:bicycling_app/utils/preferences/preferences_manager.dart';


abstract class BaseSplashRepository {
}

class SplashRepository implements BaseSplashRepository {
  final PreferencesManager preferencesManager;

  SplashRepository(
      {required this.preferencesManager});

}
