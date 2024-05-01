import 'package:denomination/controllers/data_controller.dart';
import 'package:denomination/screen/history_screen.dart';
import 'package:denomination/utils/const_strings.dart';
import 'package:denomination/utils/number_to_words.dart';
import 'package:denomination/widget/counter_list_widget.dart';
import 'package:denomination/widget/floating_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final TextStyle txtStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);

  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.black54,
        floatingActionButton:
            floatingButtonWidget(context: context, controller: dataController),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.lightBlue,
              expandedHeight: 150.0,
              actions: [
                PopupMenuButton(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 36,
                    width: 48,
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                  onSelected: (value) {
                    Get.to(const History());
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      // row has two child icon and text.
                      child: Row(
                        children: [
                          const Icon(Icons.restart_alt_sharp),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(Strings.history)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: dataController.totalSum.value == 0.0
                          ? Text(
                              textAlign: TextAlign.start,
                              Strings.appName,
                              style: txtStyle)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  Strings.totalAmount,
                                  maxLines: 3,
                                  style: txtStyle,
                                ),
                                Text(
                                  textAlign: TextAlign.start,
                                  dataController.totalSum.value.toString(),
                                  maxLines: 3,
                                  style: txtStyle,
                                ),
                                Text(
                                  textAlign: TextAlign.start,
                                  "${numbersToWords(dataController.totalSum.value)} ${Strings.only}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: txtStyle,
                                ),
                              ],
                            ),
                    )),
              ),
              snap: false,
              floating: true,
              pinned: true,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  ImageStrings.banner,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((_, int index) {
                return CountsList(index: index);
              }, childCount: Strings.multiplyNumber.length),
            )
          ],
        ),
      );
    });
  }
}
