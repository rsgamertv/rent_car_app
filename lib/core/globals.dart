import 'package:get_it/get_it.dart';
import 'package:rent_car_app/authorizationPage/model/user.dart';
import 'package:rent_car_app/authorizationPage/repository/abstract_user_repository.dart';
import 'package:rent_car_app/main/model/document.dart';
import 'package:rent_car_app/main/repository/abstract_document_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';
final talker = TalkerFlutter.init();
String ip =  '5.42.220.228:80'; 

//GetIt init models
var userModel = GetIt.I<User>();
var documentModel = GetIt.I<Document>();

//GetIt init Repositories
AbstractUserRepository userRepository = GetIt.I<AbstractUserRepository>();
AbstractDocumentRepository documentRepository = GetIt.I<AbstractDocumentRepository>(); 