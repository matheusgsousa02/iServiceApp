import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iservice_application/Models/address.dart';
import 'package:iservice_application/Models/appointment.dart';
import 'package:iservice_application/Models/client_profile.dart';
import 'package:iservice_application/Models/establishment_profile.dart';
import 'package:iservice_application/Models/service.dart';
import 'package:iservice_application/Models/user.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Models/user_role.dart';
import 'package:iservice_application/Services/Utils/Calendar.dart';
import 'package:iservice_application/Services/Utils/CalendarController.dart';
import 'package:iservice_application/Views/Client_Search/client-search.dart';
import 'package:iservice_application/Views/Client_Search/Establishment_Catalog/establishment-catalog.dart';
import 'package:iservice_application/Views/Client_Search/establishment-category.dart';
import 'package:iservice_application/Views/Feedback/review-list.dart';
import 'package:iservice_application/Views/Feedback/review-page.dart';
import 'package:iservice_application/Views/Schedules/appointment-page.dart';
import 'package:iservice_application/Views/Establishment_Services/service-page.dart';
import 'package:iservice_application/Views/Feedback/feedback-page.dart';
import 'package:iservice_application/Views/Login/login-home-page.dart';
import 'package:iservice_application/Views/Login/login-profile-choice.dart';
import 'package:iservice_application/Views/main-page-client.dart';
import 'package:iservice_application/Views/main-page-establishment.dart';
import 'Views/Login/login-page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User user = User(
        userId: 1,
        userRoleId: 1,
        email: 'isinha@hotmail.com',
        password: '123',
        name: 'isa',
        creationDate: DateTime.now());

    UserRole userRole =
        UserRole(userRoleId: 1, name: 'isa', creationDate: DateTime.now());

    EstablishmentProfile establishmentProfile = EstablishmentProfile(
        establishmentProfileId: 2,
        userId: 2,
        cnpj: '111111111111',
        commercialName: 'isinha',
        establishmentCategoryId: 1,
        addressId: 1,
        description: 'description',
        commercialPhone: '11111111111',
        commercialEmail: 'isinha@hotmail.com',
        creationDate: DateTime.now());

    ClientProfile clientProfile = ClientProfile(
        clientProfileId: 1,
        userId: 1,
        cpf: '11111111111',
        dateOfBirth: DateTime.now(),
        phone: '111111111111',
        addressId: 1,
        creationDate: DateTime.now());

    Address address = Address(
        addressId: 1,
        street: 'street',
        number: '12',
        city: 'city',
        state: 'state',
        country: 'br',
        postalCode: '122454',
        creationDate: DateTime.now());

    UserInfo userInfo = UserInfo(
        user: user,
        userRole: userRole,
        establishmentProfile: establishmentProfile,
        clientProfile: clientProfile,
        address: address);

    Service service = Service(
        serviceId: 17,
        establishmentProfileId: 1,
        serviceCategoryId: 1,
        name: 'oi',
        description: 'description',
        price: 55,
        estimatedDuration: 120,
        creationDate: DateTime.now());

    return MaterialApp(
        locale: const Locale('pt', 'BR'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        title: 'iService',
        theme: ThemeData(),
        home: MainPageClient(userInfo: userInfo));
  }
}
