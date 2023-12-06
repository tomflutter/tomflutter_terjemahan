import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Translator App",
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
        backgroundColor: Color.fromARGB(255, 87, 53, 208),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            // First Row
            Row(
              children: [
                const Expanded(flex: 1, child: Text('From:  ')),
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
                const Expanded(flex: 1, child: Text('To:  ')),
                Expanded(
                  flex: 5,
                  child: DropdownButton<String>(
                    value: dropdownTo,
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
                  hintText: "Ketik Disini",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            const SizedBox(height: 10,),
            MaterialButton(
              height: 50,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.redAccent)
              ),
              child: const Text('Terjemahkan', style: TextStyle(color: Colors.white, fontSize: 20 )),
              onPressed: (){
                // Add loading indicator or text here to indicate translation in progress.
                resultTranslate();
              }),

            // Result
            const SizedBox(height: 10,),
            Center(child: Text('Hasil: $result', style: const TextStyle(color: Colors.black, fontSize: 20 ))),

            const SizedBox(height: 100,),
            const Center(child: Text('Github: Tomflutter', style: TextStyle(color: Colors.deepPurple, fontSize: 20 ))),

          ],
        ),
      ),
    );
  }
}
