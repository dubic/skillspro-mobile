import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skillspro/common/widgets/texts.dart';

import '../../../common/http/http_helper.dart';
import '../../../common/widgets/buttons.dart';
import '../../../common/widgets/screen_utils.dart';
import '../../../theme.dart';
import 'create_profile_controller.dart';

class CreateProfile extends StatelessWidget {
  CreateProfile({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final CreateProfileController c = Get.find();
    final screenUtils = ScreenUtils.getInstance(context);

    return Scaffold(
        backgroundColor: backgoundColor1,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(children: [
              title(c),
              const Gap(10),
              subTitle(c),
              const Gap(10),
              image(c, screenUtils),
              const Gap(15),
              forms(c, screenUtils, context),
              const Gap(20),
              buttons(c, screenUtils),
              const Gap(30),
              skip(c)
            ]),
          ),
        ));
  }

  title(CreateProfileController c) => const TitleText(text: 'Create a profile');

  subTitle(CreateProfileController c) => const BodyText(text: 'Tap on the picture to change');

  image(CreateProfileController c, ScreenUtils screenUtils) {
    return GestureDetector(
      onTap: () => c.loadImageAndSend(),
      child: Obx(() => ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(100),
              child: c.imageUrl.value == Status.processing
                  ? const Center(child: CircularProgressIndicator())
                  : c.imageUrl.value == Status.init
                      ? const Image(
                          image: AssetImage("assets/images/undraw_Pic_profile_re.png"),
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          imageUrl: c.imageUrl.value,
                        ),
            ),
          )),
    );
  }

  forms(CreateProfileController c, ScreenUtils screenUtils, BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(children: [
          FormBuilderTextField(
            key: const Key('mobile'),
            name: 'phone',
            keyboardType: TextInputType.number,
            decoration: inputDecoration("Mobile No.",
                prefix: SvgPicture.asset(
                  'assets/images/mobile.svg',
                  width: 30,
                )),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.maxLength(20),
            ]),
          ),
          const Gap(20),
          FormBuilderTextField(
            key: const Key('instagram'),
            name: 'instagram',
            decoration: inputDecoration("Instagram",
                prefix: SvgPicture.asset('assets/images/instagram.svg', width: 15)),
            validator: FormBuilderValidators.compose([FormBuilderValidators.maxLength(100)]),
          ),
          const Gap(20),
          FormBuilderTextField(
            key: const Key('location'),
            name: 'location',
            decoration: inputDecoration("Location",
                prefix: SvgPicture.asset('assets/images/location.svg', width: 30)),
            readOnly: true,
            onTap: () => c.openLocationSelect(_formKey),
          )
        ]));
  }

  buttons(CreateProfileController c, ScreenUtils screenUtils) {
    return Obx(() => SubmitBtn(
          key: const Key('next'),
          onPress: () => c.next(_formKey),
          title: const Text('Add Skills'),
          loading: c.nextStatus.value == Status.processing,
        ));
  }

  skip(CreateProfileController c) => Align(
        alignment: Alignment.centerRight,
        child: LinkText(key: const Key('skip'), text: 'Skip', onTap: () => c.skip()),
      );
}
