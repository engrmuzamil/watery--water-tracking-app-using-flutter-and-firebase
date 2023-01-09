import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// providers
import '../providers/auth_provider.dart';
import '../providers/statistics_provider.dart';

// models
import '../models/weekly_data.dart';

// widgets
import '../widgets/custom_app_bar.dart';
import '../widgets/weekly_statistics_graph.dart';
import '../widgets/custom_progress_indicator.dart';
import '../widgets/three_layer_background.dart';

class StatisticsScreen extends StatefulWidget {
  final Function openDrawer;
  StatisticsScreen({this.openDrawer});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void init() async {
    toggleLoading();
    await Provider.of<StatisticsProvider>(context, listen: false).init();
    toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: _loading
            ? Center(
                child: CustomProgressIndicatior(),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
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
                            "Statistics",
                            style: GoogleFonts.poppins(
                                color: Color(0xFF323062),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          // ignore: sized_box_for_whitespace
                          Container(
                            width: 48,
                            height: 48,
                          )
                        ],
                      ),
                    ),
                    //SizedBox(height: 30,),
                    Expanded(
                      child: Stack(
                        children: [
                          Consumer<StatisticsProvider>(
                            builder: (context, statisticsProvider, child) {
                              List<WeeklyData> weeklyData =
                                  statisticsProvider.weeklyData;
                              return ListView.separated(
                                padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
                                itemCount: weeklyData.length,
                                itemBuilder: (context, index) {
                                  return WeeklyStatisticsGraph(
                                      weeklyData[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 20,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
