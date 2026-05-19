import 'package:bloc_todo_app/configs/routes.dart';
import 'package:bloc_todo_app/data/network/api_status.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';
import '../../configs/app_colors.dart';
import '../../configs/app_textstyles.dart';
import '../../configs/assets.dart';
import '../../utils/mixins/validator_mixins.dart';
import '../../utils/responsive_util.dart';
import '../../configs/route_names.dart';
import '../../utils/navigation_utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginView> with ValidatorMixin {
  // late final LoginController controller;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1Color,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 114.h),
                    // Hero(
                    //   tag:'tag',
                    //
                    //   child: Image.asset(
                    //     Assets.darkLogo,
                    //     width: 61.w,
                    //     height: 55.h,
                    //   ),
                    // ),
                    // SvgPicture.asset('assets/images/Icons.svg',width:61.w,height:55.h),
                    SizedBox(height: 15.h),
                    Text('Sign In', style: AppTextStyles.m500black24),
                    SizedBox(height: 5.h),
                    Text(
                      'Hi Welcome back, you’ve been missed',
                      style: AppTextStyles.r400grey12,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 20.w, top: 5.h),
                      child: Text(
                        "Email",
                        style: AppTextStyles.m400black14.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.email != current.email,
                      builder: (context, state) {
                        print('Email Build');
                        return Container(
                          // height: 59.h,
                          constraints: BoxConstraints(minHeight: 59.h),
                          // color: Colors.red,
                          child: CustomTextField(
                            hintText: 'example@gmail.com',
                            // contentPadding: EdgeInsets.symmetric(vertical:18.h,horizontal: 15.w),
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            onChanged: (e) {
                              context.read<LoginBloc>().add(
                                UpdateEmailEvent(e.trim()),
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              } else if (emailValidator(value) != null) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 20.w, top: 5.h),
                      child: Text(
                        "Password",
                        style: AppTextStyles.m400black14.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.password != current.password ||
                          previous.isPasswordHidden != current.isPasswordHidden,
                      builder: (context, state) {
                        print('Pass Build');
                        return Container(
                          // height: 59.h,
                          constraints: BoxConstraints(minHeight: 59.h),
                          child: CustomTextField(
                            hintText: '********',
                            controller: passwordController,
                            obscureText: state.isPasswordHidden,
                            // contentPadding: EdgeInsets.symmetric(vertical:15.h,horizontal: 15.w),
                            onChanged: (e) {
                              context.read<LoginBloc>().add(
                                UpdatePasswordEvent(e.trim()),
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              /*else if(emailValidator(value)!=null){
                              return 'Please enter a valid email';
                            }*/
                              return null;
                            },
                            suffixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0.w,
                                vertical: 12.0.h,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // controller.togglePass();
                                  context.read<LoginBloc>().add(
                                    TogglePasswordEvent(),
                                  );
                                },
                                child: (state.isPasswordHidden)
                                    ? SvgPicture.asset(Assets.eyeCloseIcon)
                                    : SvgPicture.asset(Assets.eyeOpenIcon),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // NavigationUtils.navigateTOAnimationRightToLeft(ForgotPasswordScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.only(
                            top: 5.h,
                            bottom: 15.h,
                            left: 20.w,
                          ),
                          child: Text(
                            "forgot password?",
                            style: AppTextStyles.m500black10.copyWith(
                              fontFamily: 'POP-R',
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BlocListener<LoginBloc, LoginState>(
                      listenWhen: (previous, current) =>
                          previous.apiStatus != current.apiStatus,
                      listener: (context, state) {
                        print('State in Listener ${state.apiStatus}');
                        if (state.apiStatus == ApiStatus.loading) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        } else if (state.apiStatus == ApiStatus.error) {
                          NavigationUtils.popDialog();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.apiMessage.isEmpty
                                    ? 'Login failed'
                                    : state.apiMessage,
                              ),
                            ),
                          );
                        } else if (state.apiStatus == ApiStatus.success) {
                          NavigationUtils.popDialog();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.apiMessage.isEmpty
                                    ? 'Login Successfully'
                                    : state.apiMessage,
                              ),
                            ),
                          );
                          NavigationUtils.navigateTOAnimationRightToLeft(
                            context: context,
                            page: RouteNames.homeScreen,
                          );
                        }
                      },
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return CustomButton(
                            height: 59.h,
                            // enabled: !controller.isLoading.value,
                            onPress: () {
                              // controller.signIn();
                              if (_formKey.currentState!.validate()) {
                                // controller.signIn();
                                context.read<LoginBloc>().add(LoginApiEvent());
                              }
                            },
                            title: 'Sign In',
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 7.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
