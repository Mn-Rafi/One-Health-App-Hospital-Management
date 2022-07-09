import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_health_hospital_app/logic/bloc_get_user_profile/getprofiledata_bloc.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenEditProfile extends StatelessWidget {
  const ScreenEditProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxdecoration,
      child: BlocConsumer<GetprofiledataBloc, GetprofiledataState>(
        listener: (context, state) {
          if (state is FetchingProfileDetailState) {
            showSnackBar(text: 'Loadingg', context: context);
          }
          if (state is FetchProfileDetailsSuccessState) {
            print(state.image);
            showSnackBar(text: 'SUCCESSSEES', context: context);
          }
          if (state is FetchDetailsErrorState) {
            showSnackBar(text: state.message, context: context);
          }
        },
        builder: (context, state) {
          if (state is FetchingProfileDetailState) {
            return Scaffold(
                body: Center(
              child: Text('LOADINGGGGGGGGGGGGGGGGGGGG'),
            ));
          }
          if (state is FetchProfileDetailsSuccessState) {
            print(state.image.path);
            return Scaffold(
                body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.firstName),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(state.image.path),
                  ),
                ],
              ),
            ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
