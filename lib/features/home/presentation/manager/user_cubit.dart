import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_sugar/constants.dart';
import 'package:smart_sugar/core/helper_functions/get_random_number.dart';
import 'package:smart_sugar/core/services/local_notification_services.dart';
import 'package:smart_sugar/features/admin_feature/domain/emergency_number_entity.dart';
import 'package:smart_sugar/features/admin_feature/domain/sugar_center_model.dart';
import 'package:smart_sugar/features/auth/domain/entity/user_entity.dart';
import 'package:http/http.dart' as http;
import 'package:smart_sugar/features/chat/domain/message_entity.dart';
import 'package:smart_sugar/features/home/domain/notification_entity.dart';
import 'package:smart_sugar/features/profile/domain/entity/medication_reminder.dart';

import '../../../../core/helper_functions/current_time.dart';
import '../../../../core/helper_functions/get_next_time.dart';
import '../../../profile/domain/entity/article_entity.dart';
import '../../domain/sugar_read_entity.dart';
import '../view/widgets/line_chart_widget.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);

  UserEntity? userEntity;
  getUser(String uid) {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection(usersCollection).doc(uid).get().then(
      (value) {
        userEntity = UserEntity.fromMap(value.data()!);
        emit(GetUserSuccessState());
      },
    ).catchError((e) {
      emit(GetUserErrorState());
    });
  }

  addGlucoseRead(int glucose, String date, String measurementTime,
      String result, String uid) {
    emit(AddGlucoseReadLoadingState());
    int id = getRandomNumber();
    SugarReadEntity sugarReadEntity = SugarReadEntity(
      id.toString(), uid, glucose, date, measurementTime, result,
    );
    FirebaseFirestore.instance
        .collection(sugarReadCollection)
        .doc(id.toString())
        .set(sugarReadEntity.toJson())
        .then((value) {
      emit(AddGlucoseReadSuccessState());
    }).catchError((e) {
      emit(AddGlucoseReadErrorState());
    });
  }

  List<SugarReadEntity> sugarReadList = [];
  getSugarRead(String uid) {
    emit(GetSugarReadLoadingState());
    FirebaseFirestore.instance
        .collection(sugarReadCollection)
        .get()
        .then((value) {
      sugarReadList = [];
      for (var element in value.docs) {
        if (element.data()['userId'] == uid) {
          sugarReadList.add(SugarReadEntity.fromJson(element.data()));
        }
      }
      emit(GetSugarReadSuccessState(sugarReadList));
    }).catchError((e) {
      emit(GetSugarReadErrorState());
    });
  }

  List<ArticleEntity> articleList = [];
  getAllArticles() {
    emit(GetArticlesLoadingState());
    FirebaseFirestore.instance
        .collection(articleCollection)
        .get()
        .then((value) {
      articleList = [];
      for (var element in value.docs) {
        articleList.add(ArticleEntity.formMap(element.data()));
      }
      emit(GetArticlesSuccessState());
    }).catchError((e) {
      emit(GetArticlesErrorState());
    });
  }

  void evaluateBloodSugar(double value, String type) {
    emit(EvaluateBloodSugarLoadingState());
    if (type == "Fasting sugar (8-12 fast)") {
      if (value < 70) {
        emit(EvaluateBloodSugarSuccessState("Low"));
        return;
      }
      if (value >= 70 && value <= 99) {
        emit(EvaluateBloodSugarSuccessState("Normal"));
        return;
      }
      if (value >= 100 && value <= 125) {
        emit(EvaluateBloodSugarSuccessState("High"));
        return;
      }
      emit(EvaluateBloodSugarSuccessState("Very high"));
      return;
    } else if (type == "Two hours after eating") {
      if (value < 90) {
        emit(EvaluateBloodSugarSuccessState("Low"));
        return;
      }
      if (value < 140) {
        emit(EvaluateBloodSugarSuccessState("Normal"));
        return;
      }
      if (value >= 140 && value <= 199) {
        emit(EvaluateBloodSugarSuccessState("High"));
        return;
      }
      emit(EvaluateBloodSugarSuccessState("Very high"));
      return;
    } else if (type == "Random time (when needed)" ||
        type == "Before sleep" ||
        type == "After exercise") {
      if (value < 70) {
        emit(EvaluateBloodSugarSuccessState("Low"));
        return;
      }
      if (value >= 70 && value <= 140) {
        emit(EvaluateBloodSugarSuccessState("Normal"));
        return;
      }
      if (value >= 140 && value <= 199) {
        emit(EvaluateBloodSugarSuccessState("High"));
        return;
      }
      emit(EvaluateBloodSugarSuccessState("Very high"));
      return;
    } else {
      emit(EvaluateBloodSugarErrorState("Invalid reading type"));
      return;
    }
  }

  SugarReadEntity? lastReading;
  int maxSugarReadings = 0;
  int minSugarReadings = 0;
  double averageSugarReadings = 0;
  double timeInRange = 0;
  void analyzeSugarReadings(List<SugarReadEntity> readings) {
    emit(AnalyzeSugarReadLoadingState());
    if (readings.isEmpty) {
      emit(AnalyzeSugarReadErrorState());
      return;
    }
    readings.sort((a, b) => b.date.compareTo(a.date));
    lastReading = readings.first;

    double sumSugar = 0;
    minSugarReadings = readings.first.sugarRead;
    maxSugarReadings = readings.first.sugarRead;
    int inRangeCount = 0;

    for (var reading in readings) {
      int sugar = reading.sugarRead;
      sumSugar += sugar;
      if (sugar < minSugarReadings) minSugarReadings = sugar;
      if (sugar > maxSugarReadings) maxSugarReadings = sugar;
      if (sugar >= 70 && sugar <= 140) inRangeCount++;
    }

    averageSugarReadings = sumSugar / readings.length;
    timeInRange = (inRangeCount / readings.length) * 100;

    emit(AnalyzeSugarReadSuccessState());
  }

  List<SugarCenterModel> sugarCenterList = [];
  getAllSugarCenter() {
    emit(GetSugarCenterLoadingState());
    FirebaseFirestore.instance
        .collection(sugarCenterCollection)
        .get()
        .then((value) {
      sugarCenterList = [];
      for (var element in value.docs) {
        sugarCenterList.add(SugarCenterModel.fromJson(element.data()));
      }
      emit(GetSugarCenterSuccessState());
    }).catchError((e) {
      emit(GetSugarCenterErrorState());
    });
  }

  List<EmergencyNumberEntity> emergencyNumberList = [];
  getAllEmergencyNumber() {
    emit(GetEmergencyNumberLoadingState());
    FirebaseFirestore.instance
        .collection(emergencyCollection)
        .get()
        .then((value) {
      emergencyNumberList = [];
      for (var element in value.docs) {
        emergencyNumberList.add(EmergencyNumberEntity.fromJson(element.data()));
      }
      emit(GetEmergencyNumberSuccessState());
    }).catchError((e) {
      emit(GetEmergencyNumberErrorState());
    });
  }

  addSugarCenterToMyList(SugarCenterModel sugarCenter) {
    emit(AddSugarCenterToMyListLoadingState());
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userEntity!.uid)
        .collection(sugarCenterCollection)
        .doc(sugarCenter.id)
        .set(sugarCenter.toJson())
        .then((value) {
      emit(AddSugarCenterToMyListSuccessState());
    }).catchError((e) {
      emit(AddSugarCenterToMyListErrorState());
    });
  }

  List<SugarCenterModel> mySugarCenterList = [];
  getMySugarCenter() {
    emit(GetMySugarCenterLoadingState());
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userEntity!.uid)
        .collection(sugarCenterCollection)
        .get()
        .then((value) {
      mySugarCenterList = [];
      for (var element in value.docs) {
        mySugarCenterList.add(SugarCenterModel.fromJson(element.data()));
      }
      emit(GetMySugarCenterSuccessState());
    }).catchError((e) {
      emit(GetMySugarCenterErrorState());
    });
  }

  File? pikedImage;
  var picker = ImagePicker();
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pikedImage = File(pickedFile.path);
      emit(PikImageSuccessState());
    } else {
      emit(PikImageErrorState());
    }
  }

  Future<String?> uploadImageToCloudinary(File imageFile) async {
    var request = http.MultipartRequest("POST", Uri.parse(cloudinaryImageUrl));
    request.fields['upload_preset'] = uploadPreset;
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var jsonResponseString = String.fromCharCodes(responseData);
    var jsonMap = jsonDecode(jsonResponseString);
    pikedImage = null;
    return jsonMap['url'];
  }

  editUserProfile(String uid, String name, String height, String weight,
      File? image, String dateOfBirth) async {
    emit(EditUserProfileLoadingState());
    String? imageUrl = '';
    if (image != null) {
      imageUrl = await uploadImageToCloudinary(image);
    }
    UserEntity user = UserEntity(
      uid: uid,
      name: name,
      height: height,
      weight: weight,
      image: imageUrl,
      fcmToken: userEntity!.fcmToken,
      email: userEntity!.email,
      dateOfBirth: dateOfBirth,
      gender: userEntity!.gender,
      diabetesType: userEntity!.diabetesType,
      therapyType: userEntity!.therapyType,
      glucoseHighValue: userEntity!.glucoseHighValue,
      glucoseLowValue: userEntity!.glucoseLowValue,
      insulinValue: userEntity!.insulinValue,
    );
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uid)
        .update(user.toMap())
        .then((value) {
      emit(EditUserProfileSuccessState());
    }).catchError((e) {
      emit(EditUserProfileErrorState());
    });
  }

  List<ChartData> chartData = [];
  void getChartData(List<SugarReadEntity> readings) {
    emit(GetChartDataLoadingState());

    chartData = List.generate(
      readings.length >= 3 ? 3 : readings.length,
      (index) {
        var reading = readings[readings.length - 1 - index];
        return ChartData(
          DateTime.parse(reading.date),
          reading.sugarRead.toDouble(),
        );
      },
    );
    emit(GetChartDataSuccessState());
  }

  String? apiLink;
  Future<void> getApiLink() async {
    emit(GetApiLinkLoadingState());
    FirebaseFirestore.instance
        .collection(apiCollection)
        .doc('1')
        .get()
        .then((value) {
      apiLink = value.data()!['apiLink'];
      emit(GetApiLinkSuccessState());
    }).catchError((e) {
      emit(GetApiLinkErrorState());
    });
  }

  String aiResponse = '';
  List<MessageModel> messages = [];
  chatWithAI(String message) async {
    emit(ChatWithAILoadingState());
    String cuTime1 = currentTime();
    messages.add(MessageModel(text: message, dateTime: cuTime1, isGPT: false,));
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"message": message});
    var dio = Dio();
    var response = await dio.request('$apiLink/DiabetesChat',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    String cuTime2 = currentTime();
    if (response.statusCode == 200) {
      aiResponse = json.encode(response.data['response']);
      String cuTime2 = currentTime();
      String res2;
      res2 = aiResponse.replaceAll("\\n", "\n").replaceAll(RegExp(r'\n\s*\n'), '\n').replaceAllMapped(RegExp(r'^\s*\*', multiLine: true), (match) => "•").replaceAll('\n', '\n').replaceAll(RegExp(r'\s+'), ' ').replaceAll(RegExp(r'[\\"]'), '').trim(); //
      messages.add(MessageModel(text: res2, dateTime: cuTime2, isGPT: true,));
      emit(ChatWithAISuccessState());
    } else {
      messages.add(MessageModel(text: 'Something went wrong', dateTime: cuTime2, isGPT: true,
      ));
      emit(ChatWithAIErrorState());
    }
  }

  addMedicationReminder(String title, String time, String diagnose, String uid,
      List<String> days, DateTime date) async {
    emit(AddMedicationReminderLoadingState());
    int reminderId = getRandomNumber();
    MedicationReminder reminder = MedicationReminder(
      userId: uid,
      date: date,
      id: reminderId.toString(),
      name: title,
      dosage: diagnose,
      time: time,
      days: days,
    );
    var random = Random();
    for (var day in days) {
      int id = random.nextInt((pow(2, 31) - 1).toInt());
      DateTime dateTime = getNextScheduledDateTime(time, day);
      await addNotification(uid, title, diagnose, dateTime, time, day);
      await LocalNotificationServices.scheduleNotification(
          id,
          title,
          diagnose,
          dateTime);
    }
    FirebaseFirestore.instance
        .collection(medicationsCollection)
        .doc(reminderId.toString())
        .set(reminder.toJson())
        .then((value) {
      emit(AddMedicationReminderSuccessState());
    }).catchError((e) {
      emit(AddMedicationReminderErrorState());
    });
  }

  updateMedicationStatus(String id, bool status) async {
    emit(UpdateMedicationStatusLoadingState());

    FirebaseFirestore.instance
        .collection(medicationsCollection)
        .doc(id)
        .update({'isActive': status}).then((value) {
      emit(UpdateMedicationStatusSuccessState());
    }).catchError((e) {
      emit(UpdateMedicationStatusErrorState());
    });
  }

  removeMedicationReminder(String id) async {
    emit(RemoveMedicationReminderLoadingState());
    FirebaseFirestore.instance
        .collection(medicationsCollection)
        .doc(id)
        .delete()
        .then((value) {
      emit(RemoveMedicationReminderSuccessState());
    }).catchError((e) {
      emit(RemoveMedicationReminderErrorState());
    });
  }

  List<MedicationReminder> medicationReminders = [];
  getMedicationReminders(String uid) async {
    emit(GetMedicationRemindersLoadingState());
    FirebaseFirestore.instance
        .collection(medicationsCollection)
        .where('userId', isEqualTo: uid)
        .get()
        .then((value) {
      medicationReminders =
          value.docs.map((e) => MedicationReminder.fromJson(e.data())).toList();
      emit(GetMedicationRemindersSuccessState());
    }).catchError((e) {
      emit(GetMedicationRemindersErrorState());
    });
  }

  addNotification(String uid, String title, String body, DateTime dateTime,
      String time, String day) async {
    emit(AddNotificationLoadingState());
    int id = getRandomNumber();
    NotificationEntity notification = NotificationEntity(
        userId: uid,
        id: id.toString(),
        title: title,
        body: body,
        date: dateTime,
        time: time,
        day: day);
    FirebaseFirestore.instance
        .collection(notificationCollection)
        .doc(id.toString())
        .set(notification.toJson())
        .then((value) {
      emit(AddNotificationSuccessState());
    }).catchError((e) {
      emit(AddNotificationErrorState());
    });
  }

  List<NotificationEntity> notifications = [];
  List<NotificationEntity> allNotifications = [];
  getNotifications(String uid) async {
    notifications = [];
    allNotifications = [];
    emit(GetNotificationsLoadingState());
    FirebaseFirestore.instance
        .collection(notificationCollection)
        .where('userId', isEqualTo: uid)
        .get()
        .then((value) {
      allNotifications = value.docs.map((e) {
        NotificationEntity notification = NotificationEntity.fromJson(e.data());
        return notification;
      }).toList();
      notifications = removeFutureNotifications(allNotifications);
      emit(GetNotificationsSuccessState());
    }).catchError((e) {
      emit(GetNotificationsErrorState());
    });
  }

  updateNotificationStatus(String uid, bool status) async {
    emit(UpdateNotificationStatusLoadingState());
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uid)
        .update({'fcmToken': status}).then((value) {
      emit(UpdateNotificationStatusSuccessState());
    }).catchError((e) {
      emit(UpdateNotificationStatusErrorState());
    });
  }

  List<NotificationEntity> removeFutureNotifications(List<NotificationEntity> notifications) {
    DateTime now = DateTime.now();
    return notifications.where((notification) => notification.date.isBefore(now)).toList();
  }

}
