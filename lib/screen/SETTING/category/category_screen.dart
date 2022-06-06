import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:tutoring_budget/constants.dart';

import 'category_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (ctrl) {
        return WillPopScope(
          onWillPop: ctrl.useWillPopScope(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Категорія навчання'.tr),
              leading: IconButton(
                  icon: const BackButtonIcon(),
                  onPressed: () => ctrl.backScreen()),
              //actions: const [ChangeLocaleBtt()],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 10,
              direction: Axis.vertical,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  onPressed: () => ctrl.addItem(),
                  child: const Icon(Icons.add, color: WHITE_COLOR),
                ),
                FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () => ctrl.save(),
                  icon: const Icon(Icons.save, color: WHITE_COLOR),
                  label: Text('Save'.tr,
                      style: const TextStyle(color: WHITE_COLOR)),
                )
              ],
            ),
            body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: ctrl.listCategory.length + 1,
              separatorBuilder: (_, __) => const Divider(
                color: MAIN_COLOR,
                height: 1,
              ),
              itemBuilder: (_, i) {
                //Добавлення відсупу знизу
                if (i == ctrl.listCategory.length) {
                  return const SizedBox(height: 100);
                }
                final item = ctrl.listCategory[i];
                return Slidable(
                  actionPane: const SlidableStrechActionPane(),
                  actionExtentRatio: 0.25,
                  actions: [
                    IconSlideAction(
                      color: EDIT_FON_COLOR,
                      foregroundColor: WHITE_COLOR,
                      icon: Icons.edit,
                      onTap: () => ctrl.editItem(i),
                    ),
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      color: DEL_FON_COLOR,
                      foregroundColor: WHITE_COLOR,
                      icon: Icons.delete,
                      onTap: () => ctrl.deleteItem(i),
                    ),
                  ],
                  child: SizedBox(
                    height: 60,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      minVerticalPadding: 10,
                      title: Text(item, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  // ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
