import 'package:appintro/youtubepromotion.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Introduction.',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final PageController _pageController = PageController();
  final String _imageBG = 'images/bg_screen.png';
  final List<String> _imageList = const [
    'images/intro1.png',
    'images/intro2.png',
    'images/intro3.png',
    'images/intro4.png',
  ];
  double _currentPage = 0;
  bool _hideIntroduction = false;

  @override
  void initState() {
    _pageController.addListener((){
      setState(() => _currentPage = _pageController.page);
    });
    super.initState();
  }

  Widget _pageViewChildImage(String imageString) {
    return Image.asset(imageString,fit: BoxFit.fitWidth,);
  }

  Widget _pageViewIndicator(int location) {
    return Padding(
      padding: const EdgeInsets.only(right:6.0,left:6),
      child: Icon(Icons.lens,size: 14,color: location - 1 <= _currentPage&& _currentPage < location ? Colors.blue[900] : Colors.grey[600]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text('App Introduction example.'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('This is main screen.', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      child: Text('Show Intro again'),
                      onPressed: () =>setState(() =>_hideIntroduction = false)),
                ),
                youtubePromotion()
              ],
            ),
          ),
        ),
        !_hideIntroduction ? Positioned(
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image:
                  AssetImage(_imageBG),
                      fit: BoxFit.fill)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Container(
                        width: size.width - 60,
                        height: 480,
                        color: Colors.white,
                        child: PageView(
                          controller: _pageController,
                          children: <Widget>[
                            _pageViewChildImage(_imageList[0]),
                            _pageViewChildImage(_imageList[1]),
                            _pageViewChildImage(_imageList[2]),
                            _pageViewChildImage(_imageList[3]),
                          ],
                        ),
                      ),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _pageViewIndicator(1),
                          _pageViewIndicator(2),
                          _pageViewIndicator(3),
                          _pageViewIndicator(4),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _currentPage < 3 ? 'Next' : 'Okay ! Go to Main',
                                style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          textColor: _currentPage < 3 ? Colors.black : Colors.white,
                          color: _currentPage < 3 ? Colors.white : Colors.blue[900],
                          padding: EdgeInsets.all(10),
                          onPressed: () {
                            if (_pageController.page.toInt() < 3) {
                              _pageController.animateToPage(
                                  _pageController.page.toInt() + 1,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }else {
                              setState(() {
                                _hideIntroduction = true;
                                _pageController.jumpToPage(0);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) : Container(),
      ],
    );
  }
}
