import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainFormScreen extends StatefulWidget {
  const MainFormScreen({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MainFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Form Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              child: Text(
                'Where do you want to explore next?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child:
                    SvgPicture.asset('assets/images/undraw_map_re_60yf.svg')),
            Expanded(
              flex: 2,
              child: Form(
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
                    // const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter date';
                        }
                        return null;
                      },
                    ),
                    // const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _startTimeController,
                            decoration: const InputDecoration(
                              labelText: 'Start Time',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter start time';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _endTimeController,
                            decoration: const InputDecoration(
                              labelText: 'End Time',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter end time';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // form is valid, do something here
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
