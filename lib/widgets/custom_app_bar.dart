import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final Function openDrawer;
  final Widget trailing;
  const CustomAppBar({required this.openDrawer, required this.trailing});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MenuButton(openDrawer),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/logo.png',
                height: 20,
              ),
              const SizedBox(
                width: 12,
              ),
              //Text('Drinkable',style:  GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17),)
              Text(
                'drinkable',
                style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: const Color.fromARGB(255, 0, 60, 192),
                ),
              )
            ],
          ),
          trailing == null
              ? const CircleAvatar(
                  radius: 19,
                  backgroundColor: Colors.transparent,
                )
              : trailing
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final Function onTap;
  const MenuButton(this.onTap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300],
              width: 1.1,
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 11,
              height: 2,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              width: 16,
              height: 2,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(2)),
            ),
          ],
        ),
      ),
    );
  }
}
