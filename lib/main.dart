import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
// import 'instagram.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 전역 변수로 선언
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOnboarded = prefs.getBool("isOnboarded") ?? false;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.getTextTheme('Jua'),
        ),
        // home: Instagram(),
        home: isOnboarded ? HomePage() : OnboardingPage());
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // 첫 번째 페이지
          PageViewModel(
            title: "빠른 개발",
            body: "Flutter의 hot reload는 쉽고 UI 빌드를 도와줍니다.",
            image: Padding(
              padding: EdgeInsets.all(32),
              child: Image.network('https://i.ibb.co/2ZQW3Sb/flutter.png'),
            ),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          // 두 번째 페이지
          PageViewModel(
            title: "표현력 있고 유연한 UI",
            body: "Flutter에 내장된 아름다운 위젯들로 사용자를 기쁘게 하세요.",
            image: Image.network('https://i.ibb.co/LRpT3RQ/flutter2.png'),
            decoration: PageDecoration(
              titleTextStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              bodyTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
        next: Text("Next", style: TextStyle(fontWeight: FontWeight.w600)),
        done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        onDone: () {
          prefs.setBool("isOnboarded", true);
          // When done button is press
          // Done 클릭시 페이지 이동
          // pushReplacement : 현재 있는 페이지로 교체함.
          // push 를 하면 상단 appBar를 통해서 돌아가기 가능.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                prefs.clear();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
