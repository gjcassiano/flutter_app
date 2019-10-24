import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:m_perfeito/home/home.view.dart';
import 'package:m_perfeito/main.dart';

class LoginController {
    
    GoogleSignIn _googleSignIn;
    
    // constructor
    LoginController() {
        // set email scope for authentication
        _googleSignIn = GoogleSignIn(scopes: <String>['email']);
    }
    
    Future<bool> isLogged() async {
        return _googleSignIn.isSignedIn();
    }
    
    goToHome(context) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'Match Perfeito')),
        );
    }
    
    // try to login and move user to home page
    void login(context) {
        _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
            _googleSignIn.signInSilently();
            goToHome(context);
        });
        
        _googleSignIn.signIn();
    }
    
    void logout() {
        _googleSignIn.disconnect();
    }
    
    get getProfilePictureUrl => _googleSignIn.currentUser.photoUrl;
    
    void checkLoginAndDoAction(context) {
        
        isLogged().then((logged) => {
            if (!logged) {
                login(context)
            } else {
                goToHome(context)
            }
        });
    }
}
