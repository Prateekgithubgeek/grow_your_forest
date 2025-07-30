import 'package:flutter/material.dart';
import '../models/tree_model.dart';
import '../services/firebase_services.dart';

class ForestProvider extends ChangeNotifier {
  final FirebaseService _firebaseService;

  ForestProvider(this._firebaseService) {
    print('ForestProvider initialized');
  }

  List<Tree> _trees = [];
  int _completedTasks = 0;
  int _treeCounter = 0;

  List<Tree> get trees => _trees;
  int get completedTasks => _completedTasks;

  Future<void> loadUserGarden() async {
    try {
      _trees = await _firebaseService.fetchUserGarden();
      _treeCounter = _trees.length;
      notifyListeners();
    } catch (e) {
      print('Error loading garden: $e');
    }
  }
  git config --global user.email "prateeksohani44@gmail.com"

  git remote add origin https: https://github.com/Prateekgithubgeek/grow_your_forest

  Future<void> completeTask() async {
    _completedTasks++;

    try {
      if (_completedTasks % 3 == 0) {
        await _growForest();
        await _firebaseService.saveDailyProgress(
          DateTime.now(),
          _completedTasks,
          true,
        );
      } else {
        await _firebaseService.saveDailyProgress(
          DateTime.now(),
          _completedTasks,
          false,
        );
      }
      notifyListeners();
    } catch (e) {
      print('Error in completeTask: $e');
    }
  }

  void resetTasks() {
    _completedTasks = 0;
    notifyListeners();
  }

  Future<void> _growForest() async {
    if (_trees.isEmpty || _isTreeFullyGrown(_trees.last)) {
      await _plantNewTree();
    } else {
      _trees.last.stage++;
      await _firebaseService.addTree(_trees.last);
    }
    notifyListeners();
  }

  bool _isTreeFullyGrown(Tree tree) {
    switch (tree.speciesId) {
      case 1:
        return tree.stage >= 2;
      case 2:
        return tree.stage >= 3;
      case 3:
        return tree.stage >= 4;
      default:
        return true;
    }
  }

  Future<void> _plantNewTree() async {
    int speciesId = (_trees.length % 3) + 1;
    double spacing = 0.15;
    double startX = 0.05;
    double x = startX + (_trees.length * spacing) % 1.0;
    double y = 0.75;

    Tree newTree = Tree(
      id: _treeCounter++,
      speciesId: speciesId,
      stage: 1,
      plantedOn: DateTime.now(),
      x: x,
      y: y,
    );

    _trees.add(newTree);
    await _firebaseService.addTree(newTree);
  }

  Tree? getTreeAtTap(Offset localPosition, Size screenSize) {
    for (final tree in _trees.reversed) {
      final dx = tree.x * screenSize.width;
      final dy = tree.y * screenSize.height;
      final distance = (Offset(dx, dy) - localPosition).distance;
      if (distance < 40) return tree;
    }
    return null;
  }

  bool isTreePlantedToday(Tree tree) {
    final now = DateTime.now();
    return tree.plantedOn.year == now.year &&
        tree.plantedOn.month == now.month &&
        tree.plantedOn.day == now.day;
  }
  void resetForest() {
    _trees.clear();
    _treeCounter = 0;
    _completedTasks = 0;
    notifyListeners();
  }

}
