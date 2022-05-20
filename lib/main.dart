import 'package:flutter/material.dart';
import 'package:project5/Pages_Note/addNite.dart';
import 'package:project5/Pages_Note/Home_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(// هنا في ملاحظه انه هنا بقدر اضبط كل اعدادت الخط و الالون داخل البرنامج يعني بضبط ثيم البرنامج من لون و نوع الخط ولون الازرار والى اخره
        primaryColor: Colors.blue, // هنا اللون الاساسي للبرنامج تبعنا عنا بالطبق على الاب بار و ال دروار ....
        buttonColor: Colors.indigo,// هنا بنضع لون الازرار لكل التاطبيق لانه باي تطبيق ناجح لازم او غالبا اللون الازرار لازم يكون موحد
        textTheme: TextTheme( // هنا بنقوم بوضع الستايل الخاص بالنص الان فلتر موفره ستايلات كبيره فيك تختار ستايل معين وتخصص عليه تحت بالشكل الي بدك اياه
          // لكن اعيارك هنا انته حطيت ال textTheme بتقدر تعدل على اي ستايل جاهز من الي موجودين ب فلتر الان مثلا هي ال headline6 موجوده والها اعدادانت افتراضيه
          // مثل اللون وحجم الخط الفكره هنا انا هيني جبتها وعدلت عليها نفسها بما ينتاسب معي الان مش شرط انك في الثيم اعملت للازرار لون خلص ما بتقدر تخصص لكل زر لون لا
          // فيك تروح اذا بدك تغير للون معين للزر فيك تروح داخل الزر وتحط اللون الي بتشوفه مناسب معك او فيك تعمل هنا متغيران للالوان وتغير على كيفك بالي يمشي مع التطبيق
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          headline3: TextStyle( fontSize: 22,fontWeight: FontWeight.bold, color: Colors.deepPurple),
          headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black26),
          headline1: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.deepPurple),


        ),
      ),
      routes: {
        "AddNote": (context) => NewNote(),
        "Home": (context) => HomeMain_Screen(),
      },
      home:HomeMain_Screen() ,

    );
  }
}







