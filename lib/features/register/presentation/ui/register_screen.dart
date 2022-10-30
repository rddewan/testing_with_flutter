
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/common/mixin/input_validation_mixin.dart';
import 'package:youtube_sample_app/common/widget/app_scaffold.dart';
import 'package:youtube_sample_app/common/widget/dialog/confirm_dialog.dart';
import 'package:youtube_sample_app/common/widget/form/custom_text_form_field.dart';
import 'package:youtube_sample_app/common/widget/primary_button.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/core/route/go_router_provider.dart';
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';
import 'package:youtube_sample_app/features/register/presentation/controller/register_controller.dart';
import 'package:youtube_sample_app/features/register/presentation/ui/widget/check_box_widget.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> with InputValidationMixin, ConfirmDialog {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listenStateChange();
    final registerState = ref.watch(registerControllerProvider).isRegistered;
        
    return AppScaffold(
      title: const Text('Register'), 
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Register'),
                  registerState.when(
                    data: (data)  {
                      return data ? const Text('Register successful') : const SizedBox.shrink();
                                          },
                    error: (error, stackTrace) {
                      final e  = error as Failure;
                      return Text(e.message);
                      
                    },
                    loading: () => const CircularProgressIndicator.adaptive(),
                  ),
            
                  const SizedBox(height: 16,),
                  CustomTextFormField(
                    textFieldKey: nameTextKey,
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    prefixIcon: const Icon(Icons.person),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _nameController.clear();
                      }, 
                      icon: const Icon(Icons.clear),
                    ), 
                    passwordConfirmController: _nameController,
                    validator: combine(
                      [
                        withMessage('name is empty', isTextEmpty),                       
                      ]
                    ),
                  ),            
                              
                  const SizedBox(height: 16,),
                  CustomTextFormField(
                    textFieldKey: emailTextKey,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _emailController.clear();
                      }, 
                      icon: const Icon(Icons.clear),
                    ), 
                    passwordConfirmController: _emailController,
                    validator: combine([
                      withMessage('email is empty', isTextEmpty),
                      withMessage('email is invalid', isInvalidEmail)
                    ]),
                  ),            
                  
                  const SizedBox(height: 16,),
                  CustomTextFormField(
                    textFieldKey: passwordTextKey,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    isObscureText: true,
                    prefixIcon: const Icon(Icons.security),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _passwordController.clear();
                      }, 
                      icon: const Icon(Icons.clear),
                    ), 
                    passwordConfirmController: _passwordController,
                    validator: combine([
                      withMessage('password is empty', isTextEmpty),
                      withMessage('password is invalid', isPasswordInvalid)
                    ]),
                  ),            
                              
                  const SizedBox(height: 16,),
            
                  CustomTextFormField(
                    textFieldKey: confirmPasswordTextKey,
                    labelText: 'Confirm Password',
                    hintText: 'Enter your confirm password',
                    prefixIcon: const Icon(Icons.security),
                    isObscureText: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        _passwordConfirmController.clear();
                      }, 
                      icon: const Icon(Icons.clear),
                    ), 
                    passwordConfirmController: _passwordConfirmController,
                    validator: combine([                      
                      withMessage('password is empty', isTextEmpty),
                      withMessage('password is invalid', isPasswordInvalid),
                      withMessage(
                        'Password did not match', 
                        (confirmPassword) {
                          final password = _passwordController.text;
                          if (confirmPassword != password) {
                            return ValidateFailResult.passwordNotMatch;
                          }
                          return null;
                        })
                    ]),
                  ),
            
                  const SizedBox(height: 16,),

                  Consumer(builder: ((context, ref, child) {
                    final isChecked = ref.watch(registerControllerProvider.select(
                        (value) => value.isTermsAndCondition,),
                      );
                    
                    return CheckboxWidget(
                      title: 'Terms and condition', 
                      subtitle: 'Please accept terms and condition',
                      value: isChecked,
                      validator: (value) {
                        return isValidTermsAndConditions(
                          value,
                          'Please accept terms and conditions',
                        );
                      },
                      onChanged: (value) {
                        ref.read(registerControllerProvider.notifier)                        
                          .setTermsAndCondition(value ?? false);
                      },
                    );

                  }),),           
                  

                  const SizedBox(height: 16,),

                  PrimaryButton(
                    key: btnRegisterKey,
                    text: 'Register',
                    isLoading: registerState.isLoading,
                    isEnabled: true,
                    onPressed: () {
                      _register();                        
                    },
                  ),            
                          
                  const SizedBox(height: 16,),          
                          
            
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _register() {
    final isValid = _formKey.currentState?.validate();
    if(isValid != null && isValid) {
      final request = RegisterRequest(
        _nameController.text, 
        _emailController.text, 
        _passwordController.text, 
        _passwordConfirmController.text,
      );

      ref.read(registerControllerProvider.notifier).register(request);
    }

  }

  void listenStateChange() {
    ref.listen<bool?>(registerControllerProvider.select((value) => value.isRegistered.value), (p, next) { 
      if(next != null && next) {
        showConfirmDialog(
          context: context,
          title: 'Do you want to login?',
          msg: 'You will be redirected to login screen',
          btnNoText: 'No',
          btnYesText: 'Yes',
          onYesTap: () {
            final navigator = Navigator.of(context,rootNavigator: true);
            if (navigator.canPop()) {
              navigator.pop();
              ref.read(goRouterProvider).go('login');
            }
            
          },
          onNoTap: () {
            final navigator = Navigator.of(context,rootNavigator: true);
            if (navigator.canPop()) {
              navigator.pop();
            }
          },
        );     

      }
    });
  }
  
}

