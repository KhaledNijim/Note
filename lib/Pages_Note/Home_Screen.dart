import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'database/operation.dart';
import 'Edit.dart';

class HomeMain_Screen extends StatefulWidget {

  State<StatefulWidget> createState() {
    return HomeScreen_test();
  }
}

class HomeScreen_test extends State<HomeMain_Screen> {
  Widget build(BuildContext context) {
    double colornote = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Note',
            style: TextStyle(fontSize: 30, color: Colors.white)),
        centerTitle: true,
        toolbarHeight: 90,
        backgroundColor: Theme.of(context).primaryColor,

      ),
      body: Container(
          child: ListView(
        children: [
          FutureBuilder( //استخدم FutureBuilder لتحقيق التحميل البطيء ، ويمكنه مراقبة حالة عملية التحميل
            // إذا كانت بيانات القائمة فارغ فسيتم عرض فارغة. إذا كانت هناك بيانات ، فقم بتحميل البيانات لعرضها.
              future: OperationdataInsert().redData('SELECT * FROM notes'),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if ( snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, i) {
                      return Dismissible(
                          key: Key(
                              "$i"), // هنا دالة ال Dismissible تقوم بعمل سواب حذف للست اي بتقدر تعمل سواب لاي عنصر في اللست
                          // وراح ينحذف معك بضيف لمسه جماليه, طيب بتاخد مفتاح او رقم الاندكس الي بدك تحذفه وطبعا اللست ككل عشان تقدر تعمل لكل عنصر من عناصرها سواب

                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(//تستخدم لرسم مربع به مستطيل دائري الشكل
                                borderRadius: BorderRadius.circular(5)),
                            margin: EdgeInsets.symmetric(vertical: 20),
                            shadowColor: Colors.cyanAccent,
                            child: Row(
                              children: [
                                Container(
                                    width: 5,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blueAccent, width: 60),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                    )),
                                Container(
                                  width: colornote - 30,
                                  padding: EdgeInsets.all(20),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(5),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Text(
                                        "${snapshot.data![i]['title']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                    dense: true,
                                    subtitle: Text(
                                        "${snapshot.data![i]['note']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                    onTap: () {
                                      print('***************************');
                                      print(i);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute( // طريقة استبدال الشاشة بأكملها
                                              builder: (_) => EditNote(
                                                   id: i, Title: snapshot.data![i]['title'],
                                                   note: snapshot.data![i]['note'],
                                                   Color:  snapshot.data![i]['color'] )));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                }
                return Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          child: Image.asset(
                            'images/note.jpg',
                            height: 300,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'No Notes :(',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'you have no task to do',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ));
              })
        ],
      )),
      floatingActionButton: FloatingActionButton( // زر دائري يطفوا فوق واجهة المستخدم استدعاء أجزاء من التطبيق وتنفيذها
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed('AddNote');
        },
        tooltip: 'New Note',
        child: const Icon(Icons.add),
        splashColor: Colors.orangeAccent,
      ),
    );
  }
}
