import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/widgets/bottom_sheet.dart';
import 'package:skillspro/common/widgets/fields.dart';
import 'package:skillspro/common/widgets/texts.dart';
import 'package:skillspro/features/profile/data/select_state_controller.dart';
import 'package:skillspro/theme.dart';

import '../../../common/http/http_helper.dart';
import '../../../common/widgets/screen_utils.dart';

class StateSelect extends StatelessWidget {
  StateSelect({Key? key}) : super(key: key) {
    final SelectStateController c = Get.find();
    c.loadStates();
  }

  @override
  Widget build(BuildContext context) {
    final screenUtils = ScreenUtils.getInstance(context);
    final SelectStateController c = Get.find();

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const BodyText(text: 'Select a state'),
              actions: [
                InkWell(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close_rounded,
                        weight: 2.0,
                        color: textColor,
                      ),
                    ))
              ],
              forceMaterialTransparency: true,
              backgroundColor: Colors.transparent),
          body: Obx(
            () => c.stateStatus.value == Status.processing
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 800,
                      child: Column(children: [
                        search(c),
                        Visibility(
                          visible: c.showPopular.value,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 100,
                            child: popular(context, c, screenUtils),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: available(context, c),
                        )
                      ]),
                    ),
                  ),
          )),
    );
  }

  search(SelectStateController c) => SearchField(
      placeholder: 'Search state', onChanged: (String query) => c.queryAvailableStates(query));

  popular(BuildContext context, SelectStateController c, ScreenUtils screenUtils) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: c.popularStates.value.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => c.statePicked(c.popularStates.value[index]),
              child: Column(children: [
                Image(
                    image: const AssetImage('assets/images/flag-for-nigeria-circle.png'),
                    width: screenUtils.heightOf(15)),
                const Gap(5),
                BoldText(text: c.popularStates.value[index].name, size: 15)
              ]),
            ),
          );
        });
    // return Column(children: [
    //   const Align(alignment: Alignment.topLeft, child: BoldText(text: 'Popular')),
    //
    // ]);
  }

  available(BuildContext context, SelectStateController c) => ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) return title();
        return stateView(c, index - 1);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: c.availStates.value.length + 1);

  stateView(SelectStateController c, int index) {
    return ListTile(
        onTap: () => c.statePicked(c.availStates.value[index]),
        leading: const Image(image: AssetImage('assets/images/flag-for-nigeria-circle.png')),
        title: BoldText(text: c.availStates.value[index].name, size: 15));
  }

  title() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: const BoldText(text: 'Available'));
  }

// );
// ListView(children: [
//   const Align(alignment: Alignment.topLeft, child: BoldText(text: 'Available')),
//   const Gap(10),
//   Container(
//       height: 600,
//       child: ListView.separated(
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () => c.statePicked(c.availStates.value[index]),
//               child: Row(children: [
//                 const Image(image: AssetImage('assets/images/flag-for-nigeria-circle.png')),
//                 const Gap(10),
//                 BoldText(text: c.availStates.value[index].name, size: 15)
//               ]),
//             );
//           },
//           separatorBuilder: (context, index) => const Divider(),
//           itemCount: c.availStates.value.length))
// ]);
}
