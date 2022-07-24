import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart'
    as dr;
import 'package:one_health_hospital_app/logic/models/doctors_respoonse_model_for_search.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/widgets/doctor_card.dart';
import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenSearch extends StatefulWidget {
  ScreenSearch({Key? key}) : super(key: key);

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController _searchTextController = TextEditingController();

  final GetAllDoctorsServices _getAllDoctorsServices = GetAllDoctorsServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: CustomTextFormField(
                      onChanged: (val) {
                        setState(() {});
                      },
                      hintText: 'Search doctor, department,...',
                      keyBoardType: TextInputType.text,
                      iconData: Icons.search,
                      textController: _searchTextController),
                ),
              ),
              Expanded(
                child: FutureBuilder<DoctorResponseModelForSearch?>(
                  future: _getAllDoctorsServices.getAllDoctorsForSearch(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final datas = snapshot.data!.doctor!.where((element) {
                        if (element.name!.toLowerCase().contains(
                            _searchTextController.text.toLowerCase())) {
                          return true;
                        }
                        if (element.department!.toLowerCase().contains(
                            _searchTextController.text.toLowerCase())) {
                          return true;
                        }
                        return false;
                      }).toList();
                      if (datas.isNotEmpty) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: datas.length,
                            itemBuilder: (context, index) {
                              dr.Doctor doctor = dr.Doctor(
                                active: datas[index].active,
                                admin: datas[index].admin,
                                department: datas[index].department,
                                sId: datas[index].sId,
                                name: datas[index].name,
                                createdAt: datas[index].createdAt,
                                updatedAt: datas[index].updatedAt,
                                days: datas[index].days,
                                email: datas[index].email,
                                endTime: datas[index].endTime,
                                experience: datas[index].experience,
                                expertise: datas[index].expertise,
                                fee: datas[index].fee,
                                iV: datas[index].iV,
                                image: datas[index].image,
                                password: datas[index].password,
                                phone: datas[index].phone,
                                qualification: datas[index].qualification,
                                request: datas[index].request,
                                startTime: datas[index].startTime,
                              );
                              final doctorModel = dr.DoctorResponseModel(
                                  doctor: doctor, message: 'Doctor Got');
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: SizedBox(
                                          height: 150,
                                          child: DoctorCard(
                                              isSearching: true,
                                              doctor: doctorModel)),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                      if (datas.isEmpty) {
                        return Center(
                          child: Text('No doctors found'),
                        );
                      }
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error'),
                      );
                    }
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CardLoading(
                        cardLoadingTheme: CardLoadingTheme(
                          colorOne: Colors.white54,
                          colorTwo: Colors.white30,
                        ),
                        height: 40,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        margin: EdgeInsets.only(bottom: 3),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
