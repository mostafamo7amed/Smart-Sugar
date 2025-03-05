import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:smart_sugar/core/helper_functions/get_snack_bar.dart';
import 'package:smart_sugar/features/admin_feature/domain/emergency_number_entity.dart';
import 'package:smart_sugar/features/admin_feature/domain/sugar_center_model.dart';
import 'package:smart_sugar/features/profile/domain/entity/article_entity.dart';
import '../../../../constants.dart';
import '../../../../core/helper_functions/get_random_number.dart';
import '../../domain/admin_entity.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  static AdminCubit get(context) => BlocProvider.of(context);
  AdminEntity? adminModel;
  void getAdmin(String uid) {
    emit(GetAdminLoading());
    FirebaseFirestore.instance
        .collection(adminCollection)
        .doc(uid)
        .get()
        .then((value) {
      adminModel = AdminEntity.fromMap(value.data()!);
      emit(GetAdminSuccess());
    }).catchError((e) {
      emit(GetAdminError());
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

  Future<void> addSugarCenter(File image, String name, String phone,
      String latitude, String longitude) async {
    emit(AddSugarCenterLoadingState());
    String? imageUrl = await uploadImageToCloudinary(image);
    int centerId = getRandomNumber();
    SugarCenterModel sugarCenterModel = SugarCenterModel(
      id: centerId.toString(),
      name: name,
      image: imageUrl,
      latitude: latitude,
      longitude: longitude,
      phoneNumber: phone,
    );
    if (imageUrl != null) {
      await FirebaseFirestore.instance
          .collection(sugarCenterCollection)
          .doc(centerId.toString())
          .set(sugarCenterModel.toJson())
          .then((value) {
        emit(AddSugarCenterSuccessState());
      }).catchError((e) {
        emit(AddSugarCenterErrorState());
      });
    } else {
      getSnackBar('Invalid image, Please try again');
    }
  }

  List<SugarCenterModel> sugarCenterList = [];
  void getAllSugarCenter() {
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

  void deleteSugarCenter(String id) {
    emit(DeleteSugarCenterLoadingState());
    FirebaseFirestore.instance
        .collection(sugarCenterCollection)
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteSugarCenterSuccessState());
    }).catchError((e) {
      emit(DeleteSugarCenterErrorState());
    });
  }

  void addArticle(String title, String content, File image) async {
    emit(AddArticleLoadingState());
    String? imageUrl = await uploadImageToCloudinary(image);
    int articleId = getRandomNumber();
    if (imageUrl != null) {
      ArticleEntity articleModel = ArticleEntity(
        id: articleId.toString(),
        date: DateTime.now().toString(),
        title: title,
        description: content,
        image: imageUrl,
      );
      await FirebaseFirestore.instance
          .collection(articleCollection)
          .doc(articleId.toString())
          .set(articleModel.toMap())
          .then((value) {
        emit(AddArticleSuccessState());
      }).catchError((e) {
        emit(AddArticleErrorState());
      });
    }
  }

  List<ArticleEntity> articleList = [];
  void getAllArticles() {
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

  void deleteArticle(String id) {
    emit(DeleteArticleLoadingState());
    FirebaseFirestore.instance
        .collection(articleCollection)
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteArticleSuccessState());
    }).catchError((e) {
      emit(DeleteArticleErrorState());
    });
  }

  void addEmergencyNumber(String number, String name) {
    emit(AddEmergencyNumberLoadingState());
    int numberId = getRandomNumber();
    EmergencyNumberEntity emergencyNumberEntity = EmergencyNumberEntity(
      id: numberId.toString(),
      name: name,
      number: number,
    );
    FirebaseFirestore.instance
        .collection(emergencyCollection)
        .doc(numberId.toString())
        .set(emergencyNumberEntity.toJson())
        .then((value) {
      emit(AddEmergencyNumberSuccessState());
    }).catchError((e) {
      emit(AddEmergencyNumberErrorState());
    });
  }

  List<EmergencyNumberEntity> emergencyNumberList = [];
  void getAllEmergencyNumber() {
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

  void deleteEmergencyNumber(String id) {
    emit(DeleteEmergencyNumberLoadingState());
    FirebaseFirestore.instance
        .collection(emergencyCollection)
        .doc(id)
        .delete()
        .then((value) {
      emit(DeleteEmergencyNumberSuccessState());
    }).catchError((e) {
      emit(DeleteEmergencyNumberErrorState());
    });
  }

  void refreshApiLink(String link) {
    emit(RefreshApiLinkLoadingState());
    FirebaseFirestore.instance
        .collection(apiCollection)
        .doc('1')
        .set({'apiLink': link})
        .then((value) {
      emit(RefreshApiLinkSuccessState());
    }).catchError((e) {
      emit(RefreshApiLinkErrorState());
    });
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
}
