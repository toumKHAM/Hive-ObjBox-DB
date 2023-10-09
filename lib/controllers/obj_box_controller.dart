import 'package:hive_objbox/controllers/random_data.dart';
import 'package:hive_objbox/databases/obj_box_database.dart';
import 'package:hive_objbox/models/obj_box_model.dart';

class ObjBoxController {
  late final ObjBoxDatabase _objBoxDatabase;

  ObjBoxController(){
    _objBoxDatabase = ObjBoxDatabase();
  }

  int countOfEntries(){
    return _objBoxDatabase.length();
  }

  insert({row=1,repeat=1}) async {
    for(int n=0; n<repeat; n++){  // repeat ຈໍານວນເທື່ອເຮັດຊໍ້າ
      for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
        final rd = RandomData.forObjBox(); // random ຂໍ້ມູນ
        ObjBoxModel objBoxModel = ObjBoxModel( name: rd.name, surname: rd.surname, birth_date: rd.birth_date, address: rd.address, tel: rd.tel); // ສ້າງ object
        int result =  await _objBoxDatabase.createItem(objBoxModel); // insert 1 object
        print("insert OK : ${result.toString()}");
      }
      print("---------- finish ${n+1} time ----------");
    }
  }


  select({row=0,repeat=1}) async {
    //--- select all ---//
    if(row==0){
      for(int n=0; n<repeat; n++){  // select repeat ຮອບ
        final List<ObjBoxModel> items = await _objBoxDatabase.selectItem();
        for (var object in items) {
          print(object.toMap());
        }
        print("---------- ${n+1} time ----------");
      }
    }
    //--- select top row ---//
    else{
      List<int> ids = await _objBoxDatabase.getIds(row); // ດຶງ top ໄອດີ
      row = ids.length; // ຈໍານວນ ໄອດີ ທີ່ດຶງມາໄດ້
      for(int n=0; n<repeat; n++){  // select repeat ຮອບ
        for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
          final ObjBoxModel data = await _objBoxDatabase.getItem(ids[r]);
          print(data.toMap());
        }
        print("---------- ${n+1} time ----------");
      }
    }
  }

  update({row=1,repeat=1}) async {
    List<int> ids = await _objBoxDatabase.getIds(row); // ດຶງ top ໄອດີ
    row = ids.length; // ຈໍານວນ ໄອດີ ທີ່ດຶງມາໄດ້
    for(int n=0; n<repeat; n++){  // repeat ຈໍານວນເທື່ອເຮັດຊໍ້າ
      for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
        final rd = RandomData.forObjBox(); // random ຂໍ້ມູນ
        ObjBoxModel objBoxModel = ObjBoxModel(id: ids[r], name: rd.name, surname: rd.surname, birth_date: rd.birth_date, address: rd.address, tel: rd.tel); // ສ້າງ object
        await _objBoxDatabase.updateItem(objBoxModel);
        print("update: ${ids[r]} OK");
      }
      print("---------- ${n+1} time ----------");
    }
  }

  delete({row=1,repeat=1}) async {
    for(int n=0; n<repeat; n++){  // repeat ຈໍານວນເທື່ອເຮັດຊໍ້າ
      List<int> ids = await _objBoxDatabase.getIds(row); // ດຶງ top ໄອດີ
      row = ids.length; // ຈໍານວນ ໄອດີ ທີ່ດຶງມາໄດ້
      for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
        await _objBoxDatabase.deleteItem(ids[r]);
        print("delete: ${ids[r]} OK");
      }
      print("---------- ${n+1} time ----------");
      if(row == 0) break;
    }
  }

  // get all ids
  List<int> getIds(int limit){
    return _objBoxDatabase.getIds(limit);
  }

  // close store
  void close(){
    _objBoxDatabase.close();
  }
}