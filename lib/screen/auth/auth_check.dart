// import 'package:flutter/material.dart';
// import 'package:lichvannien/screen/login/login_screen.dart';
// import 'package:lichvannien/screen/login/register_screen.dart';

// class AuthCheck extends StatefulWidget {
//   const AuthCheck({super.key});

//   @override
//   State<AuthCheck> createState() => _AuthCheckState();
// }

// class _AuthCheckState extends State<AuthCheck> {
//   bool showLoginScreen = true;

//   void toggleScreen() {
//     setState(() {
//       showLoginScreen = !showLoginScreen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (showLoginScreen) {
//       return LoginScreen(showRegisterScreen: toggleScreen);
//     } else {
//       return RegisterScreen(showLoginScreen: toggleScreen);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lichvannien/screen/login/login_screen.dart';
import 'package:lichvannien/screen/user_sceen/user_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          // Kiểm tra trạng thái đăng nhập khi ứng dụng khởi động
          future: FirebaseAuth.instance.authStateChanges().first,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Nếu đang chờ kiểm tra, hiển thị một tiêu đề hoặc biểu tượng tải
              return CircularProgressIndicator();
            } else {
              // Nếu đã có kết quả kiểm tra
              if (snapshot.hasData) {
                // Người dùng đã đăng nhập, chuyển hướng đến màn hình người dùng
                return UserScreen();
              } else {
                // Người dùng chưa đăng nhập, chuyển hướng đến màn hình đăng nhập
                return LoginScreen();
              }
            }
          },
        ),
      ),
    );
  }
}