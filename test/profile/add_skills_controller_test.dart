import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skillspro/common/services/firestore.dart';
import 'package:skillspro/features/profile/skills/add_skills_controller.dart';

void main() {
  test('Available skills should be 0', () {
    final skillsController = AddSkillsController(FirestoreMock());
    expect(skillsController.skills.value.length, 0);
  });

  test('Available skills should be 0', () async {
    final skillsController = AddSkillsController(FirestoreMock());
    await skillsController.loadSkills();
    expect(skillsController.skills.value.length, greaterThan(0));
  });
}

class FirestoreMock extends FireStoreService{

}