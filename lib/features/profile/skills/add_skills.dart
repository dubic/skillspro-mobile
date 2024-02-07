import 'package:choice/choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/common/widgets/loading.dart';
import 'package:skillspro/common/widgets/texts.dart';
import 'package:skillspro/theme.dart';

import '../../../common/widgets/buttons.dart';
import '../../../common/widgets/screen_utils.dart';
import 'add_skills_controller.dart';

class AddSkills extends StatelessWidget {
  const AddSkills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddSkillsController c = Get.find();
    c.loadSkills();
    final screenUtils = ScreenUtils.getInstance(context);

    return Scaffold(
        backgroundColor: backgoundColor1,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
                child: Column(children: [
              const TitleText(text: 'Skills'),
              const Gap(15),
              const BodyText(text: 'Let’s add some skills'),
              const Gap(15),
              const BodyText(
                  text: 'Define what you do here. Select the skills that describes what you do'),
              const Gap(30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const BoldText(text: 'Pick your skills'),
                LinkText(text: 'Add a new skill', onTap: () => c.openNewSkill())
              ]),
              const Gap(10),
              Obx(() => SizedBox(height: screenUtils.heightOf(2.5),
                child: SingleChildScrollView(
                  child: Loading(
                      text: '',
                      loading: c.skillsLoadingStatus.value == Status.processing,
                      child: choices(c)),
                ),
              )),
              const Gap(15),
              buttons(c, screenUtils),
              const Gap(30),
              skip(c)
            ]))));
  }

  choices(AddSkillsController c) {
    return Choice<String>.inline(
      clearable: true,
      multiple: true,
      value: c.selectedSkills.value,
      onChanged: (selected) => c.skillSelected(selected),
      itemCount: c.skills.value.length,
      itemBuilder: (state, i) {
        return ChoiceChip(selectedColor: primaryColor,
          selected: state.selected(c.skills.value[i].name),
          onSelected: state.onSelected(c.skills.value[i].name),
          label: Text(c.skills.value[i].name),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        // columns: 4
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 20,
        //   vertical: 25,
        // ),
      ),
    );
  }
}

buttons(AddSkillsController c, ScreenUtils screenUtils) {
  return Obx(() => SubmitBtn(
        key: const Key('next'),
        onPress: () => c.next(),
        title: const Text('Add Projects'),
        loading: c.nextStatus.value == Status.processing,
      ));
}

skip(AddSkillsController c) => Align(
      alignment: Alignment.centerRight,
      child: LinkText(key: const Key('skip'), text: 'Skip', onTap: () => c.skip()),
    );
