import 'package:flutter/material.dart';
import 'package:my_op_gg/views/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
/*         backgroundColor: Colors.black,
        primarySwatch: Colors.blue, */
        textTheme: const TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.black,
        ),
      ),
      home: const MyHomePage(title: 'Lol Data Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController searchTextController = TextEditingController();
  var region = "euw1";
  List history = ["test1", "test2"];

  @override
  void initState() {
    super.initState();
  }

  Widget historyList() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          username: history[history.length - (index + 1)],
                          server: region,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 2.0,
                    ),
                    padding: const EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      left: 5,
                    ),
                    height: MediaQuery.of(context).size.height * 0.07,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    // color: Colors.grey[300],
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history[history.length - (index + 1)],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: history.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextField(
                        // cursorColor: Colors.white,
                        controller: searchTextController,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            color: Colors.grey,
                            icon: const Icon(
                              Icons.search,
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    username: searchTextController.text,
                                    server: region,
                                  ),
                                ),
                              );
                              history.add(searchTextController.text);
                              searchTextController.clear();
                            },
                          ),
                          suffixIcon: IconButton(
                            color: Colors.grey,
                            icon: const Icon(
                              Icons.clear,
                            ),
                            onPressed: () {
                              var test = searchTextController.text;
                              print("test == $test");
                              searchTextController.clear();
                            },
                          ),
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 15,
              ),
            ),
            const Text(
              "Recent Search",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            Center(
              child: historyList(),
            )
          ],
        ),
      ),
    );
  }
}
