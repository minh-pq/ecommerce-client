import 'package:ecommerce/components/custom_suffix_icon.dart';
import 'package:ecommerce/components/default_button.dart';
import 'package:ecommerce/components/form_error.dart';
import 'package:ecommerce/components/no_account.dart';
import 'package:ecommerce/size_config.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot password",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(24),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
              ),
              const ForgotPassForm()
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  List<String> errors = [];
  late String email;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) => {email = newValue!},
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (value.isNotEmpty & errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty & !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: const InputDecoration(
                hintText: "Enter your email",
                labelText: "Email",
                suffixIcon:
                    CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg")),
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          FormError(errors: errors),
          DefaultButton(
              text: "Continue",
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              }),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          const NoAccountText()
        ],
      ),
    );
  }
}
