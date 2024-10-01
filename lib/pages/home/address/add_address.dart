import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/model_class/address_model.dart';

import '../../../constant/color_constraint.dart';
import '../../../services/address_services.dart';
import '../../../widgets/sub_text.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  final AddressServices _services = AddressServices();

  List<String> dzongkhags = [
    'Thimphu',
    'Paro',
    'Sarpang',
    'Haa'
  ]; // List of options
  String? selectedDzongkhag; // Variable to store selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RegularText(
          text: 'Add new Address',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(
                  text: 'Select Dzongkhag',
                  color: AppColors.grey,
                  fontSize: 16,
                ),
                Gap(8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  value: selectedDzongkhag, // Bind the selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDzongkhag = newValue; // Update selected value
                    });
                  },
                  items:
                      dzongkhags.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a dzongkhag'
                      : null,
                ),
                Gap(20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your full name'
                      : null,
                ),
                Gap(20),
                TextFormField(
                  controller: _mobileNumberController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (value.length != 8) {
                      return 'Mobile number must be 8 digits';
                    }
                    return null;
                  },
                ),
                Gap(20),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'City/State',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your city/state'
                      : null,
                ),
                Gap(20),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your location'
                      : null,
                ),
                Gap(20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Clear all form fields
                    _formKey.currentState?.reset();
                    _nameController.clear();
                    _mobileNumberController.clear();
                    _locationController.clear();
                    _cityController.clear();
                    setState(() {
                      selectedDzongkhag = null; // Reset selected dropdown value
                    });
                  },
                  child: RegularText(
                    text: 'RESET',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      AddressModel address = AddressModel(
                        id: '',
                        fullName: _nameController.text,
                        mobileNumber: _mobileNumberController.text,
                        city: _cityController.text,
                        location: _locationController.text,
                        dzongkhag:
                            selectedDzongkhag ?? '', // Use selected value
                      );
                      await _services.addAddress(address);
                      Get.toNamed('/select_address');
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: RegularText(
                        text: 'ADD ADDRESS',
                        color: AppColors.lightGrey,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
