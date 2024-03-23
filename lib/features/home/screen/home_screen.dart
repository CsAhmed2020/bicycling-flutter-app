import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../_base/base_widgets/base_stateful_screen_widget.dart';
import '../../../apis/_base/dio_api_manager.dart';
import '../../../utils/feedback/feedback_message.dart';
import '../../../utils/preferences/preferences_manager.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_repository.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home-screen';

  static Future<void> open(BuildContext context) async {
    await Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomeScreen()), (_) => false);
  }

  final DioApiManager dioApiManager = GetIt.I<DioApiManager>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(HomeRepository(
        preferencesManager: GetIt.I<PreferencesManager>(),
      )),
      child: const HomeScreenWithBloc(),
    );
  }
}

class HomeScreenWithBloc extends BaseStatefulScreenWidget {
  const HomeScreenWithBloc({super.key});

  @override
  BaseScreenState<HomeScreenWithBloc> baseScreenCreateState() {
    return _HomeScreenWithBloc();
  }
}

class _HomeScreenWithBloc extends BaseScreenState<HomeScreenWithBloc> {

  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  static const LatLng _firstDefaultLocation = LatLng(30.00792447940735, 31.428456791169793);

  List<LatLng> _scootersLocations = [];

  LatLng? _currentP = null;

  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    Future.microtask(_getScootersLocationsEventApi);
    /*WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 1000), () async {
        //_checkNotification();
      });
    });*/

    getLocationUpdates().then(
          (_) => {
        /*getPolylinePoints().then((coordinates) => {
          generatePolyLineFromPoints(coordinates),
        }),*/
      },
    );

    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is HomeErrorState) {
              showFeedbackMessage(state.isLocalizationKey
                  ? translate(state.errorMassage)!
                  : state.errorMassage);
            }else if (state is HomeGetScootersSuccessfullyState){
              _scootersLocations = state.locations;
            }
          },
          child: _mapWidget(),
        ),
      ),
    );
  }

  Widget _mapWidget(){
    return _currentP == null
        ? const Center(
      child: Text("Loading..."),
    )
        : GoogleMap(
      onMapCreated: ((GoogleMapController controller) => _mapController.complete(controller)),
      initialCameraPosition: CameraPosition(target: _scootersLocations.first, zoom: 14),
      markers: generateScootersMarkers(_scootersLocations),
      polylines: createPolylines(_scootersLocations),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////



  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  HomeBloc get currentBloc => BlocProvider.of<HomeBloc>(context);

  void _getScootersLocationsEventApi() {
    currentBloc.add(const GetScootersLocationsApiEvent());
  }

  Set<Marker> generateScootersMarkers(List<LatLng> locations) {
    return locations.map((LatLng location) {
      return Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        icon: BitmapDescriptor.defaultMarker,
      );
    }).toSet();
  }

  Set<Polyline> createPolylines(List<LatLng> locations) {
    // Define polyline properties
    PolylineId id = const PolylineId('polyline');
    Color color = Colors.blue;
    int width = 1;

    // Create a list of points from locations
    List<LatLng> points = List<LatLng>.from(locations);

    // Create the polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: color,
      width: width,
      points: points,
    );

    // Return the polyline as a Set
    return {polyline};
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(
      target: pos,
      zoom: 13,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    permissionGranted = await _locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          //_cameraToPosition(_currentP!);
        });
      }
    });
  }

}
