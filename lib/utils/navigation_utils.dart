import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../configs/routes.dart';

class NavigationUtils {

  // static navigateTOAnimationRightToLeft(dynamic page,{Transition? transition,Duration? duration}){
  //   if(Platform.isIOS){
  //     return Get.to(page,transition: transition,duration: duration);
  //   }
  //   return Get.to(page,transition:transition ?? Transition.rightToLeft,duration: duration);
  // }
  static navigateTOAnimationRightToLeft({required BuildContext context, required dynamic page,}){
    return context.go(page,);
  }

  static popDialog(){
    if(rootNavigatorKey.currentState!.canPop()){
      rootNavigatorKey.currentState?.maybePop();
    }
  }

}