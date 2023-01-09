// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:watery/screens/home_screen.dart';
import 'package:watery/screens/menu.dart';
import 'package:watery/screens/water_flow.dart';

class customNavBar extends StatelessWidget {
  final int isActive;
  const customNavBar({
    this.isActive = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                isActive != 1
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()))
                    : null;
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 7,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive == 1 ? Color(0xFF323062) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.water_drop_outlined,
                    size: 25,
                    color: isActive != 1 ? Color(0xFF323062) : Colors.white),
              ),
            ),
            SizedBox(
              width: 70,
            ),
            InkWell(
              onTap: () {
                isActive != 2
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()))
                    : null;
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 7,
                height: 40,
                decoration: BoxDecoration(
                  color: isActive == 2 ? Color(0xFF323062) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.circle_outlined,
                    size: 25,
                    color: isActive != 2 ? Color(0xFF323062) : Colors.white),
              ),
            ),
            SizedBox(
              width: 70,
            ),
            InkWell(
              onTap: () {
                isActive != 3
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Menue()))
                    : null;
              },
              child: Container(
                  width: MediaQuery.of(context).size.width / 7,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isActive == 3 ? Color(0xFF323062) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.menu_outlined,
                      size: 25,
                      color: isActive != 3 ? Color(0xFF323062) : Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
