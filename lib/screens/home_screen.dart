// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors, deprecated_member_use, sort_child_properties_last, use_build_context_synchronously, avoid_print

import 'package:watery/screens/customNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/goal_and_add.dart';
import '../widgets/loading_screen.dart';

// providers
import '../providers/home_provider.dart';

// models
import '../models/app_user.dart';

// widgets
import '../widgets/custom_progress_indicator.dart';
import '../widgets/custom_form_field.dart';

class HomeScreen extends StatefulWidget {
  final Function openDrawer;
  HomeScreen(this.openDrawer);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  void toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void init() async {
    toggleLoading();
    await Provider.of<HomeProvider>(context, listen: false).init();
    toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    GoalAndAdd(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                      // child: WeatherSuggestion()
                      child: Container(
                        child: Row(children: <Widget>[]),
                      ),
                    )
                  ],
                ),
              ),
            ),

            bottomNavigationBar: customNavBar(
              isActive: 2,
            ),
            // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.centerFloat,
            // floatingActionButton: Container(
            //   height: 70,
            //   width: 70,
            //   child: FloatingActionButton(
            //       elevation: 3,
            //       backgroundColor: Colors.white,
            //       child: Icon(
            //         Icons.water_drop,
            //         size: 30,
            //         color: Color.fromARGB(255, 0, 60, 192),
            //       ),
            //       onPressed: () {
            //         //Navigator.of(context).pushNamed(AddWaterScreen.routeName);
            //         showDialog(
            //             context: context,
            //             builder: (BuildContext ctx) {
            //               return AddWaterWidget();
            //             });
            //       }),
            // ),
          );
  }
}

class AddWaterWidget extends StatefulWidget {
  @override
  _AddWaterWidgetState createState() => _AddWaterWidgetState();
}

class _AddWaterWidgetState extends State<AddWaterWidget> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // data
  DateTime _time = DateTime.now();
  late int _water;

  void toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    toggleLoading();
    try {
      await Provider.of<HomeProvider>(context, listen: false)
          .addWater(_water, _time);
      Navigator.of(context).pop();
      return;
    } catch (e) {
      print(e);
    }
    toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    AppUser appUser = Provider.of<HomeProvider>(context).appUser;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            'Add Water',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: _time,
                      firstDate: DateTime(1960),
                      lastDate: _time,
                    );
                    if (date != null && date.isBefore(DateTime.now())) {
                      setState(() {
                        _time = date;
                      });
                    }
                  },
                  child: CustomFormField(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMd('en_US').format(_time),
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  )),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '240 mL',
                      suffixText: 'mL',
                    ),
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w300),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter water amount';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Wrong value';
                      }
                      if (double.parse(value) > appUser.dailyTarget) {
                        return 'Daily limit exceed';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _water = int.parse(value!);
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      actions: <Widget>[
        FlatButton(
          textColor: Color.fromARGB(255, 0, 60, 192),
          child: Text('Cancel',
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          color: Color.fromARGB(255, 0, 60, 192),
          child: _loading
              ? SizedBox(
                  height: 22, width: 22, child: CustomProgressIndicatior())
              : Text('Add',
                  style: GoogleFonts.poppins(
                      fontSize: 13, fontWeight: FontWeight.w300)),
          onPressed: submit,
        ),
      ],
    );
  }
}
