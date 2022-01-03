import 'package:feature_oriented/app/injection_container.dart';
import 'package:feature_oriented/core/utils/constants.dart';
import 'package:feature_oriented/core/utils/theme.dart';
import 'package:feature_oriented/core/widgets/custom_snak_bar.dart';
import 'package:feature_oriented/feature/login/domain/usecases/login_user.dart';
import 'package:feature_oriented/feature/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _viewNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CustomSnackBar? _snackBar;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    _viewNode.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _snackBar =
        CustomSnackBar(key: const Key("snackbar"), scaffoldKey: _scaffoldKey);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_viewNode),
      child: Scaffold(
        key: _scaffoldKey,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: CustomColor.statusBarColor,
          ),
          child: _buildBody(context),
        ),
      ),
    );
  }

  BlocProvider<LoginCubit> _buildBody(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isKeyboardOpen = (MediaQuery.of(context).viewInsets.bottom > 0);
    return BlocProvider<LoginCubit>(
      create: (_) => sl<LoginCubit>(),
      child: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(DEFAULT_PAGE_PADDING),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildHeader(isKeyboardOpen),
              _buildEmailField(context),
              const Padding(
                padding: EdgeInsets.only(top: 12),
              ),
              _buildPasswordField(context),
              const Padding(
                padding: EdgeInsets.only(top: 14),
              ),
              SizedBox(
                width: double.infinity,
                height: 36,
                child: _buildLoginButton(),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isKeyboardOpen) {
    if (!isKeyboardOpen) {
      return Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 74),
          ),
          const SizedBox(
            width: 100,
            height: 100,
            child: Icon(
               Icons.login,
              size: 100,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Text(
            "Login",
            style: CustomTheme.mainTheme.textTheme.subtitle1,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 14),
          ),
        ],
      );
    }
    return const Padding(
      padding: EdgeInsets.only(top: 74),
    );
  }

  BlocBuilder _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prevState, currState) {
        if (currState is LoggedState) {
          _snackBar!.hideAll();
          Navigator.pushNamedAndRemoveUntil(context, HOME_ROUTE, (r) => false);
        }
        return currState is! LoggedState;
      },
      builder: (context, state) {
        if (state is NotLoggedState || state is ErrorState) {
          if (state is ErrorState) {
            _snackBar!.hideAll();
            _snackBar!.showErrorSnackBar(state.message);
          }
          return RaisedButton(
            key: const Key("login"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            color: CustomColor.logoBlue,
            onPressed: () => context.read<LoginCubit>().signInUser(
                      inputs: LoginParams(
                    email: _emailEditingController.text,
                    password: _passwordEditingController.text,
                  )),
            child: Text(
              "LOGIN",
              style: CustomTheme.mainTheme.textTheme.button,
            ),
          );
        } else if (state is LoadingState) {
          _snackBar!.hideAll();
          _snackBar!.showLoadingSnackBar();
          return Container();
        }
        return Container();
      },
    );
  }

  TextFormField _buildEmailField(BuildContext context) => TextFormField(
        focusNode: _emailNode,
        controller: _emailEditingController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: CustomColor.textFieldBackground,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: CustomColor.textFieldBackground,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: CustomColor.textFieldBackground,
            ),
          ),
          focusColor: CustomColor.hintColor,
          hoverColor: CustomColor.hintColor,
          fillColor: CustomColor.textFieldBackground,
          filled: true,
          labelText: "Email*",
          labelStyle: CustomTheme.mainTheme.textTheme.bodyText2,
        ),
        cursorColor: CustomColor.hintColor,
        onFieldSubmitted: (term) {
          _fieldFocusChange(context, _emailNode, _passwordNode);
        },
      );

  TextFormField _buildPasswordField(BuildContext context) => TextFormField(
        focusNode: _passwordNode,
        controller: _passwordEditingController,
        obscureText: _obscureText,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: CustomColor.textFieldBackground,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: CustomColor.textFieldBackground,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: CustomColor.textFieldBackground,
            ),
          ),
          focusColor: CustomColor.hintColor,
          hoverColor: CustomColor.hintColor,
          fillColor: CustomColor.textFieldBackground,
          filled: true,
          labelText: "Password*",
          labelStyle: CustomTheme.mainTheme.textTheme.bodyText2,
          suffixIcon: IconButton(
            icon: const Icon(Icons.remove_red_eye),
            color: CustomColor.hintColor,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        cursorColor: CustomColor.hintColor,
      );

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
