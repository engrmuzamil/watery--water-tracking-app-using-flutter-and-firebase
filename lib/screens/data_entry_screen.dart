// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, use_build_context_synchronously, empty_catches, unnecessary_null_comparison, prefer_if_null_operators, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

// providers
import '../providers/auth_provider.dart';

// utils
import '../utils/time_converter.dart';

// widgets
import '../widgets/custom_form_field.dart';
import '../widgets/custom_progress_indicator.dart';

class DataEntryScreen extends StatelessWidget {
  static const routeName = 'data-entry-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'About you',
                        style: GoogleFonts.poppins(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        constraints: BoxConstraints(maxWidth: 270),
                        child: Text(
                          'This information will let us help to calculate your daily recommended water intake amount and remind you to drink water in intervals.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.60),
                              height: 1.4,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DataEntryForm(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataEntryForm extends StatefulWidget {
  @override
  _DataEntryFormState createState() => _DataEntryFormState();
}

class _DataEntryFormState extends State<DataEntryForm> {
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  // data
  String _gender = 'male';
  DateTime _birthday = DateTime(1997, 4, 1);
  double _weight = 80.0;
  TimeOfDay _wakeUpTime = TimeOfDay(hour: 8, minute: 0);
  int _water = 3200;
  bool isLoading1 = false;
  void submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    toggleLoading();
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .signUp(_gender, _birthday, _weight, _wakeUpTime, _water);
      Navigator.of(context).pop();
      return;
    } catch (e) {}
    isLoading1 = false;
    setState(() {});
  }

  void setWater({required double weight}) {
    if (_weight != null || weight != null) {
      double calWater = weight != null ? weight * 2.205 : _weight * 2.205;
      calWater = calWater / 2.2;
      int age = DateTime.now().year - _birthday.year;
      if (age < 30) {
        calWater = calWater * 40;
      } else if (age >= 30 && age <= 55) {
        calWater = calWater * 35;
      } else {
        calWater = calWater * 30;
      }
      calWater = calWater / 28.3;
      calWater = calWater * 29.574;
      setState(() {
        _water = calWater.toInt();
        _weight = weight == null ? _weight : weight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading1 == true
        ? Container(child: Center(child: CustomProgressIndicatior()))
        : Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomFormField(
                  child: DropdownButtonFormField<String>(
                    value: _gender,
                    iconEnabledColor: Color(0xFF323062),
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem(
                        child: Text(
                          'Male',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        value: 'male',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Female',
                          style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        value: 'female',
                      ),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 14, right: 4),
                        child: Container(
                          height: 15,
                          width: 15,
                          child: Icon(
                            _gender == "male" ? Icons.male : Icons.female,
                            size: 25,
                            color: Color(0xFF323062),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (String? gender) {
                      setState(() {
                        _gender = gender!;
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: _birthday,
                      firstDate: DateTime(1960),
                      lastDate: DateTime(DateTime.now().year - 12, 12, 31),
                    );
                    if (date != null) {
                      setState(() {
                        _birthday = date;
                      });
                      setWater(weight: 0);
                    }
                  },
                  child: CustomFormField(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 14, right: 10, left: 8),
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.date_range,
                                size: 30,
                                color: Color(0xFF323062),
                              ),
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd('en_US').format(_birthday),
                            style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF323062),
                      )
                    ],
                  )),
                ),
                CustomFormField(
                  child: TextFormField(
                    initialValue: _weight.toString(),
                    style: GoogleFonts.poppins(
                      color: Color(0xFF323062),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '60 kg',
                      suffixText: 'kg',
                      suffixStyle: GoogleFonts.poppins(
                        color: Color(0xFF323062),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 14, right: 4),
                        child: Container(
                          height: 15,
                          width: 15,
                          child: Image.asset(
                            "assets/icons/weight.png",
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter weight';
                      }
                      if (double.parse(value) < 40) {
                        return 'You are underweight';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setWater(weight: double.parse(value));
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 8, minute: 0),
                    );
                    if (time != null) {
                      setState(() {
                        _wakeUpTime = time;
                      });
                    }
                  },
                  child: CustomFormField(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 14, right: 10, left: 8),
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                "assets/icons/wakeup.png",
                                height: 25,
                                width: 25,
                              ),
                            ),
                          ),
                          Text(
                            timeConverter(_wakeUpTime),
                            style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_drop_down, color: Color(0xFF323062))
                    ],
                  )),
                ),
                CustomFormField(
                  child: TextFormField(
                    initialValue: _water.toString(),
                    style: GoogleFonts.poppins(
                      color: Color(0xFF323062),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '3200 mL',
                      suffixText: 'mL',
                      suffixStyle: GoogleFonts.poppins(
                        color: Color(0xFF323062),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 14, right: 4),
                        child: Container(
                          height: 15,
                          width: 15,
                          child: Icon(
                            Icons.water_drop_outlined,
                            size: 25,
                            color: Color(0xFF323062),
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter water amount';
                      }
                      if (double.parse(value) < 1600) {
                        return 'Less than min water';
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        try {
                          _water = int.parse(value);
                        } catch (ex) {}
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Material(
                    elevation: 25,
                    color: Color(0xFF323062),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        isLoading1 = true;
                        setState(() {});
                        submit();
                        SnackBar snackBar = SnackBar(
                          content: Text(
                            'Profile Added successfully',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF323062),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          duration: Duration(seconds: 2),
                        );

                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color(0xFF323062),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          "Submit",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
