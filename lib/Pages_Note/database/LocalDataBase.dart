import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class SqlDb {

  static Database? _db ; // هنا لاحظ انه علامة الاندرسكور معناها انه المتغبر هاد نوعه برايفت

  Future<Database?> get db async { // هنا انا بطبق مبدا ال singleton عشان اضمن انه القاعدة ما تنتشأ اكثر من مره
    if (_db == null){
      _db  = await intialDb() ;
      return _db ;
    }else {
      return _db ;
    }
  }


  intialDb() async { // هنا بدي ابدأ انشاء قاعدة البيانات لكن اول اشي بدي اجيب المسار الي بدي احفظ فيه القاعدة داخل الجهاز فهنا بجيب المسار وضيفه للاسم عشان اعمل قاعدة البيانات
    String databasepath = await getDatabasesPath() ; // هنا بجيب المسار الافتراضي لحفظ قاعدة البيانات \داخل الجهاز الي بشغل البرنامج
    String path = join(databasepath , 'note.db') ;  //  هنا بروح اعمل دمج المسار مع اسم القواعد البيانات مثال عليها Android/Storg/Not.db ولاحظ هنا الاسم مع نوع القاعده
    Database mydb = await openDatabase(path , onCreate: _onCreate , version: 1  , onUpgrade:_onUpgrade ) ;
    /*
     هنا بننشأ القاعدة ولاحظ انه بنمررلها اولا المسار دالة الانشاء الي عملها تحت وهي بتختص بالاضافة بانشاء الجدول مع المتغيرات الي داخلها وممكن داخلها انشاء اكتر من جدول بشكل طبيعي
     اكن ايضا لاحظ انه الدالة بتخاد اسم القاعده الي بدك تنشا داخلها الجداول و بتاخد الفيرجن اي الاصدار وهذا فيديته انه لمن انا مثلا اطور على قاعدة البيانات لمن اجي
     انفذ التعديل على الجهاز ينفذه وما يحذف البيانات الي كانت بالقاعده القديمه اي انه بحدث وبضله محتفظ بالبيانات القديمه زي لمن تنزل تحدث لبرنامج معين البيانات القديمه بضل موجوده
     وما بتنحذف لانه انته لمن تعمل تعديل على اي قاعدة بيانات من اضافية جدول او حتى التعديل على جدول بتم تطبيق التعديل عن طريق اما انك تحذف القاعدة القديمه وتروح تنشأ قاعدة الجديده
     او اما عن طريق التحديث زي الي شرحناه قبل سطرين
     طيب وبتاخد فنكشن التحديث وبداخله بنحط التعديلات الي بدنا اياها طبعا بتاخد ال oldversion وال newversion عشان اقدر اطبق التحديثات من غير ما اخسر بيانات
     في ملاحضة انه الانشاء ما بطبق الا مره واحده لكن التحديث هوه الي بطبق عدة مرات

     */
    return mydb ;
  }

  _onUpgrade(Database db , int oldversion , int newversion ) {


    print("onUpgrade =====================================") ;

  }

  _onCreate(Database db , int version) async {
    await db.execute('CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT, color TEXT)');
    /*
    هنا لو بدي انشاء جدول تاني عادي جدا بنسخالكود الي فوق وبغير اسم الجدول
      CREATE TABLE "Item" ( // هنا اسم الجدول بحطه
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL,
  )

     */
    print(" onCreate =====================================") ;

  }

  readData(String sql) async { // هنا قمنا بعمل او بنرسل الاستعلام لارجاع البيانات اي هنا بنستعرض البيانات
    Database? mydb = await db ;
    List<Map> response = await  mydb!.rawQuery(sql); // هنا برجعها على شكل لست ماب عشان اقدر استعرضها لاحقا
    return response ;
  }
  insertData(String sql) async { // هنا بترجع رقم الصف الي انته ضفته داخل الجدول
    Database? mydb = await db ;
    int  response = await  mydb!.rawInsert(sql);
    return response ;
  }
  updateData(String sql) async { // وهنا ايضا بترجع السطر الذي تم تحديثه
    Database? mydb = await db ;
    int  response = await  mydb!.rawUpdate(sql);
    return response ;
  }
  deleteData(String sql) async { // اما هنا بتم ارجاع السطر الذي تم حذفه
    Database? mydb = await db ;
    int  response = await  mydb!.rawDelete(sql);
    return response ;
  }

  deleteAllData()  async{
    String databasepath = await getDatabasesPath() ;
    String path = join(databasepath , 'note.db') ;
    await deleteDatabase(path);

  }



// SELECT
// DELETE
// UPDATE
// INSERT






/*هنا المبدأ اانه يقلك في فنكشنات مساعده تستخدم لعمليات الاضافه ةالتعديل الى اخره هاي الدوال المميز فيها نها بتخليك تستغني عن كتابة امر مثلا الاضافه
على شكل كويري اي على شكل اس كيو أل لكن انته انه هدول الدوال شغلها محدود اي انهم بقومه بالا ضافه والتعديل لكن لو انا بدي اعرق مثلا عدد الاسطر الي
في الجدول كيف بدي اطولهم فهنا بنجد الضعف في هادي الفنكشنات فهنا بكون التعامل بال الكويري افضل من التعامل مع هادي الدوال

 */



/*

  read(String table) async {
    Database? mydb = await db ;
    List<Map> response = await  mydb!.query(table);
    return response ;
  }

  insert(String table, Map<String, Object?> value ) async {
    Database? mydb = await db ;
    int  response = await  mydb!.insert(table, value);
    return response ;
  }
  update(String table, Map<String, Object?> value , String? IdNumber ) async {
    Database? mydb = await db ;
    int  response = await  mydb!.update(table,value,where:IdNumber );
    return response ;
  }
  delete(String table,String?  IdNumber) async {
    Database? mydb = await db ;
    int  response = await  mydb!.delete(table,where:IdNumber );
    return response ;
  }*/



}
