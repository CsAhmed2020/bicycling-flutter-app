

import '../../../utils/preferences/preferences_manager.dart';
import 'home_bloc.dart';

abstract class BaseHomeRepository {
}

class HomeRepository implements BaseHomeRepository {
  final PreferencesManager preferencesManager;


  HomeRepository({
    required this.preferencesManager
  });


}
