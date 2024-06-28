import 'package:applicationpfe/app/core/helpers/formvalidation.dart';
import 'package:applicationpfe/app/routes/app_pages.dart';
import 'package:applicationpfe/constants/assets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/siginin_controller.dart';

class SigininView extends GetView<SigininController> {
  const SigininView({super.key});
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Welcome to Ennakl!",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
              ),
            ),
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
                    GetBuilder<SigininController>(
                        id: 'password',
                        builder: (_) {
                          return TextFormField(
                            controller: controller.passwordController,
                            validator: FormValidation.checkPwdValidation,
                            obscureText: controller.isPasswordVisible,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                prefixIcon:
                                    const Icon(Icons.lock_outline_rounded),
                                suffixIcon: IconButton(
                                  icon: Icon(controller.isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                )),
                          );
                        }),
                    const SizedBox(height: 10),
                    GetBuilder<SigininController>(
                        id: 'rememberMe',
                        builder: (_) {
                          return CheckboxListTile(
                            value: controller.rememberMe,
                            onChanged: controller.toggleRememberMe,
                            title: const Text('Remember me'),
                            controlAffinity: ListTileControlAffinity.leading,
                            dense: true,
                            contentPadding: const EdgeInsets.all(0),
                          );
                        }),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: controller.signInWithEmailAndPassword,
                      child: controller.obx(
                          (s) => const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                          onLoading: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                        onPressed: () => Get.offNamed(Routes.REGISTER),
                        child: const Text("Register"))
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
