import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database/LocalDataBase.dart';
import 'database/operation.dart';


class NewNote extends StatefulWidget {


  @override
  NewNote_test createState() => NewNote_test(Colors.red);
}


class NewNote_test extends State<NewNote> {

  Color passedColor; //هنا نجتاز لوحة الألوان


  NewNote_test(this.passedColor);



  final List colorsItem = OperationdataInsert().colors;
       TextEditingController note  =   TextEditingController();
       TextEditingController title =  TextEditingController();



  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  EidtFunc(){

    return showModalBottomSheet(context: context, builder: (context){

      return Container(
        color: passedColor,
        alignment: Alignment.centerLeft,
        height: 350,
          padding: EdgeInsets.fromLTRB(15,50,15,0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                InkWell(child: Row(children: [
                      Container(
                      child:
                      CircleAvatar(
                        child: Icon(Icons.share,color: Colors.black, ),
                        backgroundColor: Colors.white70,
                      ),width: 80,),
                      Text("Share With your Frinds",style:Theme.of(context).textTheme.headline6),]),
                      splashColor:Colors.black12, onTap: (){}, ),
                InkWell(child: Row(children: [
                  Container(
                    child:

                    CircleAvatar(
                      child: Icon(Icons.delete ,color: Colors.black, ),
                      backgroundColor: Colors.white70,
                    ), width: 80,),
                  Text("Delete",style:Theme.of(context).textTheme.headline6),]),
                  splashColor:Colors.black12, onTap: () {
                  Navigator.of(context).pop();}, ),


                InkWell(child: Row(children: [
                  Container(
                    child: CircleAvatar(
                     child: Icon(Icons.control_point_duplicate , color: Colors.black,),
                      backgroundColor: Colors.white70,
                    ), width: 80,),
                  Text("Duplicate",style:Theme.of(context).textTheme.headline6),]),
                  splashColor:Colors.black12, onTap: (){}, ),

      Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 75.0,
      child: ListView.builder(

      scrollDirection: Axis.horizontal,
      itemCount: colorsItem.length,
      itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: (){
          setState(() {

            passedColor = colorsItem[index] ;
            print(passedColor);
            Navigator.of(context).pop();


          });

        },
        child: Container(
          width: 60,padding: EdgeInsets.symmetric(horizontal: 5),
          child: CircleAvatar(
            backgroundColor: colorsItem[index],
            child: passedColor ==  colorsItem[index]?  Icon(Icons.done_rounded ,color: Colors.black, )

            :Text(''),


          ),
        ),
      );
      }
      ),
      )

              ],

            ),
      );

    });

  }


  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('New Note ',
        style: TextStyle(fontSize: 30, color: Colors.white)),
        backgroundColor:  passedColor ,
        centerTitle: true,
        toolbarHeight: 90,
        actions: [
          IconButton(icon:Icon(Icons.linear_scale),onPressed: () { EidtFunc(); },),
          IconButton(icon:Icon(Icons.done),onPressed: () async {

            if (_formKey.currentState!.validate()) {

              OperationdataInsert().InsertData(title.text, note.text, passedColor);
              Navigator.of(context).pushReplacementNamed('Home');

          } },),

        ],
      ),

      body: Container(





        padding: EdgeInsets.all(20),

        child:   SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,

              child:   Column(
                  mainAxisSize: MainAxisSize.max,

                  children: [

                    TextFormField(
                      maxLines: 1,
                      controller: title,
                      decoration: InputDecoration(
                        hintText: "Type something",
                        hintStyle: TextStyle(color: Colors.indigo, fontSize: 23),
                        hintMaxLines: 2,
                        labelText: "Title",
                        labelStyle: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12, width: 5),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple, width: 3),
                        ),
                        prefixIcon:  Icon(Icons.note,color: Colors.indigo,),
                      ),
                      validator: (value) {
                        if(value == null || value.length < 3){
                          return "the length of the First Name must be grater more than 50 degits";
                        }else if(value == null || value.length > 50){
                          return "the length of the First Name must be Less than 50 degits";
                        }
                        return null;
                      },

                    ),


                    SizedBox(height: 40,),
                    TextFormField(
                        controller: note,
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                        hintText: "Type something",
                        hintStyle: TextStyle(color: Colors.indigo, fontSize: 23),
                        hintMaxLines: 2,
                        labelText: "Describtion",
                        labelStyle: TextStyle(color: Colors. black54,fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12, width: 5),
                          ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple, width: 3),
                        ),
                          prefixIcon: Icon(Icons.description,color: Colors.indigo,),
                      ),

                      validator: (value) {
                        if(value == null || value.length < 2 ){
                          return "the length of the Passworde must be Grater than 2 degits";
                        }else return null;
                      },
                    ),
                    SizedBox(height: 30,),







                  ])),),





      ),

    );


  }
}