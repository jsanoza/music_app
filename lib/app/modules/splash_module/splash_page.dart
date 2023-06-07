import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/modules/splash_module/splash_controller.dart';
import '../../utils/loading.dart';

class SplashPage extends GetWidget<SplashController> {
  const SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Loading(
            loadingType: LoadingType.chasingDots,
          ),
        ),
      ),
    );
  }
}
