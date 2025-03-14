import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_sugar/constants.dart';
import 'package:smart_sugar/core/helper_functions/get_random_number.dart';
import 'package:smart_sugar/features/admin_feature/domain/emergency_number_entity.dart';
import 'package:smart_sugar/features/admin_feature/domain/sugar_center_model.dart';
import 'package:smart_sugar/features/auth/domain/entity/user_entity.dart';
import 'package:http/http.dart' as http;

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
      id.toString(),
      uid,
      glucose,
      date,
      measurementTime,
      result,
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
    maxSugarReadings= readings.first.sugarRead;
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
}
