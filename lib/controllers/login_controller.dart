import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>['email']);
  var currentUser = Rx<GoogleSignInAccount?>(null);

  initializeController() {
    googleSignIn.signInSilently();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account){
      currentUser.value = account;
    });
  }

  signIn() async{
    currentUser.value = await googleSignIn.signIn();
  }

  signOut() async{
    await googleSignIn.disconnect();
  }

}