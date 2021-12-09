import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_op_gg/api_endpoints/mainscreen.dart';
import 'package:my_op_gg/views/flex_leaderboard.dart';
import 'package:my_op_gg/views/profile.dart';
import 'package:my_op_gg/views/solo_leaderboard.dart';
import 'package:my_op_gg/views/tft_leaderboard.dart';

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
  MaterialColor euwStatus = Colors.red;
  MaterialColor naStatus = Colors.red;
  MaterialColor euneStatus = Colors.red;
  MaterialColor koreaStatus = Colors.red;
  List<String> championsIconsURL = [];
  List<Widget> ChampionsIcons = [];
  var dropdownValue = "EUW";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    MainScreenAPI api = MainScreenAPI();
    await api.fetch();
    setState(() {
      euwStatus = api.getColorEUW();
      naStatus = api.getColorNA();
      euneStatus = api.getColorEUNE();
      koreaStatus = api.getColorKR();
      championsIconsURL = api.getChampionsIconsURL();
    });
    print("championsIconsURL == $championsIconsURL");
    for (int i = 0; i < championsIconsURL.length; i++) {
      ChampionsIcons.add(
        CachedNetworkImage(
          imageUrl: championsIconsURL[i],
          imageBuilder: (
            context,
            imageProvider,
          ) =>
              Container(
            width: MediaQuery.of(context).size.width * 0.125,
            height: MediaQuery.of(context).size.height * 0.125,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (
            context,
            url,
          ) =>
              const CircularProgressIndicator(),
          errorWidget: (
            context,
            url,
            error,
          ) =>
              const Icon(
            Icons.error,
          ),
        ),
      );
    }
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

  Widget championRotation() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...ChampionsIcons,
          ],
        ),
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
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.10,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: MediaQuery.of(context).size.width * 0.62,
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
                                  if (searchTextController.text.isEmpty ==
                                      true) {
                                    return;
                                  }
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
                                  searchTextController.clear();
                                },
                              ),
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: MediaQuery.of(context).size.width * 0.18,
                            padding: const EdgeInsets.only(
                              left: 5,
                            ),
                            child: Center(
                              child: DropdownButton(
                                value: region,
                                items: <String>['euw1', 'eun1', 'na1', 'kr']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (obj) {
                                  print("obj == $obj");
                                  setState(() {
                                    region = obj.toString();
                                  });
                                },
                                borderRadius: BorderRadius.circular(5),
                                underline: SizedBox(),
                              ),
                            )),
                      ],
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
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
            ),
            const Text(
              "Champion's Rotation",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
            ),
            championRotation(),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 35,
                    ),
                  ),
                  const Text(
                    "EUW",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: euwStatus,
                    radius: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  const Text(
                    "NA",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: naStatus,
                    radius: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  const Text(
                    "EUNE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: euneStatus,
                    radius: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  const Text(
                    "KR",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: koreaStatus,
                    radius: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Icon that opens profile page when clicked
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SoloLeaderBoard(
                          server: region,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.poll_outlined,
                        color: Colors.black,
                      ),
                      Text("Solo LeaderBoard"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlexLeaderBoard(
                          server: region,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.poll_outlined,
                        color: Colors.black,
                      ),
                      Text("Flex LeaderBoard"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TftLeaderBoard(
                          server: region,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.poll_outlined,
                        color: Colors.black,
                      ),
                      Text("Tft LeaderBoard"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
