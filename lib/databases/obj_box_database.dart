import '../models/obj_box_model.dart';
import '../objectbox.g.dart';

class ObjBoxDatabase{
  late final Box<ObjBoxModel> _box;
  late final Store _store;

  ObjBoxDatabase(){
    init();
  }

  Future<void> init() async{
    _store = await openStore();
    _box = Box<ObjBoxModel>(_store);
  }

  // insert 1 item
  Future<int> createItem(ObjBoxModel objectBox) async {
    return _box.put(objectBox);
  }

  // select all item
  Future<List<ObjBoxModel>> selectItem() async {
    return _box.getAll();
  }

  // get 1 item by id
  Future<ObjBoxModel> getItem(id) async {
    return _box.get(id) as ObjBoxModel;
  }

  // update 1 item by id
  Future<int> updateItem(ObjBoxModel objectBox) async {
    return _box.put(objectBox);
  }

  // delete  1 item by id
  Future<bool> deleteItem(int id) async {
    return _box.remove(id);
  }

  // get all ids
  Future<List<int>> getIds1(int limit) async{
    Query<ObjBoxModel> query = _box.query().build();
    List<int> ids = query.property(ObjBoxModel_.id).find();
    return ids;
  }

  // get all ids
  List<int> getIds(int limit){
    List<int> allId = _box.query().build().findIds();
    List<int> ids = [];
    int i=0;
    for (var id in allId) {
      ids.add(id);
      if( ++i == limit ){
        break;
      }
    }

    return ids;
  }

  // get number of entries in the box
  int length(){
    return _box.count();
  }

  // close store
  void close(){
    _store.close();
  }
}