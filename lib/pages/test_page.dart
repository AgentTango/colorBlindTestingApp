// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildFormBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Personal Details"),
      centerTitle: true,
    );
  }
}

class _buildFormBody extends StatefulWidget {
  const _buildFormBody({
    Key? key,
  }) : super(key: key);

  @override
  State<_buildFormBody> createState() => _buildFormBodyState();
}

class _buildFormBodyState extends State<_buildFormBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _enableSubmitButton = false;
  var _obscureText = false;
  bool _startAutoValidation = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: _startAutoValidation?AutovalidateMode.always:AutovalidateMode.disabled,
          onChanged: () {
            setState(() {
              _enableSubmitButton = true;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  decoration: InputDecoration(labelText: "Name *"),
                  initialValue: null,
                  validator: (String? value) {
                    return (value == null||value.isEmpty) ? "Cannot be empty" : null;
                  }),
              Container(height: 16),
              TextFormField(
                  decoration: InputDecoration(labelText: "Age *"),
                  initialValue: null,
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    return (value == null||value.isEmpty) ? "Cannot be empty" : null;
                  }),
              Container(height: 16),
              TextFormField(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                initialValue: null,
                onChanged: (String? value) {
                  _formKey.currentState?.validate();
                },
                decoration: InputDecoration(labelText: "Mobile Number *"),
                keyboardType: TextInputType.number,
                maxLength: 10,
                validator: (String? value) {
                  return (value != null && value.length < 10)
                      ? "Should be 10 digits"
                      : null;
                },
              ),
              Container(height: 16),
              TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  initialValue: null,
                  decoration: InputDecoration(
                      labelText: "Password *",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(!_obscureText
                              ? Icons.visibility_off
                              : Icons.visibility))),
                  validator: (String? value) {
                    return (value == null||value.isEmpty) ? "Cannot be empty" : null;
                  }),
              Container(height: 16),

              ElevatedButton(
                  onPressed:
                      _enableSubmitButton ? () => submitButtonEvent() : null,
                  child: Text("Submit and Proceed to Test"))
            ],
          ),
        ),
      ),
    );
  }

  void submitButtonEvent() {
    _formKey.currentState?.validate();
    setState(() {
      _startAutoValidation = true;
    });
  }
}
