import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Phone Field Example')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                const SizedBox(height: 10),
                IntlPhoneField(
                  initialValue: "7012345678",
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  },
                ),
                const SizedBox(height: 10),
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number with Custom Dialog Style',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                  languageCode: "en",
                  pickerDialogStyle: PickerDialogStyle(
                    backgroundColor: Colors.blueGrey[900],
                    searchFieldStyle: const TextStyle(color: Colors.white, fontSize: 16),
                    searchFieldInputDecoration: const InputDecoration(
                      labelText: 'Search country',
                      labelStyle: TextStyle(color: Colors.white70),
                      suffixIcon: Icon(Icons.search, color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white38)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    searchFieldCursorColor: Colors.white,
                    countryCodeStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    countryNameStyle: const TextStyle(color: Colors.white70),
                  ),
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  },
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    _formKey.currentState?.validate();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
