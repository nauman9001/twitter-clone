import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/features/home/views/home_view.dart';
import '../../../apis/auth_api.dart';
import '../../../core/utils.dart';
import '../view/login.dart';
import 'package:appwrite/models.dart'as model;

final authControllerProvider = StateNotifierProvider<AuthController,bool >((ref) {
  return AuthController(authAPI: ref.watch(authApiProvider));
});
final currentUserProvider = FutureProvider((ref)  {
  final authController=ref.watch(authControllerProvider.notifier);
  return authController.currentUser() ;
});

class AuthController extends StateNotifier<bool>{
  final AUTHAPI _authAPI;
  AuthController({required AUTHAPI authAPI}):_authAPI=authAPI,super(false);

  Future<model.Account?>currentUser()=>_authAPI.currentUserAccount();
void signUp({
 required String email,
 required String password,
  required  BuildContext context,
})async{
  state=true;
  final response= await _authAPI.signUp(email: email, password: password);
  state=false;
  response.fold((l) =>showSnackBar(context,l.message), (r) {
    showSnackBar(context, "Account created! Please Login.");
    Navigator.push(context, LoginView.route());
  });
}


  void login({
    required String email,
    required String password,
    required  BuildContext context,
  })async{
    state=true;
    final response= await _authAPI.login(email: email, password: password);
    state=false;
    response.fold(
            (l) =>showSnackBar(context,l.message),
            (r) =>  Navigator.push(context, HomeView.route())
    );
  }

}