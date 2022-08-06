import 'dart:ui';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class sairypage extends StatefulWidget {
  String doc_id;
  String catagory;
  String backgroudimage;
  sairypage(this.doc_id, this.catagory, this.backgroudimage);
  var arr;

  _sairypageState createState() =>
      _sairypageState(doc_id, catagory, backgroudimage);
}

class _sairypageState extends State<sairypage> {
  late QuerySnapshot<Map<String, dynamic>> shairydata;
  int n = 0;
  String doc_id;
  String catagory;
  String backgroudimage;
  _sairypageState(this.doc_id, this.catagory, this.backgroudimage);
  var arr;
  @override
  void initState() {
    super.initState();
    // loadData1();
    getshairy();
  }

  getshairy() async {
    try {
      shairydata = await FirebaseFirestore.instance
          .collection('catagory')
          .doc(doc_id)
          .collection('shayari')
          .get();
    } catch (e) {
      print("error is this : $e");
    }
    setState(() {
      n = 1;
    });
  }

  colunbracker(String name) {
    arr = name.split(",");

    // for (int i = 0; i < arr.length; i++) {
    //   // print(arr[i]);
    // }
    // return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          title: Text(
            "$catagory",
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
            ),
          ),
          centerTitle: true,
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(backgroudimage),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
          child: (n == 1)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: shairydata.size,
                  itemBuilder: (context, index) {
                    colunbracker(shairydata.docs[index]["shayari"]);
                    return Container(
                      // height: 160,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        border: Border.all(color: Colors.transparent),
                      ),
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 20.0,
                                  sigmaY: 20.0,
                                ),
                                child: Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      bottomRight: Radius.circular(30.0),
                                    ),
                                    border: Border.all(
                                      color: Colors.black,
                                      // color: Colors.red,
                                      // color: Colors.purple,

                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              for (var i in arr)
                                                Text(
                                                  i.toString() + ",",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    // color: Colors.white,
                                                    color: Colors.black,
                                                    letterSpacing: 1.0,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            // topLeft: Radius.circular(35),
                                            bottomRight: Radius.circular(25),
                                            // topLeft: Radius.circular(5),
                                          ),
                                          // color: Colors.cyan
                                          color: Colors.pink[900],
                                          // color: Colors.cyan.shade200, // Color.fromRGBO(156, 25, 111, 1),
                                        ),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    backgroundColor: Colors.cyan
                                                        .withOpacity(0.7),
                                                    content: Text(
                                                      'copaid',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ));
                                                  FlutterClipboard.copy(
                                                      shairydata.docs[index]
                                                          ["shayari"]);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    // color:
                                                    // Color.fromRGBO(82, 14, 53, 0.99),
                                                  ),
                                                  child: Icon(Icons.copy),
                                                )),
                                            Spacer(),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                // color: Color.fromRGBO(82, 14, 53, 1),
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  // Share.share(shairydata
                                                  //     .docs[index]["shayari"]);
                                                },
                                                icon: const Icon(Icons.share),
                                              ),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }
}
