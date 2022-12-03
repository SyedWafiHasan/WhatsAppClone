import 'package:firebase_storage/firebase_storage.dart';

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase() async {
    UploadTask uploadTask = firebaseStorage.ref().child(path);
  }
}
