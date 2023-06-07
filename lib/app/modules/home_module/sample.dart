import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/modules/home_module/home_controller.dart';

class MySearchBar extends StatefulWidget {
  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final List<String> items = ['Apple', 'Banana', 'Cherry', 'Durian', 'Elderberry', 'Fig'];
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (text) {
            setState(() {
              searchText = text;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: filteredItems.length == 0
          ? Container(
              height: 100,
              width: 80,
              color: Colors.red,
            )
          : ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Get.back();
                    Get.find<HomeController>().slideController.show();
                  },
                  title: Text(filteredItems[index]),
                );
              },
            ),
    );
  }

  List<String> get filteredItems {
    if (searchText.isEmpty) {
      return items;
    } else if (items.where((item) => item.toLowerCase().contains(searchText.toLowerCase())).toList().isEmpty) {
      List<String> results = [];
      results.add("");
      return results;
    } else {
      return items.where((item) => item.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }
}
