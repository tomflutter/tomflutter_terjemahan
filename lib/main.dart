import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tomflutter Penerjemah",
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownFrom = "English";
  String dropdownTo = "Indonesian";
  String userinput = "";
  String result = "";

  List<String> availableLang = ['English', 'Indonesian'];
  List<String> languageCode = ['en', 'id'];

  // Translate
  resultTranslate() async {
    try {
      final translator = GoogleTranslator();
      var translation = await translator.translate(
        userinput,
        from: languageCode[availableLang.indexOf(dropdownFrom)],
        to: languageCode[availableLang.indexOf(dropdownTo)],
      );

      setState(() {
        result = translation.text;
      });
    } catch (e) {
      print("Error translating: $e");
      // Handle the error as needed, e.g., show an error message to the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tomflutter Penerjemah"),
        backgroundColor: const Color(0xFF35BDD0),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoCEWa2giNE_2O-Xbnlyr216VHHqVEUZSylDRd7BM0pieIDn3C3W8P33gqbIYCVOop7l4&usqp=CAU"), // Ganti dengan URL gambar online Anda
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Sesuaikan nilai sigma sesuai keinginan Anda
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: ListView(
              children: [
                // First Row
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Dari:  ',
                    style: TextStyle(color: Colors.white),
                    )),
                    Expanded(
                      flex: 5,
                      child: DropdownButton<String>(
                        value: dropdownFrom,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownFrom = newValue!;
                          });
                        },
                        items: availableLang
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // Second Row
                Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Ke:  ',
                    style: TextStyle(color: Colors.white),
                    )),
                    Expanded(
                      flex: 5,
                      child: DropdownButton<String>(
                        value: dropdownTo,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Color.fromARGB(255, 94, 12, 236)),
                        underline: Container(
                          height: 2,
                          color: Color.fromARGB(255, 89, 9, 238),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownTo = newValue!;
                          });
                        },
                        items: availableLang
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // TextField
                TextField(
                  maxLines: 5,
                  onChanged: (val) {
                    setState(() {
                      userinput = val;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "",
                    labelText: "Klik Disini",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                MaterialButton(
                  height: 50,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.blue,),
                  ),
                  child: const Text('Translate', style: TextStyle(color: Colors.white, fontSize: 20 )),
                  onPressed: (){
                    // Add loading indicator or text here to indicate translation in progress.
                    resultTranslate();
                  }),

                // Result
                const SizedBox(height: 10,),
                Center(child: Text('Result: $result', style: const TextStyle(color: Colors.white, fontSize: 20 ))),

                const SizedBox(height: 100,),
                const Center(child: Text('GITHUB@TOMFLUTTER', style: TextStyle(color: Colors.white, fontSize: 20 ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
