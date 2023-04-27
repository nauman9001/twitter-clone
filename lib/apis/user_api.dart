import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter/constants/app_write_constants.dart';
import 'package:twitter/core/core.dart';
import 'package:twitter/core/provider.dart';
import 'package:appwrite/models.dart' as model;
import '../models/user_model.dart';

final userApIProvider = Provider((ref) {
  return UserAPI(db: ref.watch(appWriteDatabaseProvider));
});

abstract class IUserAPI{
FutureEitherVoid saveUsrData(UserModel userModel);
Future<model.Document>getUserData(String uid);
}

class UserAPI implements IUserAPI{
  final Databases _db;
  UserAPI({required Databases db}): _db=db;
  @override
  FutureEitherVoid saveUsrData(UserModel userModel)async {
    try{
      await _db.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.collectionId,
          documentId:userModel.uid,
          data: userModel.toMap()
      );
      return right(null);
    }on AppwriteException catch (e,st){
      return left(Failure(e.message??"Some unexpected error occured", st));
    }catch(e,st){
      left(Failure(e.toString(), st));
    }
    // TODO: implement saveUserData
    throw UnimplementedError();
  }
  @override
  Future<model.Document> getUserData(String uid) async{
    return await _db.getDocument(
      databaseId:AppWriteConstants.databaseId,
      collectionId: AppWriteConstants.collectionId,
      documentId: uid,
    );
  }
}