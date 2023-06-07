import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/themes/app_text_theme.dart';
import '../../../app/modules/lookup_module/lookup_controller.dart';
import '../../utils/common.dart';
import '../../utils/loading.dart';

class LookupPage extends GetWidget<LookupController> {
  const LookupPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Get.back();
              Get.delete<LookupController>();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: TextField(
          controller: controller.textEditingController,
          onChanged: (text) {
            controller.showHistory.value = true;
            controller.isSearching.value = false;
            controller.updateSearchText(text);
          },
          onSubmitted: (text) {
            log(text.toString());
            controller.updateSearchText(text);
            controller.search(text);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Obx(
        () => controller.showHistory.value == true
            ? ListView.builder(
                itemCount: controller.getFilteredItems().length,
                itemBuilder: (context, index) {
                  final item = controller.getFilteredItems()[index];
                  return ListTile(
                    onTap: () {
                      // Get.back();
                      Common.dismissKeyboard();
                      controller.showHistory.value = false;
                      controller.search(controller.searchText.value.toString());
                      // controller.showSlideController();
                    },
                    title: Text(item),
                  );
                },
              )
            : controller.isSearching.value == false
                ? Container(
                    child: Center(child: Loading()),
                  )
                : ListView.builder(
                    itemCount: controller.resultsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          onTap: () {
                            controller.play(controller.resultsList[index]);
                          },
                          leading: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    controller.resultsList[index].thumbnails!.first.url.toString(),
                                  ),
                                )),
                            height: 100,
                            width: 100,
                          ),
                          title: Text(
                            controller.resultsList[index].title.toString(),
                            style: AppTextStyles.base.whiteColor.w900.s14,
                          ),
                          subtitle: Text(
                            controller.resultsList[index].channelName.toString(),
                            style: AppTextStyles.base.whiteColor.w300.s14,
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
