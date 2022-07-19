import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_health_hospital_app/logic/models/blood_bank_signup_model.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_edit_profile/custom_text_field.dart';
import 'package:one_health_hospital_app/repositories/local_storage/store_user_details.dart';
import 'package:one_health_hospital_app/themedata.dart';
import 'package:sizer/sizer.dart';

class ScreenBloodBankSignUp extends StatefulWidget {
  ScreenBloodBankSignUp({Key? key}) : super(key: key);

  @override
  State<ScreenBloodBankSignUp> createState() => _ScreenBloodBankSignUpState();
}

class _ScreenBloodBankSignUpState extends State<ScreenBloodBankSignUp> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _altPhoneController = TextEditingController();

  final TextEditingController _bloodgroupController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _lastDateofDonationController =
      TextEditingController();

  final FocusNode _NameFocus = FocusNode();

  final FocusNode _altphoneFocus = FocusNode();

  final FocusNode _ageFocus = FocusNode();

  final FocusNode _lastdateFocus = FocusNode();

  final FocusNode _addressFocus = FocusNode();

  final FocusNode _phoneFocus = FocusNode();

  final FocusNode _bloodFocus = FocusNode();

  bool isSearching = false;
  bool checkingDetails = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    print(place.toJson().toString());
    _addressController.text =
        '${place.subAdministrativeArea}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  static Box<UserLocalData> userLocalData = Hive.box<UserLocalData>(userHive);
  static List<UserLocalData> userLocalDataList = userLocalData.values.toList();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text =
        '${userLocalDataList[0].firstName} ${userLocalDataList[0].secondName}';
    _phoneNumberController.text = userLocalDataList[0].phone.toString();
    _ageController.text = userLocalDataList[0].age.toString();
    _bloodgroupController.text = userLocalDataList[0].blood;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: kboxdecoration,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Fill the details below",
                      style: theme.textTheme.headline3?.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          'https://images.hindustantimes.com/img/2022/06/14/550x309/blood-gdb0beba2c_1920_1655173703202_1655173717185.jpg')),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blue, size: 20),
                    SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Text('Name', style: titilliumRegular)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: _nameController,
                    hintText: 'Name of the donor',
                    textInputType: TextInputType.name,
                    focusNode: _NameFocus,
                    nextNode: _phoneFocus,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.dialpad, color: Colors.blue, size: 20),
                    SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Text('Phone No', style: titilliumRegular)
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _phoneNumberController,
                      hintText: 'Phone number',
                      textInputType: TextInputType.number,
                      focusNode: _phoneFocus,
                      nextNode: _altphoneFocus,
                    )),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.dialpad, color: Colors.blue, size: 20),
                    SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Text('Alternate Phone No', style: titilliumRegular)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      controller: _altPhoneController,
                      hintText: 'Alternate phone number',
                      textInputType: TextInputType.number,
                      focusNode: _altphoneFocus,
                      nextNode: _bloodFocus),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.bloodtype, color: Colors.blue, size: 20),
                    SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Text('Blood Group', style: titilliumRegular)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                      controller: _bloodgroupController,
                      hintText: 'Blood group',
                      textInputType: TextInputType.name,
                      focusNode: _bloodFocus,
                      nextNode: _ageFocus),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.nature_people_outlined,
                          color: Colors.blue, size: 20),
                      SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                      Text('Age', style: titilliumRegular)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: _ageController,
                    hintText: 'Age',
                    textInputType: TextInputType.number,
                    focusNode: _ageFocus,
                    nextNode: _addressFocus,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Icon(Icons.home_work_outlined,
                        color: Colors.blue, size: 20),
                    SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    Text('Address', style: titilliumRegular)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: _addressController,
                    hintText: 'Address',
                    textInputType: TextInputType.streetAddress,
                    focusNode: _addressFocus,
                    nextNode: _lastdateFocus,
                  ),
                ),
                TextButton.icon(
                    onPressed: () async {
                      setState(() {
                        isSearching = true;
                      });
                      Position position = await _determinePosition();
                      print(position.toString());
                      GetAddressFromLatLong(position);
                      setState(() {
                        isSearching = false;
                      });
                      // _addressController.text = position.latitude.toString();
                    },
                    icon: !isSearching
                        ? Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue[900],
                          )
                        : SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              color: Colors.blue[900],
                              strokeWidth: 1,
                            )),
                    label: Text(
                      'tap to get current location',
                      style: TextStyle(color: Colors.blue[900]),
                    )),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.date_range, color: Colors.blue, size: 20),
                      SizedBox(width: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                      Text('Last date donated blood', style: titilliumRegular)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: _lastDateofDonationController,
                    hintText: 'Last Date of Donation',
                    textInputType: TextInputType.datetime,
                    focusNode: _lastdateFocus,
                    nextNode: FocusNode(),
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final BloodBankRegisterModel bloodBankRegisterModel =
                          BloodBankRegisterModel(
                              name: _nameController.text,
                              contactNumberOne: _phoneNumberController.text,
                              contactNumberTwo: _altPhoneController.text,
                              bloodGroup: _bloodgroupController.text,
                              location: _addressController.text,
                              age: _ageController.text,
                              lastDateofDonation: DateTime.now());
                      registerDonor(bloodBankRegisterModel, context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: const Text("Sign Up Now"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerDonor(BloodBankRegisterModel bloodBankRegisterModel,
      BuildContext context) async {
    final donor = FirebaseFirestore.instance
        .collection('donors')
        .doc(bloodBankRegisterModel.name);
    await donor.set(bloodBankRegisterModel.toJson()).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
      return null;
    });
  }
}
