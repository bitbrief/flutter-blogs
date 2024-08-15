import 'package:hive/hive.dart';
import 'package:subspace/model/blog_model.dart';

class HiveService {
  Future<bool> isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  Future<void> addBoxes(List<BlogModel> items, String boxName) async {
    final openBox = await Hive.openBox(boxName);

    for (var item in items) {
      openBox.add(item.toMap()); // Store data as a Map
    }
  }

  Future<List<BlogModel>> getBoxes(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;

    List<BlogModel> boxList = [];
    for (int i = 0; i < length; i++) {
      var item = openBox.getAt(i);
      if (item != null) {
        boxList.add(BlogModel.fromMap(item));
      }
    }

    return boxList;
  }
}
