import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:front/main.dart';
import 'package:front/providers/datetime_provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:front/constants.dart';
import 'package:front/screens/map_screen.dart';
import 'package:front/services/place_api_service.dart';
import 'dart:io';

class MainFormScreen extends StatefulWidget {
  const MainFormScreen({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MainFormScreen> {
  final Cookie cookie = Cookie('device', const Uuid().v4());
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system
              // navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Form Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Consumer(builder: (context, ref, child) {
          return ListView(
            children: [
              const Text(
                'Where do you want to explore next?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(
                      'assets/images/undraw_map_re_60yf.svg',
                      height: 300)),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _destinationController,
                      decoration: const InputDecoration(
                        labelText: 'Destination',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter destination';
                        }
                        return null;
                      },
                    ),
                    Platform.isAndroid
                        ? TextFormField(
                            controller: _dateController,
                            readOnly: true,
                            decoration:
                                const InputDecoration(labelText: 'Date'),
                            onTap: () async {
                              DateTime? pickedDate =
                                  await showPlatformDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now()
                                          .subtract(const Duration(seconds: 1)),
                                      lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  _dateController.text = formattedDate;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          )
                        : CupertinoTextFormFieldRow(
                            controller: _dateController,
                            prefix: const Text('Date'),
                            readOnly: true,
                            placeholder: 'Year/Month/Day',
                            onTap: () async {
                              _showDialog(CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (DateTime value) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd').format(value);
                                  setState(() {
                                    _dateController.text = formattedDate;
                                  });
                                },
                                initialDateTime: DateTime.now(),
                                minimumDate: DateTime.now()
                                    .subtract(const Duration(seconds: 1)),
                                maximumYear: 2100,
                              ));
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 15.0),
                        Expanded(
                            flex: 1,
                            child: Platform.isAndroid
                                ? TextFormField(
                                    controller: _startTimeController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                        labelText: 'Start Time'),
                                    onTap: () async {
                                      TimeOfDay? pickedStartTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (pickedStartTime != null) {
                                        String formattedTime =
                                            '${pickedStartTime.hour.toString().padLeft(2, '0')}:${pickedStartTime.minute.toString().padLeft(2, '0')}';
                                        setState(() {
                                          _startTimeController.text =
                                              formattedTime;
                                        });
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                  )
                                : CupertinoTextFormFieldRow(
                                    controller: _startTimeController,
                                    readOnly: true,
                                    prefix: const Text('Start Time'),
                                    placeholder: 'HH:MM',
                                    textAlign: TextAlign.center,
                                    onTap: () async {
                                      _showDialog(CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
                                        use24hFormat: true,
                                        onDateTimeChanged: (DateTime value) {
                                          String formattedTime =
                                              DateFormat.Hm().format(value);
                                          setState(() {
                                            _startTimeController.text =
                                                formattedTime;
                                          });
                                        },
                                        initialDateTime: DateTime.now(),
                                      ));
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                  )),
                        const SizedBox(width: 10.0),
                        Expanded(
                            flex: 1,
                            child: Platform.isAndroid
                                ? TextFormField(
                                    controller: _endTimeController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                        labelText: 'End Time',
                                        hintText: 'HH:MM'),
                                    onTap: () async {
                                      TimeOfDay? pickedEndTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now());
                                      if (pickedEndTime != null) {
                                        String formattedTime =
                                            '${pickedEndTime.hour.toString().padLeft(2, '0')}:${pickedEndTime.minute.toString().padLeft(2, '0')}';
                                        setState(() {
                                          _endTimeController.text =
                                              formattedTime;
                                        });
                                      }
                                    },
                                    validator: (value) {
                                      if (_startTimeController.text != "" &&
                                          _endTimeController.text != "") {
                                        if (DateFormat('HH:mm')
                                            .parse(_startTimeController.text)
                                            .isAfter(DateFormat('HH:mm').parse(
                                                _endTimeController.text))) {
                                          return 'End Time must be after Start Time';
                                        }
                                      } else if (value == null ||
                                          value.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                  )
                                : CupertinoTextFormFieldRow(
                                    controller: _endTimeController,
                                    readOnly: true,
                                    prefix: const Text('End Time'),
                                    placeholder: 'HH:MM',
                                    textAlign: TextAlign.center,
                                    onTap: () async {
                                      _showDialog(CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.time,
                                          use24hFormat: true,
                                          onDateTimeChanged: (DateTime value) {
                                            String formattedTime =
                                                DateFormat.Hm().format(value);
                                            setState(() {
                                              _endTimeController.text =
                                                  formattedTime;
                                            });
                                          },
                                          initialDateTime: DateTime.now()));
                                    },
                                    validator: (value) {
                                      if (_startTimeController.text != "" &&
                                          _endTimeController.text != "") {
                                        if (DateFormat('HH:mm')
                                            .parse(_startTimeController.text)
                                            .isAfter(DateFormat('HH:mm').parse(
                                                _endTimeController.text))) {
                                          return 'End Time must be after Start Time';
                                        }
                                      } else if (value == null ||
                                          value.isEmpty) {
                                        return 'Required';
                                      }
                                      return null;
                                    },
                                  )),
                        const SizedBox(width: 15.0),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .watch(itineraryNotifierProvider)
                                .updateItinerary(
                                    _dateController.text,
                                    _startTimeController.text,
                                    _endTimeController.text);
                            print(ref.read(itineraryNotifierProvider).date);
                            print(
                                ref.read(itineraryNotifierProvider).startTime);
                            print(ref.read(itineraryNotifierProvider).endTime);
                            final latlng = await getLocationFromText(
                                _destinationController.text, apiKey);
                            final touristAttractions =
                                await getNearbyPlaces(latlng, apiKey);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapSample(
                                    latlng: latlng,
                                    touristAttractions: touristAttractions),
                              ),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
