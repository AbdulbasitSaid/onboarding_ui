import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Onboarding Screen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final List<Widget> pageViewItems = [
    OnboardPageViewItem(
      title: 'First page',
      description: [
        RichText(
          text: const TextSpan(
            text:
                'Aliquip laborum sunt sint sint duis enim pariatur id excepteur. Voluptate dolore dolor quis nisi officia exercitation nulla Lorem amet. Aliqua fugiat Lorem Lorem culpa exercitation nostrud elit sunt do velit officia consectetur occaecat.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: const TextSpan(
            text: 'Hello ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' world!'),
            ],
          ),
        )
      ],
      imagePath: 'Thumbnail',
    ),
    const Center(
      child: Text('Page 2'),
    ),
    const Center(
      child: Text('Page 3'),
    ),
    const Center(
      child: Text('Page 4'),
    ),
    const Center(
      child: Text('Page 5'),
    ),
    const Center(
      child: Text('Page 6'),
    ),
  ];

  late AnimationController _progressController;
  late PageController _pageController;
  final Curve _animationCurve = Curves.linear;

  @override
  void initState() {
    _pageController = PageController();
    _progressController = AnimationController(
      vsync: this,
      value: 1 / pageViewItems.length,
      duration: const Duration(milliseconds: 300),
      animationBehavior: AnimationBehavior.preserve,
    );
    super.initState();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: _handlePageChange,
                      children: pageViewItems,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 10,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey,
                            ),
                            AnimatedContainer(
                              curve: _animationCurve,
                              duration: const Duration(milliseconds: 300),
                              height: 10,
                              color: Colors.blue,
                              width: MediaQuery.of(context).size.width *
                                  (_progressController.value),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () => _handlePageChange(
                                _pageController.page!.round() - 1,
                              ),
                              child: const Text("Previous"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _handlePageChange(
                                  _pageController.page!.round() + 1,
                                );
                              },
                              child: const Text("Next"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AnimatedPositioned(
                left: MediaQuery.of(context).size.width *
                    (_progressController.value - 0.1),
                top: MediaQuery.of(context).size.height * 0.72,
                duration: const Duration(milliseconds: 300),
                curve: _animationCurve,
                child: Container(
                  color: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text('car'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePageChange(int page) {
    setState(() {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: _animationCurve,
      );
      _progressController.value =
          (_pageController.page!.round() + 1) / pageViewItems.length;
      print(_pageController.page!.round());
      print(_progressController.value);
    });
  }
}

class OnboardPageViewItem extends StatelessWidget {
  const OnboardPageViewItem({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final String title;
  final List<Widget> description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(imagePath),
        ),
        Text(title),
        ...description,
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
