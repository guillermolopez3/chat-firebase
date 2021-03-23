
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  static String sharedPreferenceUserLoginKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserNameKey  = 'USERNAMEKEY';
  static String sharedPreferenceEmailKey     = 'USEREMAILKEY';

  //guardar data
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(sharedPreferenceUserLoginKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveEmailSharedPreference(String email) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceEmailKey, email);
  }

  //get data
  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(sharedPreferenceUserLoginKey)?? false;
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getEmailSharedPreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(sharedPreferenceEmailKey);
  }

}