import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_store_app/bloc/authentication/auth_bloc.dart';
import 'package:flutter_store_app/bloc/authentication/auth_event.dart';
import 'package:flutter_store_app/bloc/authentication/auth_state.dart';
import 'package:flutter_store_app/screens/dashboard_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordConfirmTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ViewContainer(
        usernameTextController: _usernameTextController,
        passwordTextController: _passwordTextController,
        passwordConfirmTextController: _passwordConfirmTextController,
      ),
    );
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameTextController,
    required TextEditingController passwordTextController,
    required TextEditingController passwordConfirmTextController,
  })  : _usernameTextController = usernameTextController,
        _passwordTextController = passwordTextController,
        _passwordConfirmTextController = passwordConfirmTextController;

  final TextEditingController _usernameTextController;
  final TextEditingController _passwordTextController;
  final TextEditingController _passwordConfirmTextController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 150.0),
                const Text(
                  'ثبت نام',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SB',
                  ),
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نام کاربری',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SM',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        color: Colors.grey[300],
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          controller: _usernameTextController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'رمز عبور',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SM',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        color: Colors.grey[300],
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordTextController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'تکرار رمز عبور',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SM',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        color: Colors.grey[300],
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordConfirmTextController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthResponseState) {
                      state.response.fold((l) {
                        _usernameTextController.text = '';
                        _passwordTextController.text = '';
                        _passwordConfirmTextController.text = '';
                        var snackbar = SnackBar(
                          content: Text(
                            l,
                            style: const TextStyle(
                              fontFamily: 'sm',
                              fontSize: 14,
                            ),
                          ),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }, (r) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const DashBoardScreen(),
                        ));
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthInitiateState) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          minimumSize: const Size(200, 48),
                          textStyle:
                              const TextStyle(fontFamily: 'sb', fontSize: 18),
                        ),
                        child: const Text('ساخت حساب کاربری'),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthRegisterRequest(
                            _usernameTextController.text,
                            _passwordTextController.text,
                            _passwordConfirmTextController.text,
                          ));
                        },
                      );
                    }

                    if (state is AuthLoadingState) {
                      return const CircularProgressIndicator();
                    }

                    if (state is AuthResponseState) {
                      Widget widget = const Text('');
                      state.response.fold((l) {
                        widget = ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            minimumSize: const Size(200, 48),
                            textStyle:
                                const TextStyle(fontFamily: 'sb', fontSize: 18),
                          ),
                          child: const Text('ساخت حساب کاربری'),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthRegisterRequest(
                              _usernameTextController.text,
                              _passwordTextController.text,
                              _passwordConfirmTextController.text,
                            ));
                          },
                        );
                      }, (r) {
                        widget = Text(r);
                      });
                      return widget;
                    }

                    return const Text('خطای نامشخص');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
