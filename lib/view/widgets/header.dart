import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../controller/login_controller.dart';
import '../screens/login_screen.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    String displayName = GetStorage().read('displayName');
    List<String> nameList = displayName.split(" ");
    List<String> firstTwoName = nameList.sublist(0, 2);
    String splitedName = "${firstTwoName[0]} ${firstTwoName[1]}";

    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Morning';
      }
      if (hour < 17) {
        return 'Afternoon';
      }
      return 'Evening';
    }

    Widget leading = GetStorage().read('imageUrl') != null
        ? CircleAvatar(
            radius: 23.5,
            backgroundImage: NetworkImage(
              GetStorage().read('imageUrl'),
            ),
          )
        : randomAvatar(GetStorage().read('displayName'), height: 45, width: 45);
    return ListTile(
      leading: leading,
      subtitle: Text(
        "Hello, Good ${greeting()}",
        style: GoogleFonts.anaheim(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
          ),
        ),
      ),
      title: Text(
        splitedName,
        style: GoogleFonts.anaheim(
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await LoginController().logout();
          Get.deleteAll();
          Get.to(
            () => const LoginScreen(),
          );
        },
        icon: Icon(
          Icons.logout,
          size: 20.sp,
        ),
        color: Colors.white,
      ),
    );
  }
}
