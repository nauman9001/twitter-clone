import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../core/failure.dart';
import '../core/provider.dart';
import '../core/type_def.dart';
import 'package:appwrite/models.dart'as model;

final authApiProvider =Provider((ref) {
  final account =ref.watch(appWriteAccountProvider);
  return AUTHAPI(account:account);
});
abstract class IAUTHAPI{
  FutureEither<model.Account> signUp({
required String email,
required String password,
});
  FutureEither<model.Session> login({
    required String email,
    required String password,
  });
  Future<model.Account?>currentUserAccount();
}


class AUTHAPI implements IAUTHAPI{
  final Account _account;
  AUTHAPI({required Account account}):_account= account;
  @override
  Future<model.Account?>currentUserAccount()async{
    try{
return await _account.get();
    } on AppwriteException catch(e){
return null;
    }catch (e){
return null;
    }
    throw UnimplementedError();

  }
  FutureEither<model.Account> signUp({
    required String email,
    required String password
  })async {
    try{
    final account =await _account.create(
         userId: ID.unique(),
         email: email,
         password: password
     );
    return right(account);
    } on AppwriteException catch(e,stackTrace){
return left(Failure(e.message??"Some unexpected Errorr occured",stackTrace));
    }catch (e,stackTrace){
      return left(Failure(e.toString(),stackTrace));
    }
    // TODO: implement signUp
    throw UnimplementedError();
  }
  FutureEither<model.Session> login({
    required String email,
    required String password
  })async {
    try{
      final session =await _account.createEmailSession(
          email: email,
          password: password
      );
      return right(session);
    } on AppwriteException catch(e,stackTrace){
      return left(Failure(e.message??"Some unexpected Errorr occured",stackTrace));
    }catch (e,stackTrace){
      return left(Failure(e.toString(),stackTrace));
    }
    // TODO: implement signUp
    throw UnimplementedError();
  }

  
}