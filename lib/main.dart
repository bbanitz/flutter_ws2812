import 'package:flutter/material.dart';
//import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_ws2812/view/led_view.dart';
import 'package:flutter_ws2812/view/led_widget.dart';
import 'package:provider/provider.dart';
import 'model/led_infos.dart';
import 'providers/led_provider.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LedProvider>(create: (_) => LedProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'WS2812 Controller'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  bool picker = false;
  void changeColor(Color color) {
    Provider.of<LedProvider>(context, listen: false).setPickerColor(color);
  }

  Widget ledBuilder(int index) {
    return Card(
      color: Provider.of<LedProvider>(context).ledInfos[index - 1].color,
      margin: const EdgeInsets.all(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      //onPressed: () {},
      child: Container(
        color: Provider.of<LedProvider>(context).ledInfos[index - 1].color,
        width: 20,
        child: Center(
          child: Led(index: index),
        ),
      ),
    );
  }

  Widget rowBuilder(int base) {
    List<Widget> elements = [];
    for (int i = 1; i <= Provider.of<LedProvider>(context).colCount; i++) {
      elements.add(Expanded(
          child: Center(
              child: ledBuilder(
                  i + base * Provider.of<LedProvider>(context).colCount))));
    }
    return Row(
      children: elements,
    );
  }

  Widget colBuilder() {
    List<Widget> elements = [];
    for (int i = 0; i < Provider.of<LedProvider>(context).rowCount; i++) {
      elements.add(rowBuilder(i));
    }
    return Column(children: elements);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    print('build');
    return Scaffold(
      /*
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      */
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: [
          Stack(
            children: [
              colBuilder(),
              if (picker)
                Container(
                  color: Colors.white,
                  child: ColorPicker(
                    color: Colors.blue,
                    onChanged: (value) {
                      changeColor(value);
                    },
                    initialPicker: Picker.paletteHue,
                  ),
                )
            ],
          ),
          //const Led(index: 1)

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Provider.of<LedProvider>(context).pickerColor,
              ),
              child: const Text('color picker'),
              onPressed: () {
                setState(() {
                  picker = !picker;
                });
              }),
          ElevatedButton(
              child: const Text('save'),
              onPressed: () {
                Provider.of<LedProvider>(context, listen: false)
                    .ledInfosToJson();
              }),
          //LedWidget(color: Colors.red)
        ]),
      ),
    );
  }
}
