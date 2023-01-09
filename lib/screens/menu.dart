import 'package:watery/providers/auth_provider.dart';
import 'package:watery/screens/customNavBar.dart';
import 'package:watery/screens/profile.dart';
import 'package:watery/screens/scatistics_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Menue extends StatefulWidget {
  const Menue({Key? key}) : super(key: key);

  @override
  State<Menue> createState() => _MenueState();
}

class _MenueState extends State<Menue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        child: ListView(
          children: [
            Consumer<AuthProvider>(builder: (context, value, child) {
              User user = value.user;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(user.photoURL),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back!",
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF323062),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                user.displayName,
                                style: GoogleFonts.poppins(
                                    color: Color(0xFF323062),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ))
                    ],
                  )
                ],
              );
            }),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 2,
              color: Color.fromARGB(143, 217, 217, 255),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StatisticsScreen()));
              },
              child: CustomListTile(
                title: "Statistics",
                icon: Icons.bar_chart_sharp,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              child: CustomListTile(
                title: "Profile",
                icon: Icons.person,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              child: CustomListTile(
                title: "Logout",
                icon: Icons.logout,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: customNavBar(
        isActive: 3,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  CustomListTile({
    Key key,
    this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          title,
          style: GoogleFonts.poppins(
              color: Color(0xFF323062),
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Color.fromARGB(143, 217, 217, 255),
          child: Icon(
            icon,
            size: 25,
            color: Color(0xFF323062),
          ),
        ));
  }
}
