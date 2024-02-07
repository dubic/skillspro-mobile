import 'package:get/get.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/common/services/app_cache.dart';
import 'package:skillspro/common/widgets/bottom_sheet.dart';
import 'package:skillspro/features/profile/skills/new_skill.dart';
import 'package:skillspro/features/profile/skills/skill.dart';

import '../../../common/services/firestore.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../profile_service.dart';

class AddSkillsController extends GetxController {
  final FireStoreService fireStoreService;
  final ProfileService profileService;
  var skills = Rx<List<Skill>>([]);
  var selectedSkills = Rx<List<String>>([]);
  final newSkillsKey = 'skills';
  final selectedKey = 'selected';

  final nextStatus = Status.init.obs;
  final skillsLoadingStatus = Status.init.obs;

  AddSkillsController({required this.fireStoreService, required this.profileService});

  loadSkills() async {
    skillsLoadingStatus.value = Status.processing;
    skills.value = await fireStoreService.loadSkills();
    if (AppCache().load(newSkillsKey) != null) {
      for (var skill in (AppCache().load(newSkillsKey) as List<Skill>)) {
        skills.value.add(skill);
      }
    }
    if (AppCache().load(selectedKey) != null) {
      selectedSkills.value = AppCache().load(selectedKey);
    }

    skillsLoadingStatus.value = Status.success;
  }

  next() async {
    nextStatus.value = Status.processing;
    final nextResponse = await profileService.addSkills(selectedSkills.value);
    nextStatus.value = nextResponse.getStatus();
    if (!nextResponse.isSuccessful()) {
      errorToast('Verify account error', nextResponse.error?.message ?? '');
      return;
    }
    skip();
  }

  skip() {
    Get.toNamed(Routes.addProjects);
  }

  openNewSkill() {
    Get.bottomSheet<String>(BottomSheetContainer(content: NewSkill())).then((result) {
      if (result == null) {
        return result;
      }
      cacheNewSkill(result);
      selectedSkills.value.add(result);
      cacheSelected();
    });
  }

  skillSelected(List<String> selected) {
    selectedSkills.value = selected;
    cacheSelected();
  }

  cacheSelected() {
    AppCache().save(selectedKey, selectedSkills.value);
  }

  cacheNewSkill(String name) {
    var newSkills =  AppCache().load(newSkillsKey) ?? List<Skill>.empty(growable: true);
    newSkills.add(Skill(name));
    AppCache().save(newSkillsKey, newSkills);
  }
}
