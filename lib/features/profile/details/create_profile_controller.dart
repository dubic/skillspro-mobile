import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillspro/features/auth/auth_service.dart';
import 'package:skillspro/features/auth/data/auth_response.dart';
import 'package:skillspro/features/profile/data/state_select.dart';
import 'package:skillspro/features/profile/profile_service.dart';
import 'package:skillspro/routes.dart';
import 'package:skillspro/theme.dart';
import 'package:skillspro/utils.dart';

import '../../../common/http/http_helper.dart';
import '../../auth/user_service.dart';

class CreateProfileController extends GetxController {
  // final imageUploadStatus = Status.init.obs;
  final nextStatus = Status.init.obs;
  final UserService userService;
  final AuthService authService;
  final ProfileService profileService;
  RxString imageUrl = Status.init.obs;

  CreateProfileController(
      {required this.userService, required this.authService, required this.profileService}) {
    AuthResponse? auth = authService.getAccount();
    print('profile auth ::: $auth');
    if (auth?.account.imageUrl != null) {
      imageUrl.value = auth!.account.imageUrl!;
      print('account image ::: ${auth.account.imageUrl!}');
    }

  }

  loadImageAndSend() async {
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null || imageUrl.value == Status.processing) {
      return;
    }

    imageUrl.value = Status.processing;
    try {
      File imageFile = File(pickedImage.path);
      // final compressed = await Utils.compressAndGetFile(imageFile); //compressed?.path ??
      final uploadImageResponse =
          await userService.uploadProfileImage(imageFile.path, pickedImage.name);

      if (!uploadImageResponse.isSuccessful()) {
        errorToast('Upload image error', uploadImageResponse.error?.message ?? '');
        imageUrl.value = Status.init;
        return;
      }
      imageUrl.value = uploadImageResponse.data ?? Status.init;
      authService.updateAcountImageUrl(uploadImageResponse.data);
    } on Exception catch (e) {
      errorToast('Error occurred!', e.toString() ?? '');
      imageUrl.value = Status.init;
    }
  }

  next(GlobalKey<FormBuilderState> formKey) async {
    //...send to BE
    bool? isValid = formKey.currentState?.saveAndValidate();
    if (isValid != null && isValid == false) {
      return;
    }
    nextStatus.value = Status.processing;
    final nextResponse = await profileService.saveDetails(formKey.currentState!.value);
    nextStatus.value = nextResponse.getStatus();
    if (!nextResponse.isSuccessful()) {
      errorToast('Verify account error', nextResponse.error?.message ?? '');
      return;
    }
    skip();
  }

  skip() {
    // imageUrl.value = Status.init;
    Get.toNamed(Routes.addSkills);
  }

  openLocationSelect(GlobalKey<FormBuilderState> formKey) {
    //Country -> State -> City
    var bottomSheet = Get.toNamed(Routes.stateSelect);
    bottomSheet?.then((value) {
      formKey.currentState?.fields['location']?.didChange(value);
    });
  }
}
