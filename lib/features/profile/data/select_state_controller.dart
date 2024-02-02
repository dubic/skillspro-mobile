import 'package:get/get.dart';
import 'package:skillspro/common/http/http_helper.dart';
import 'package:skillspro/common/services/firestore.dart';
import 'package:skillspro/features/profile/data/state.dart';

class SelectStateController extends GetxController {
  final stateStatus = Status.init.obs;
  List<State> states = [];
  var availStates = Rx<List<State>>([]);
  var popularStates = Rx<List<State>>([]);
  var showPopular = false.obs;

  final FireStoreService fireStoreService;

  SelectStateController(this.fireStoreService) {
    // loadStates();
  }

  Future<List<State>> loadAvailableStates() async {
    var allStates = await fireStoreService.loadAllStates();
    states = allStates;
    availStates.value = allStates;
    return availStates.value;
  }

  Future<List<State>> loadPopularStates() async {
    popularStates.value = await fireStoreService.loadPopularStates();
    if (popularStates.value.isNotEmpty) {
      showPopular.value = true;
    }
    return popularStates.value;
  }

  loadStates() async {
    stateStatus.value = Status.processing;
    await loadAvailableStates();
    await loadPopularStates();
    stateStatus.value = Status.success;
  }

  queryAvailableStates(String query) {
    showPopular.value = query.isNotEmpty ? false : true;
    availStates.value = states.where((state) => state.name.startsWith(query.capitalize!)).toList();
  }

  statePicked(State state) {
    Get.back(result: state.name);
  }
}
