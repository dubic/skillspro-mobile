import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillspro/features/profile/data/state.dart';
import 'package:skillspro/features/profile/skills/skill.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<QuerySnapshot<Object?>>? _allStatesFuture;
  // Future<QuerySnapshot<Object?>>? _popularStatesFuture;
  // List<State> _allStates = [];
  // List<State> _popularStates = [];

  // fetchAllStates() async {
  //   statesLoaded = false;
  //   print('Fetching states...');
  //   _allStates = await _states
  //       .get()
  //       .then((querySnapshot) => querySnapshot.docs.map((q) => State(q.id)).toList());
  // }

  // fetchPopularStates() async {
  //   _popularStates = _states
  //       .limit(10)
  //       .orderBy('popular', descending: true)
  //       .where('popular', isGreaterThan: 0)
  //       .get();
  // }

  Future<List<State>> loadAllStates() async {
    return await _db.collection('states')
        .get()
        .then((querySnapshot) => querySnapshot.docs.map((q) => State(q.id)).toList());
  }

  Future<List<State>> loadPopularStates() async {
    return await _db.collection('states')
        .limit(10)
        .orderBy('popular', descending: true)
        .where('popular', isGreaterThan: 0)
        .get()
        .then((querySnapshot) => querySnapshot.docs.map((q) => State(q.id)).toList());
  }

  Future<List<Skill>> loadSkills() async {
    print('loading skills');
    return await _db.collection('skills')
        .get()
        .then((querySnapshot) => querySnapshot.docs.map((q) => Skill(q.id)).toList());
  }
}
