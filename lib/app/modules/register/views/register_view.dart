import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/assets.dart';
import '../../../core/helpers/formvalidation.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.assetsImagesLogo,
              height: 200,
            ),
            const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Welcome to Ennakl!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      validator: FormValidation.checkEmailValidation,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller: controller.passwordController,
                        validator: FormValidation.checkPwdValidation,
                        obscureText: controller.isPasswordVisible,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                        )),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controller.reenterpasswordController,
                      validator: (v) {
                        FormValidation.checkPwdValidation(v);
                        if (v != controller.passwordController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      obscureText: controller.isPasswordVisible,
                      decoration: const InputDecoration(
                        labelText: 'Reenter password',
                        hintText: 'Reenter your password',
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: controller.signUpWithEmailAndPassword,
                      child: controller.obx(
                          (s) => const Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                          onLoading: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
