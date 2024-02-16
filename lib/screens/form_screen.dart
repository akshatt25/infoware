import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infoware/bloc/auth_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../constants/global_variables.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class FormScreen extends StatefulWidget {
  static const String routeName = '/signin';
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<FormScreen> {
  bool isLoading = false;
  final _signinFormKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String selectedGender = 'none';
  String selectedCountry = 'none';
  String selectedState = 'none';
  String selectedCity = 'none';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 85,
            surfaceTintColor: Colors.white,
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            elevation: 0,
            title: Text(
              'Form',
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              //it listens and does wht we want to do for the state
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Name',
                      ),
                      const SizedBox(height: 25),
                      CustomTextField(
                        hidden: true,
                        controller: emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 25),
                      CustomTextField(
                        hidden: true,
                        controller: phoneController,
                        hintText: 'Phone',
                      ),
                      SizedBox(height: 25),

                      // Gender Selection
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'male',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Male'),
                                SizedBox(
                                  width: 25,
                                ),
                                Radio<String>(
                                  value: 'female',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Female'),
                                SizedBox(
                                  width: 25,
                                ),
                                Radio<String>(
                                  value: 'other',
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value!;
                                    });
                                  },
                                ),
                                Text('Other'),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: CSCPicker(
                          disabledDropdownDecoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.grey, width: 0.75)),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.grey, width: 0.75)),
                          dropdownDialogRadius: 15,
                          flagState: CountryFlag.DISABLE,
                          layout: Layout.vertical,
                          onCountryChanged: (country) {
                            selectedCountry = country;
                          },
                          onStateChanged: (state) {
                            if (state != null) {
                              selectedState = state;
                            }
                          },
                          onCityChanged: (city) {
                            if (city != null) {
                              selectedCity = city;
                            }
                          },
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      CustomButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthSubmitPressed(
                              gender: selectedGender,
                              country: selectedCountry,
                              state: selectedState,
                              city: selectedCity));
                          if (_signinFormKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                        },
                        text: "Submit",
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        isLoading
            ? Container(
                alignment: Alignment.center,
                color: GlobalVariables.load,
                child: LoadingAnimationWidget.flickr(
                  size: 50,
                  leftDotColor: Colors.blue,
                  rightDotColor: Color.fromARGB(255, 177, 206, 252),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
