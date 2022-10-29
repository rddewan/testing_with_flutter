
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_sample_app/common/mixin/input_validation_mixin.dart';
import 'package:youtube_sample_app/common/widget/app_scaffold.dart';
import 'package:youtube_sample_app/common/widget/primary_button.dart';
import 'package:youtube_sample_app/common/widget/widget_key.dart';
import 'package:youtube_sample_app/core/error/failure.dart';
import 'package:youtube_sample_app/features/register/data/dto/request/register_request.dart';
import 'package:youtube_sample_app/features/register/presentation/controller/register_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> with InputValidationMixin {

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
            
                  TextFormField(
                    key: nameTextKey,
                    controller: _nameController, 
                    validator: combine(
                      [
                        withMessage('name is empty', isTextEmpty),                       
                      ]
                    ),               
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'your name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _nameController.clear();
                        }, 
                        icon: const Icon(Icons.clear),
                      ),
            
                    ),
                  ),
            
                  const SizedBox(height: 16,),
            
                  TextFormField(
                    key: emailTextKey,  
                    controller: _emailController,              
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'your email',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.email),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _emailController.clear();
                        }, 
                        icon: const Icon(Icons.clear),
                      ), 
            
                    ),
                  ),
            
                  const SizedBox(height: 16,),
            
                  TextFormField(
                    key: passwordTextKey,  
                    controller: _passwordController, 
                    obscureText: true,             
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'your password',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.security),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _passwordController.clear();
                        }, 
                        icon: const Icon(Icons.clear),
                      ), 
            
                    ),
                  ),
            
                  const SizedBox(height: 16,),
            
                  TextFormField(
                    key: confirmPasswordTextKey,   
                    controller: _passwordConfirmController,
                    obscureText: true,             
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'confirm your password',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.security),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _passwordConfirmController.clear();
                        }, 
                        icon: const Icon(Icons.clear),
                      ), 
            
                    ),
                  ),
            
                  const SizedBox(height: 16,),
            
                  CheckboxListTile(
                    title: const Text("Terms and condition"),
                    subtitle: const Text('Please accept terms and condition'),
                    value: false,
                      onChanged: (value) {
            
                      },
                  ),

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
  
}