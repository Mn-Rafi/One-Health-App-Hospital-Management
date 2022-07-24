import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:one_health_hospital_app/logic/models/doctor_response_model.dart'
    as dr;
import 'package:one_health_hospital_app/logic/models/doctors_respoonse_model_for_search.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/widgets/doctor_card.dart';
import 'package:one_health_hospital_app/repositories/user_get_doctors_services/user_get_doctor_services.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);

  final TextEditingController _searchTextController = TextEditingController();
  final GetAllDoctorsServices _getAllDoctorsServices = GetAllDoctorsServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: CustomTextFormField(
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
                dr.Doctor doctor = snapshot.data!.doctor![0] as dr.Doctor;
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
                                isSearching: true, doctor: doctorModel)),
                      ),
                    ),
                  ],
                );
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
    );
  }
}
