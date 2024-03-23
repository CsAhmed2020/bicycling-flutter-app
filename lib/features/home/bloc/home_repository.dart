

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/preferences/preferences_manager.dart';
import 'home_bloc.dart';

abstract class BaseHomeRepository {
  Future<HomeState> getScootersLocations();
}

class HomeRepository implements BaseHomeRepository {
  final PreferencesManager preferencesManager;


  HomeRepository({
    required this.preferencesManager
  });

  @override
  Future<HomeState> getScootersLocations() async{
    late HomeState homeState;
    final locations = [
      const LatLng(30.00753524723074,31.42498885381317),
      const LatLng(30.00863154835396,31.42921601491988),
      const LatLng(30.008594385802404,31.429194557249293),
      const LatLng(30.006290280417677,31.42325078249518),
      const LatLng(30.017914963099347,31.412572867690034),
      const LatLng(29.992539214049657,31.432276564372764)
    ];
    homeState = HomeGetScootersSuccessfullyState(locations);

    return homeState;
  }


}
