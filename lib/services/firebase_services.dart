import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tree_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String userId = "user123"; //


  Future<void> addTree(Tree tree) async {
    await _db
        .collection('user_gardens')
        .doc(userId)
        .collection('trees')
        .doc(tree.id.toString())
        .set({
      'id': tree.id,
      'speciesId': tree.speciesId,
      'stage': tree.stage,
      'plantedOn': tree.plantedOn.toIso8601String(),
      'x': tree.x,
      'y': tree.y,
    });
  }

  Future<List<Tree>> fetchUserGarden() async {
    final snapshot = await _db
        .collection('user_gardens')
        .doc(userId)
        .collection('trees')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Tree(
        id: data['id'],
        speciesId: data['speciesId'],
        stage: data['stage'],
        plantedOn: DateTime.parse(data['plantedOn']),
        x: (data['x'] as num).toDouble(),
        y: (data['y'] as num).toDouble(),
      );
    }).toList();
  }
  Future<void> saveDailyProgress(
      DateTime date,
      int tasksCompleted,
      bool treeGrown,
      ) async {
    final key = "${userId}_${date.toIso8601String().split('T')[0]}";

    try {
      await _db.collection('user_daily_progress').doc(key).set({
        'userId': userId,
        'date': date.toIso8601String(),
        'tasksCompleted': tasksCompleted,
        'treeGrown': treeGrown,
      });
      print("✅ Saved daily progress for $key");
    } catch (e) {
      print("❌ Error saving daily progress: $e");
    }
  }

  Future<Map<String, dynamic>?> getDailyProgress(DateTime date) async {
    final key = "${userId}_${date.toIso8601String().split('T')[0]}";
    final doc = await _db.collection('user_daily_progress').doc(key).get();
    return doc.exists ? doc.data() : null;
  }


  Future<void> saveSpecies({
    required int speciesId,
    required int growthStages,
    required Map<String, Map<String, dynamic>> stageParams,
    required String name,
  }) async {
    await _db.collection('species_master').doc(speciesId.toString()).set({
      'speciesId': speciesId,
      'growthStages': growthStages,
      'name': name,
      'stageParams': stageParams,
    });
  }


  Future<List<Map<String, dynamic>>> getAllSpecies() async {
    final snapshot = await _db.collection('species_master').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
