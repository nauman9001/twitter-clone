import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/apis/user_api.dart';
import 'package:twitter/features/home/views/home_view.dart';
import 'package:twitter/models/user_model.dart';
import '../../../apis/auth_api.dart';
import '../../../core/utils.dart';
import '../view/login.dart';
import 'package:appwrite/models.dart'as model;

final authControllerProvider = StateNotifierProvider<AuthController,bool >((ref) {
  return AuthController(
      authAPI: ref.watch(authApiProvider),
      userAPI: ref.watch(userApIProvider)
  );
});

final currentUserDetailsProvider = FutureProvider((ref) {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
//  print(currentUserId);
  final usersDetails = ref.watch(userDetailsProvider(currentUserId));
 print("${usersDetails.value?.name}=====================");

  return usersDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});



class AuthController extends StateNotifier<bool>{
  final AUTHAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AUTHAPI authAPI,required UserAPI userAPI})
      :_authAPI=authAPI,
        _userAPI=userAPI,
        super(false);

  Future<model.Account?>currentUser()=>_authAPI.currentUserAccount();
void signUp({
 required String email,
 required String password,
  required  BuildContext context,
})async{
  state=true;
  final response= await _authAPI.signUp(email: email, password: password);
  state=false;

  response.fold(
          (l) =>showSnackBar(context,l.message),
          (r) async{
            UserModel userModel=UserModel(
                email: email,
                name: getNameFromEmail(email),
                followers: const [],
                following: const [],
                profilePic: '',
                bannerPic: '',
                uid:r.$id,
                bio: '',
                isTwitterBlue: false
            );
           final response2= await _userAPI.saveUsrData(userModel);
           response2.fold(
                   (l) =>showSnackBar(context,l.message) ,
                   (r){
                     showSnackBar(context, "Account created! Please Login.");
                     Navigator.push(context, LoginView.route());
                   });

  });
}

  Future<UserModel> getData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    final updatedUser = UserModel.fromMap(document.data);
    print(updatedUser.email);
    return updatedUser;
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