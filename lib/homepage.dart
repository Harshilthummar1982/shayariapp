import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sairypage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late QuerySnapshot<Map<String, dynamic>> data;
  int n = 0;
  String st = "";

  getcatagory() async {
    print("this is get date start");

    try {
      data = await FirebaseFirestore.instance.collection('catagory').get();
    } catch (e) {
      print("error is this : $e");
    }

    //   print("data is geted");
    //   print("data is : $data");

    setState(() {
      n = 1;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // TODO: implement initState
    super.initState();
    print("this is initstate");
    getcatagory();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    
    SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            // shadowColor: Color.fromRGBO(34, 130, 114, 1),
            title: Text('Love Shayari',
                style: GoogleFonts.pacifico(
                  textStyle:
                      TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
                )
                // style: GoogleFonts.lobster(
                //     fontSize: 28, fontStyle: FontStyle.italic),
                ),
            centerTitle: true,
            bottomOpacity: 0,
          ),
        ),
        body: Container(
          child: (n == 1)
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    // index = index * 2;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          st = data.docs[index].id;
                          // print("st is : $st");
                        });
                        // print("collection is ${data.docs[index]["sairy"]}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => sairypage(
                              st,
                              data.docs[index]["shayari"],
                              data.docs[index]["backimage"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            // color: Color.fromRGBO(110, 225, 231, 1),
                            // color: Colors.white,
                            color: Colors.pink[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              // color: Colors.cyan,
                              color: Colors.pink.shade400,
                              // color: const Color.fromRGBO(115, 21, 76, 1),
                              width: 3,
                            )),
                        height: 80,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            (data.docs[index]["imageUrl"] == " ")
                                ? Container(
                                    // height: 60,
                                    // width: 60,

                                    child: const CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.purple,
                                    ),
                                  )
                                : Container(
                                    // height: 60,
                                    // width: 60,

                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(
                                        data.docs[index]["imageUrl"],
                                        // errorBuilder:
                                        //     (context, error, stackTrace) {
                                        //   return Container(
                                        //     color: Colors.amber,
                                        //     alignment: Alignment.center,
                                        //     child: const Text(
                                        //       'Whoops!',
                                        //       style: TextStyle(fontSize: 30),
                                        //     ),
                                        //   );
                                        // },
                                      ),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                            SizedBox(width: 10),
                            VerticalDivider(
                              // color: Colors.black,
                              // color: Colors.pink.shade900,
                              color: Colors.pinkAccent.shade700,
                              thickness: 2,
                              indent: 10,
                              endIndent: 10,
                            ),
                            SizedBox(width: 10),
                            Text(
                              data.docs[index]["shayari"],
                              // style: TextStyle(
                              //   color: Colors.pinkAccent.shade700,
                              //   fontSize: 20,
                              //   fontWeight: FontWeight.w500,
                              // ),
                              style: GoogleFonts.balooBhaijaan(
                                color: Colors.pinkAccent.shade700,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ),
        ),
        // drawer: Mydrawer(),
      ),
    );
  }
}

