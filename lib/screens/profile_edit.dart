// ignore_for_file: deprecated_member_use

import 'package:drinkable/models/app_user.dart';
import 'package:drinkable/providers/auth_provider.dart';
import 'package:drinkable/providers/home_provider.dart';
import 'package:drinkable/utils/time_converter.dart';
import 'package:drinkable/widgets/custom_form_field.dart';
import 'package:drinkable/widgets/custom_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  final AppUser appUser;
  const ProfileEdit({Key key, @required this.appUser}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  TextEditingController _textEditingController;
  bool isLoading1 = false;
  AppUser _appUser;
  bool _loading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _appUser = AppUser.fromDoc(widget.appUser.toDoc());
    _textEditingController =
        TextEditingController(text: _appUser.dailyTarget.toString());
  }

  void toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  void submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<HomeProvider>(context, listen: false)
          .updateUser(_appUser);
    } catch (e) {
      print(e);
    }
    isLoading1 = false;
    setState(() {});
  }

  void setWater({double weight}) {
    if (_appUser.weight != null || weight != null) {
      double calWater =
          weight != null ? weight * 2.205 : _appUser.weight * 2.205;
      calWater = calWater / 2.2;
      int age = DateTime.now().year - _appUser.birthday.year;
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
        _appUser.dailyTarget = calWater.toInt();
        _appUser.weight = weight == null ? _appUser.weight : weight;
        _textEditingController.text = _appUser.dailyTarget.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading1 == false
            ? SizedBox(
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
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                  "Edit Profile",
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
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height / 4,
                        child: Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) {
                          AppUser appUser = homeProvider.appUser;
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
                                      Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomFormField(
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: _appUser.gender,
                                                iconEnabledColor:
                                                    Color(0xFF323062),
                                                items: <
                                                    DropdownMenuItem<String>>[
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      'Male',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Color(
                                                                  0xFF323062),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    value: 'male',
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text(
                                                      'Female',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Color(
                                                                  0xFF323062),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    value: 'female',
                                                  ),
                                                ],
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 14,
                                                            right: 4),
                                                    child: Container(
                                                      height: 15,
                                                      width: 15,
                                                      child: Icon(
                                                        _appUser.gender ==
                                                                "male"
                                                            ? Icons.male
                                                            : Icons.female,
                                                        size: 25,
                                                        color:
                                                            Color(0xFF323062),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onChanged: (String gender) {
                                                  setState(() {
                                                    _appUser.gender = gender;
                                                  });
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                DateTime date =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                      _appUser.birthday,
                                                  firstDate: DateTime(1960),
                                                  lastDate: DateTime(
                                                      DateTime.now().year - 12,
                                                      12,
                                                      31),
                                                );
                                                if (date != null) {
                                                  setState(() {
                                                    _appUser.birthday = date;
                                                  });
                                                  setWater();
                                                }
                                              },
                                              child: CustomFormField(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 14,
                                                                right: 10,
                                                                left: 8),
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          child: Icon(
                                                            Icons.date_range,
                                                            size: 30,
                                                            color: Color(
                                                                0xFF323062),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat.yMMMd(
                                                                'en_US')
                                                            .format(_appUser
                                                                .birthday),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF323062),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                                initialValue:
                                                    _appUser.weight.toString(),
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF323062),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '60 kg',
                                                  suffixText: 'kg',
                                                  suffixStyle:
                                                      GoogleFonts.poppins(
                                                    color: Color(0xFF323062),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 14,
                                                            right: 4),
                                                    child: Container(
                                                      height: 15,
                                                      width: 15,
                                                      child: Image.asset(
                                                        "assets/icons/weight.png",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Enter weight';
                                                  }
                                                  if (double.parse(value) <
                                                      40) {
                                                    return 'You are underweight';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (String value) {
                                                  setWater(
                                                      weight:
                                                          double.parse(value));
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                TimeOfDay time =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour: 8, minute: 0),
                                                );
                                                if (time != null) {
                                                  setState(() {
                                                    _appUser.wakeUpTime = time;
                                                  });
                                                }
                                              },
                                              child: CustomFormField(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8.0,
                                                                bottom: 14,
                                                                right: 10,
                                                                left: 8),
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
                                                        timeConverter(_appUser
                                                            .wakeUpTime),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF323062),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_drop_down,
                                                      color: Color(0xFF323062))
                                                ],
                                              )),
                                            ),
                                            CustomFormField(
                                              child: TextFormField(
                                                controller:
                                                    _textEditingController,
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xFF323062),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '3200 mL',
                                                  suffixText: 'mL',
                                                  suffixStyle:
                                                      GoogleFonts.poppins(
                                                    color: Color(0xFF323062),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 14,
                                                            right: 4),
                                                    child: Container(
                                                      height: 15,
                                                      width: 15,
                                                      child: Icon(
                                                        Icons
                                                            .water_drop_outlined,
                                                        size: 25,
                                                        color:
                                                            Color(0xFF323062),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Enter water amount';
                                                  }
                                                  if (double.parse(value) <
                                                      1600) {
                                                    return 'Less than min water';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (String value) {
                                                  setState(() {
                                                    try {
                                                      _appUser.dailyTarget =
                                                          int.parse(value);
                                                    } catch (ex) {}
                                                  });
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 20),
                                              child: Material(
                                                elevation: 25,
                                                color: Color(0xFF323062),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: InkWell(
                                                  onTap: () {
                                                    isLoading1 = true;
                                                    setState(() {});
                                                    submit();
                                                    SnackBar snackBar =
                                                        SnackBar(
                                                      content: Text(
                                                        'Profile updated successfully',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color:
                                                              Color(0xFF323062),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                      duration:
                                                          Duration(seconds: 2),
                                                    );

                                                    Scaffold.of(context)
                                                        .showSnackBar(snackBar);
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF323062),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                        child: Text(
                                                      "Update Profile",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 300),
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
                                      backgroundImage:
                                          NetworkImage((user.photoURL))));
                            },
                          ),
                        )),
                  ],
                ),
              )
            : Container(child: Center(child: CustomProgressIndicatior())));
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
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF7E7E7E)),
            )),
      ],
    );
  }
}
