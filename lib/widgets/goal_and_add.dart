import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drinkable/providers/home_provider.dart';
import 'package:drinkable/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// widgets
import './daily_amout_dial.dart';
import './daily_goal_amount.dart';
import './water_effect.dart';

class GoalAndAdd extends StatefulWidget {
  @override
  State<GoalAndAdd> createState() => _GoalAndAddState();
}

class _GoalAndAddState extends State<GoalAndAdd> {
  bool isLoading1 = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            constraints: constraints,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // WaterEffect(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Current Hydration",
                              style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF323062))),
                          SizedBox(
                            height: 50,
                          ),
                          DailyAmountDial(),
                          SizedBox(
                            height: 80,
                          ),
                          Provider.of<HomeProvider>(context, listen: false)
                                      .leftAmount <=
                                  0
                              ? SizedBox(
                                  width: 250.0,
                                  child: TextLiquidFill(
                                    text: '',
                                    waveColor: Color(0xFF8E8BFF),
                                    boxBackgroundColor: Colors.transparent,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 400.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    boxHeight: 400.0,
                                  ),
                                )
                              : isLoading1 == true
                                  ? LoaderTransparent()
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Material(
                                              elevation: 10,
                                              color: Color.fromARGB(
                                                  143, 217, 217, 255),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    isLoading1 = true;
                                                  });

                                                  DateTime _time =
                                                      DateTime.now();
                                                  await Provider.of<
                                                              HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .addWater(180, _time);
                                                  setState(() {
                                                    isLoading1 = false;
                                                  });
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          143, 217, 217, 255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Image.asset(
                                                              "assets/icons/coffe.png"),
                                                          Text(
                                                            "180 mL",
                                                            style: GoogleFonts.poppins(
                                                                color: Color(
                                                                    0xFF323062),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                            Material(
                                              elevation: 10,
                                              color: Color.fromARGB(
                                                  143, 217, 217, 255),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    isLoading1 = true;
                                                  });

                                                  DateTime _time =
                                                      DateTime.now();
                                                  await Provider.of<
                                                              HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .addWater(250, _time);
                                                  setState(() {
                                                    isLoading1 = false;
                                                  });
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          143, 217, 217, 255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Image.asset(
                                                              "assets/icons/juice.png"),
                                                          Text(
                                                            "250 mL",
                                                            style: GoogleFonts.poppins(
                                                                color: Color(
                                                                    0xFF323062),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Material(
                                              elevation: 10,
                                              color: Color.fromARGB(
                                                  143, 217, 217, 255),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    isLoading1 = true;
                                                  });

                                                  DateTime _time =
                                                      DateTime.now();
                                                  await Provider.of<
                                                              HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .addWater(250, _time);
                                                  setState(() {
                                                    isLoading1 = false;
                                                  });
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          143, 217, 217, 255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Image.asset(
                                                              "assets/icons/water.png"),
                                                          Text(
                                                            "250 mL",
                                                            style: GoogleFonts.poppins(
                                                                color: Color(
                                                                    0xFF323062),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                            Material(
                                              elevation: 10,
                                              color: Color.fromARGB(
                                                  143, 217, 217, 255),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    isLoading1 = true;
                                                  });

                                                  DateTime _time =
                                                      DateTime.now();
                                                  await Provider.of<
                                                              HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .addWater(500, _time);
                                                  setState(() {
                                                    isLoading1 = false;
                                                  });
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                    height: 70,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          143, 217, 217, 255),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Image.asset(
                                                              "assets/icons/bottle.png"),
                                                          Text(
                                                            "500 mL",
                                                            style: GoogleFonts.poppins(
                                                                color: Color(
                                                                    0xFF323062),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}

class LoaderTransparent extends StatelessWidget {
  double height;
  double width;
  Color colorValue;
  LoaderTransparent({this.colorValue});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.transparent,
        child: Center(child: CustomProgressIndicatior()),
      ),
    );
  }
}
