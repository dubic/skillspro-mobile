

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/widgets/buttons.dart';
import 'package:skillspro/common/widgets/texts.dart';
import 'package:skillspro/theme.dart';

class NewSkill extends StatelessWidget {
  TextEditingController skillTextController = TextEditingController();

  NewSkill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column( children: [
      const BoldText(text: 'Add new skill'),
      const Gap(20),
      TextField(decoration: inputDecoration('Name'), controller: skillTextController),
      const Gap(15),
      SubmitBtn(onPress: () {
        if(skillTextController.isBlank == true){
          return;
        }
        String newSkill = skillTextController.text.trim();
        Get.back(result: newSkill);
      }, title: const Text('Save'))
    ]);
  }
}
