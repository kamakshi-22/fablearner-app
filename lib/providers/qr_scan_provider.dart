import 'dart:convert';

import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/lesson_screen/lesson_screen.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class QRScanProvider extends ChangeNotifier {
  bool _lessonScreenOpened = false;
  bool _isLoading = false;

  bool get lessonScreenOpened => _lessonScreenOpened;
  bool get isLoading => _isLoading;

  void setLessonScreenOpened(bool opened) {
    _lessonScreenOpened = opened;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> handleQRCode(String scannedResult, BuildContext context) async {
    if (_lessonScreenOpened || _isLoading) {
      return; // Return if the lesson screen is already opened or loading
    }
    setLoading(true); 
    try {
      setLoading(true); // Set loading to true when handling QR code
      Map<String, dynamic> data = json.decode(scannedResult);

      if (data.containsKey('id')) {
        int oldId = int.parse(data['id']);
        printIfDebug("Old Id : $oldId");

        String jsonString =
            await rootBundle.loadString('assets/files/mappings.json');
        List<dynamic> mappings = json.decode(jsonString);
        int newId = mappings.firstWhere(
          (m) => m['Old ID'] == oldId,
          orElse: () => {'New ID': oldId},
        )['New ID'];
        printIfDebug("New ID found: $newId");

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final String token =
            UserPreferences.getUserToken() ?? userProvider.user.token;
        final lessonProvider =
            Provider.of<LessonProvider>(context, listen: false);
        try {
          await lessonProvider.fetchLessonModel(newId, token);
          final lesson = lessonProvider.lessonModel;
          
          if(!_lessonScreenOpened){
            // Set the flag to prevent multiple screens
          setLessonScreenOpened(true);
          showSuccessToast("Lesson Found: ${lesson.name}");
          setLoading(false); // Set loading to false in case of error
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LessonScreen(
                  lesson: lesson,
                );
              },
            ),
          );
          }
          setLoading(false); // Set loading to false in case of error
        } catch (e) {
          setLoading(false); // Set loading to false in case of error
          printIfDebug("Error fetching lesson: $e");
          showErrorToast("Lesson Not Found");
        }
      } else {
        setLoading(false); // Set loading to false in case of error
        printIfDebug("No Id present");
        showErrorToast("Invalid QR Code");
      }
       setLoading(false);
    } catch (e) {
      setLoading(false); // Set loading to false in case of error
      printIfDebug("Error decoding QR Code: $e");
      showErrorToast("Invalid QR Code");
    }
  }
}

