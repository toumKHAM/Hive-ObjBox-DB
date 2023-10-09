import 'package:hive_objbox/controllers/random_data.dart';
import 'package:hive_objbox/databases/hive_database.dart';
import 'package:hive_objbox/models/hive_model.dart';

class HiveController {
  late final HiveDatabase _hiveDatabase;
  HiveController(){
    _hiveDatabase = HiveDatabase();
  }

  int countOfEntries(){
    return _hiveDatabase.length();
  }

  insert({row=1,repeat=1}) async {
    for(int n=0; n<repeat; n++){  // repeat ຈໍານວນເທື່ອເຮັດຊໍ້າ
      for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
        final rd = RandomData.forHive(); // random ຂໍ້ມູນ
        HiveModel hiveModel = HiveModel(rd.id, rd.name, rd.surname, rd.birth_date, rd.address, rd.tel); // ສ້າງ object
        int result =  await _hiveDatabase.createItem(hiveModel); // insert 1 object
        print("insert OK : ${result.toString()}");
      }
      print("---------- finish ${n+1} time ----------");
    }
  }

  select({row=0,repeat=1}) async {
    //--- select all ---//
    if(row==0){ 
      for(int n=0; n<repeat; n++){  // select repeat ຮອບ
        final List<HiveModel> items = await _hiveDatabase.selectItem();
        for (var object in items) {
          print(object.toMap());
        }
        print("---------- ${n+1} time ----------");
      }
    }
    //--- select top row ---//
    else{ 
      List<int> ids = _hiveDatabase.getIds(row); // ດຶງ top ໄອດີ
      row = ids.length; // ຈໍານວນ ໄອດີ ທີ່ດຶງມາໄດ້
      for(int n=0; n<repeat; n++){  // repeat ຈໍານວນເທື່ອເຮັດຊໍ້າ
        for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
          final HiveModel data = await _hiveDatabase.getItem(ids[r]);
          print(data.toMap());
        }
        print("---------- ${n+1} time ----------");
      }
    }
  }

  update({row=1,repeat=1})async{
    List<int> ids = _hiveDatabase.getIds(row); // ດຶງ top ໄອດີ
    row = ids.length; // ຈໍານວນ ໄອດີ ທີ່ດຶງມາໄດ້
    for(int n=0; n<repeat; n++){  // repeat ຈໍານວນເທື່ອເຮັດຊໍ້າ
      for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
        final rd = RandomData.forHive(); // random ຂໍ້ມູນ
        HiveModel hiveModel = HiveModel(rd.id, rd.name, rd.surname, rd.birth_date, rd.address, rd.tel); // ສ້າງ object
        await _hiveDatabase.updateItem(ids[r],hiveModel);
        print("update: ${ids[r]} OK");
      }
      print("---------- ${n+1} time ----------");
    }
  }

  delete({row=1,repeat=1})async{
    for(int n=0; n<repeat; n++){  // repeat ຈໍານວນເທື່ອເຮັດຊໍ້າ
      List<int> ids = _hiveDatabase.getIds(row); // ດຶງ top ໄອດີ
      row = ids.length; // ຈໍານວນ ໄອດີ ທີ່ດຶງມາໄດ້
      for(int r=0; r<row; r++){  // row ຈໍານວນແຖວ
        await _hiveDatabase.deleteItem(ids[r]);
        print("delete: ${ids[r]} OK");
      }
      print("---------- ${n+1} time ----------");
      if(row == 0) break;
    }
  }
}
