import 'package:bicycling_app/_base/base_widgets/base_stateful_widget.dart';
import 'package:bicycling_app/apis/models/onboarding/onboarding_item.dart';
import 'package:bicycling_app/features/auth/login/screen/login_screen.dart';
import 'package:bicycling_app/res/app_asset_paths.dart';
import 'package:bicycling_app/res/app_colors.dart';
import 'package:bicycling_app/utils/locale/app_localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/app_buttons/app_elevated_button.dart';

class OnBoardingScreen extends BaseStatefulWidget {
   const OnBoardingScreen({super.key});

   static const routeName = '/onBoarding-screen';

   static Future<void> open(BuildContext context) async {
     await Navigator.pushAndRemoveUntil(context,
         MaterialPageRoute(builder: (context) => const OnBoardingScreen()), (_) => false);
   }

  @override
  BaseState<OnBoardingScreen> baseCreateState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends BaseState<OnBoardingScreen> {

  var items = [
    OnBoardingItem(image: AppAssetPaths.onBoarding1, title: LocalizationKeys.onBoardTitle1, descriptions: LocalizationKeys.onBoardDescription1),
    OnBoardingItem(image: AppAssetPaths.onBoarding2, title: LocalizationKeys.onBoardTitle2, descriptions: LocalizationKeys.onBoardDescription2),
    OnBoardingItem(image: AppAssetPaths.onBoarding3, title: LocalizationKeys.onBoardTitle3, descriptions: LocalizationKeys.onBoardDescription3),
    OnBoardingItem(image: AppAssetPaths.onBoarding4, title: LocalizationKeys.onBoardTitle4, descriptions: LocalizationKeys.onBoardDescription4),
  ];

  @override
  void initState() {
    super.initState();
    items = [
      OnBoardingItem(image: AppAssetPaths.onBoarding1, title: LocalizationKeys.onBoardTitle1, descriptions: LocalizationKeys.onBoardDescription1),
      OnBoardingItem(image: AppAssetPaths.onBoarding2, title: LocalizationKeys.onBoardTitle2, descriptions: LocalizationKeys.onBoardDescription2),
      OnBoardingItem(image: AppAssetPaths.onBoarding3, title: LocalizationKeys.onBoardTitle3, descriptions: LocalizationKeys.onBoardDescription3),
      OnBoardingItem(image: AppAssetPaths.onBoarding4, title: LocalizationKeys.onBoardTitle4, descriptions: LocalizationKeys.onBoardDescription4),
    ];
  }

  /*
  * items = [
      OnBoardingItem(image: AppAssetPaths.onBoarding1, title: translate(LocalizationKeys.onBoardTitle1)!, descriptions: translate(LocalizationKeys.onBoardDescription1)!),
      OnBoardingItem(image: AppAssetPaths.onBoarding2, title: translate(LocalizationKeys.onBoardTitle2)!, descriptions: translate(LocalizationKeys.onBoardDescription2)!),
      OnBoardingItem(image: AppAssetPaths.onBoarding3, title: translate(LocalizationKeys.onBoardTitle3)!, descriptions: translate(LocalizationKeys.onBoardDescription3)!),
      OnBoardingItem(image: AppAssetPaths.onBoarding4, title: translate(LocalizationKeys.onBoardTitle4)!, descriptions: translate(LocalizationKeys.onBoardDescription4)!),
    ];*/
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //Skip Button
            TextButton(
                onPressed: ()=>pageController.jumpToPage(items.length-1),
                child:  Text(translate(LocalizationKeys.skip)!)),

            //Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: items.length,
              onDotClicked: (index)=> pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: AppColors.colorPrimary,
              ),
            ),

            //Next Button
            TextButton(
                onPressed: ()=>pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                child: Text(translate(LocalizationKeys.next)!)),


          ],
        ),
      ),
      body: _onBoardingWidget(),
    );
  }

  Widget _onBoardingWidget(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: PageView.builder(
          onPageChanged: (index)=> setState(()=> isLastPage = items.length-1 == index),
          itemCount: items.length,
          controller: pageController,
          itemBuilder: (context,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(items[index].image),
                SizedBox(height: 16.h),
                Text(translate(items[index].title)!,
                  style: TextStyle(
                    fontSize: 24.spMax,
                    color: AppColors.colorPrimary,
                    fontWeight: FontWeight.w700,
                  ),),
                SizedBox(height: 16.h),
                Text(translate(items[index].descriptions)!,
                    style: TextStyle(
                      fontSize: 16.spMax,
                      color: AppColors.appFormFieldTitle,
                      fontWeight: FontWeight.w500,
                    ), textAlign: TextAlign.center),
              ],
            );

          }),
    );
  }

  Widget getStarted(){
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.h),
        child: AppElevatedButton.withTitle(
          color: const Color(0xFFEFEFEF),
          textColor: const Color(0xFF0F0F0F),
          title: translate(LocalizationKeys.getStarted)!,
          onPressed: (){
        //save seen locally

        //go to home/login
            LoginScreen.open(context);
          } ,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

}



