import 'package:flutter/material.dart';
import 'package:multi_relation_tree/multi_relation_tree.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Multi relation tree"),
        ),
        body: const Align(alignment: Alignment.topCenter,
          child: MultiRelationTree())
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Column _userNode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('node'),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.add_circle_outline,
                size: 20,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ],
        ),
        Container(
          width: 250,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.blue[100],
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.male,
                color: Colors.blue,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(child: Text('Node name')),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
