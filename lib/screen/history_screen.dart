import 'package:denomination/controllers/data_controller.dart';
import 'package:denomination/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class History extends StatefulWidget {
  final DenomModel? dataModel;

  const History({super.key, this.dataModel});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());
    Color colorWhite = Colors.white;
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black54,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: colorWhite,
              ),
            ),
            title: Text(
              'History',
              style: TextStyle(color: colorWhite),
            ),
          ),
          body: ListView(
            children: List.generate(
              dataController.dataList.length,
              (index) => Slidable(
                key: ValueKey(index),
                startActionPane: ActionPane(
                  extentRatio: 0.5,
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) async{
                        await dataController.onTapRemoveSelectedIds(dataController.dataList[index].id ?? 0);
                        Navigator.pop(context);
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        dataController.tempDenom.value =
                            dataController.dataList[index];
                        dataController.loadData(
                            dataController.tempDenom.value.id ?? 0,
                            dataController.tempDenom.value.categoryName ?? '',
                            dataController.tempDenom.value.remark ?? '');
                        Get.back();
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                    ),
                    SlidableAction(
                      onPressed: (BuildContext context) => dataController
                          .toggleOnShare(dataController.dataList[index]),
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.share,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    dataController.tempDenom.value =
                        dataController.dataList[index];
                    dataController.loadData(
                        dataController.tempDenom.value.id ?? 0,
                        dataController.tempDenom.value.categoryName ?? '',
                        dataController.tempDenom.value.remark ?? '');
                    Get.back();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B1D26),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataController.dataList[index].categoryName ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              dataController.dataList[index].total ?? '',
                              style: const TextStyle(
                                  color: Color(0xFF4971A9), fontSize: 22),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              dataController.dataList[index].remark ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                          child: Text(
                            dataController.dataList[index].dateTime ?? '',
                            style: const TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
