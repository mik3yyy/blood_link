import 'package:hive_flutter/adapters.dart';

class HiveFunction {
  static var KiaSupBox = Hive.box('kiasup');
  static void insertToken(String token) {
    KiaSupBox.put("token", token);
  }

  static String getToken() {
    return KiaSupBox.get("token");
  }

  static void deleteToken() {
    KiaSupBox.delete("token");
  }

  static bool tokenExist() {
    return KiaSupBox.get("token") != null;
  }

  /////////CAT and TRade
  static void insertTrade(String trade) {
    KiaSupBox.put("trade", trade);
  }

  static String getTrade() {
    return KiaSupBox.get("trade") ?? "";
  }

  static void deleteTrade() {
    KiaSupBox.delete("trade");
  }

  static void insertCategory(String cat) {
    KiaSupBox.put("category", cat);
  }

  static String getCategory() {
    return KiaSupBox.get("category") ?? "";
  }

  static void deleteCategory() {
    KiaSupBox.delete("category");
  }

  /////////////////DESCRIPTION
  static void insertDescription(String dec) {
    KiaSupBox.put("description", dec);
  }

  static String getDescription() {
    return KiaSupBox.get("description") ?? "";
  }

  static void deleteDescription() {
    KiaSupBox.delete("description");
  }

  /////////////////Rate
  static void insertRate(String r) {
    KiaSupBox.put("rate", r);
  }

  static String getRate() {
    return KiaSupBox.get("rate") ?? "";
  }

  static void deleteRate() {
    KiaSupBox.delete("rate");
  }

  //////////////////////////////
  ///EDUCATION
  static void saveEducation(List<Map<String, dynamic>> education) {
    KiaSupBox.put("educations", education);
  }

  static List<Map<String, dynamic>> getEducationss() {
    List<dynamic> edu = KiaSupBox.get("educations") ?? [];
    List<Map<String, dynamic>> educations = [];
    edu.forEach((element) {
      Map<dynamic, dynamic> e = element;

      Map<String, dynamic> stringQueryParameters =
          Map.fromEntries(e.entries.map((entry) {
        return MapEntry(entry.key.toString(), entry.value);
      }));

      educations.add(stringQueryParameters);
    });

    return educations;
  }

  static void deleteEducations() {
    KiaSupBox.delete("educations");
  }

  ////////LEVEL
  static void saveLevel(String level) {
    KiaSupBox.put("level", level);
  }

  static String getLevel() {
    return KiaSupBox.get("level") ?? "";
  }

  static void deleteLevel() {
    KiaSupBox.delete("level");
  }

  /////////////////////////////
  ///EXPERIENCE
  static void saveExperience(List<Map<String, dynamic>> experience) {
    KiaSupBox.put("experience", experience);
  }

  static List<Map<String, dynamic>> getExperience() {
    List<dynamic> exp = KiaSupBox.get("experience") ?? [];
    List<Map<String, dynamic>> experience = [];
    exp.forEach((element) {
      Map<dynamic, dynamic> e = element;

      Map<String, dynamic> stringQueryParameters =
          Map.fromEntries(e.entries.map((entry) {
        return MapEntry(entry.key.toString(), entry.value);
      }));

      experience.add(stringQueryParameters);
    });

    return experience;
  }

  static void deleteExperience() {
    KiaSupBox.delete("experience");
  }

  ////////////////////
  ///Certificate
  static void saveCertificate(List<Map<String, dynamic>> certificates) {
    KiaSupBox.put("certificates", certificates);
  }

  static List<Map<String, dynamic>> getCertificate() {
    List<dynamic> cetificate = KiaSupBox.get("certificates") ?? [];
    List<Map<String, dynamic>> certificates = [];
    cetificate.forEach((element) {
      Map<dynamic, dynamic> e = element;

      Map<String, dynamic> stringQueryParameters =
          Map.fromEntries(e.entries.map((entry) {
        return MapEntry(entry.key.toString(), entry.value);
      }));

      certificates.add(stringQueryParameters);
    });

    return certificates;
  }

  static void deleteCertificate() {
    KiaSupBox.delete("certificates");
  }

  ////////////////RECENT SEARCH
  static void addRecent(String search) {
    List<dynamic> recents = KiaSupBox.get("recent") ?? [];
    String se = '';
    se = recents.firstWhere(
      (element) => element == search,
      orElse: () => "",
    );

    if (se.isEmpty) {
      recents.add(search);
      KiaSupBox.put("recent", recents);
    }
  }

  static List<dynamic> getRecent() {
    return KiaSupBox.get("recent") ?? [];
  }

  static void deleteRecent() {
    KiaSupBox.delete("recent");
  }

  static void addSingleNotifiation(Map<String, dynamic> notification) {
    List<Map<String, dynamic>> notifications = getNotification();
    notifications.add(notification);
    KiaSupBox.put("notifications", notifications);
    print("saved");
  }

  static List<Map<String, dynamic>> getNotification() {
    List<dynamic> add = KiaSupBox.get("notifications") ?? [];
    List<Map<String, dynamic>> adds = [];
    add.forEach((element) {
      Map<dynamic, dynamic> e = element;

      Map<String, dynamic> stringQueryParameters = Map.fromEntries(e.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      adds.add(stringQueryParameters);
    });

    return adds;
  }

  /////////////////////
  static void DELETEALL() {
    deleteToken();
    deleteCategory();
    deleteCertificate();
    deleteDescription();
    deleteEducations();
    deleteExperience();
    deleteLevel();
    deleteRate();
    deleteTrade();
    deleteRecent();
  }

  static void DELETEALLXTOKEN() {
    deleteToken();
    deleteCategory();
    deleteCertificate();
    deleteDescription();
    deleteEducations();
    deleteExperience();
    deleteLevel();
    deleteRate();
    deleteTrade();
    deleteRecent();
  }
}
