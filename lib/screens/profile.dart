import 'package:drinkable/models/app_user.dart';
import 'package:drinkable/providers/auth_provider.dart';
import 'package:drinkable/providers/home_provider.dart';
import 'package:drinkable/screens/profile_edit.dart';
import 'package:drinkable/utils/time_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

AppUser myGlobalAppUser;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 254,
              decoration: const BoxDecoration(
                color: Color.fromARGB(8, 217, 217, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          // ignore: sized_box_for_whitespace
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 25,
                                  color: Color(0xFF323062),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Profile",
                          style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        // ignore: sized_box_for_whitespace
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileEdit(
                                          appUser: myGlobalAppUser,
                                        )));
                          },
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Icon(
                                Icons.edit,
                                size: 25,
                                color: Color(0xFF323062),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height / 4,
                child: Consumer<HomeProvider>(
                    builder: (context, homeProvider, child) {
                  AppUser appUser = homeProvider.appUser;
                  myGlobalAppUser = appUser;
                  return Container(
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 65.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                  appUser.name != null
                                      ? appUser.name ?? ""
                                      : "",
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF323062),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                appUser.email != null
                                    ? appUser.email ?? ""
                                    : "",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF323062),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomContainer(
                                childWidget: CustomFieldDisplay(
                                  displayWidget: Icon(
                                    appUser.gender == "male"
                                        ? Icons.male
                                        : Icons.female,
                                    size: 25,
                                    color: Color(0xFF323062),
                                  ),
                                  text: appUser.gender != null
                                      ? appUser.gender.toUpperCase() ?? ""
                                      : "",
                                ),
                              ),
                              CustomContainer(
                                childWidget: CustomFieldDisplay(
                                  displayWidget: const Icon(
                                    Icons.date_range,
                                    size: 25,
                                    color: Color(0xFF323062),
                                  ),
                                  text: appUser.birthday != null
                                      ? DateFormat.yMMMd('en_US')
                                              .format(appUser.birthday) ??
                                          ""
                                      : "",
                                ),
                              ),
                              CustomContainer(
                                childWidget: CustomFieldDisplay(
                                  displayWidget: Image.asset(
                                    "assets/icons/weight.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  text: appUser.weight != null
                                      ? appUser.weight.toString() + " KG" ?? ""
                                      : "",
                                ),
                              ),
                              CustomContainer(
                                childWidget: CustomFieldDisplay(
                                  displayWidget: Image.asset(
                                    "assets/icons/wakeup.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  text: appUser.wakeUpTime != null
                                      ? timeConverter(appUser.wakeUpTime)
                                              .toString() ??
                                          ""
                                      : "",
                                ),
                              ),
                              CustomContainer(
                                childWidget: CustomFieldDisplay(
                                  displayWidget: const Icon(
                                    Icons.water_drop_outlined,
                                    size: 25,
                                    color: Color(0xFF323062),
                                  ),
                                  text: appUser.dailyTarget != null
                                      ? appUser.dailyTarget.toString() +
                                              " mL" ??
                                          ""
                                      : "",
                                ),
                              ),
                              const SizedBox(height: 200),
                            ],
                          ),
                        ),
                      ));
                })),
            Positioned(
                top: MediaQuery.of(context).size.height / 6,
                left: MediaQuery.of(context).size.width / 2 - 60,
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      User user = authProvider.user;
                      return CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color(0xFFF5F5F5),
                          foregroundColor: const Color(0xFFF5F5F5),
                          child: CircleAvatar(
                              radius: 56,
                              backgroundImage: NetworkImage((user.photoURL))));
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final childWidget;
  const CustomContainer({
    this.childWidget,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Material(
        elevation: 3,
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        child: Container(
            width: MediaQuery.of(context).size.width / 1.20,
            height: 53,
            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8)),
            child: childWidget),
      ),
    );
  }
}

class CustomFieldDisplay extends StatelessWidget {
  final displayWidget;
  final String text;
  const CustomFieldDisplay({
    this.displayWidget,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        displayWidget,
        Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: 53,
            padding: EdgeInsets.only(top: 15),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  color: Color(0xFF323062),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            )),
      ],
    );
  }
}
