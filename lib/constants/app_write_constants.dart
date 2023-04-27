class AppWriteConstants{
  static const String databaseId='6434f70f7a46973517a6';
  static const String projectId='6433b45daefd47bc8814';
  static const String endPoint='http://172.16.10.100:80/v1';
  static const String collectionId='644787c063db8dd2403f';
  static const String tweetscollectionId='643e4ecade6a6ec79646';
  static const String imagesBucket='644a1fd354dc0e87ce88';
  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}