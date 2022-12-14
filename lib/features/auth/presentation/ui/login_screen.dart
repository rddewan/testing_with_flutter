
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_sample_app/common/mixin/input_validation_mixin.dart';
import 'package:youtube_sample_app/common/widget/app_scaffold.dart';
import 'package:youtube_sample_app/common/widget/form/custom_text_form_field.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/features/auth/data/dto/request/login/login_request.dart';
import 'package:youtube_sample_app/features/auth/presentation/ui/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with InputValidationMixin{
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  

  @override
  void initState() {    
    super.initState();
    
  }

  @override
  void dispose() {  
    _emailController.dispose();
    _passwordController.dispose(); 
   
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: const Text('Login'), 
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Login'),
            
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
                              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Expanded(
                        key: btnLoginKey,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            _login();                      
                          }, 
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
            
                  const SizedBox(height: 16,),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,                 
                    children: [
                      const Text("Don't have a account?"),
                      const SizedBox(width: 8,),
                      GestureDetector(
                        onTap: () => GoRouter.of(context).go('/login/register'),
                        child: const Text(
                          "Register Now!",
                          key: registerNowTextKey,
                        ),
                      ),
            
                    ],
                  )
            
                  
            
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _login() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final request = LoginRequest(email: _emailController.text, password: _passwordController.text);
      ref.read(authControllerProvider.notifier).login(request);
    }
    
  }
}