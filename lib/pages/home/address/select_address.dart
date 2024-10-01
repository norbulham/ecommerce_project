import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/model_class/address_model.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';
import '../../../manager/manage_address.dart';
import '../../../services/address_services.dart';

class SelectAddress extends StatelessWidget {
  const SelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressServices _services = AddressServices();
    final SelectedAddressController selectedAddressController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(
              text: 'Delivery Details',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            RegularText(
              text: 'Step 2 OF 3',
              color: AppColors.grey,
            )
          ],
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
                RegularText(
                  text: 'RESET',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () {
                    if (selectedAddressController.getSelectedAddress() !=
                        null) {
                      Get.toNamed('/payment_page');
                    } else {
                      Get.snackbar('No Address Selected',
                          'Please select an address before proceeding.');
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
                        text: 'Proceed To Payment',
                        color: AppColors.lightGrey,
                        fontSize: 16,
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
      body: StreamBuilder<List<AddressModel>>(
        stream: _services.fetchAddress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: RegularText(
                text: 'No address available',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            );
          }

          final addresses = snapshot.data!;

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: RegularText(
                    text: address.fullName,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.primary),
                            SizedBox(width: 5),
                            Expanded(
                              child: RegularText(
                                text: '${address.location}, ${address.city}',
                                fontSize: 16,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.place, color: AppColors.primary),
                            SizedBox(width: 5),
                            RegularText(
                              text: 'Dzongkhag: ${address.dzongkhag}',
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.phone, color: AppColors.primary),
                            SizedBox(width: 5),
                            RegularText(
                              text: 'Mobile: ${address.mobileNumber}',
                              fontSize: 16,
                              color: AppColors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {},
                    child: CircularCheckbox(
                      onChanged: (isSelected) {
                        if (isSelected) {
                          selectedAddressController.selectAddress(address);
                          Get.snackbar('Address Selected',
                              'You have selected ${address.fullName}\'s address.');
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CircularCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const CircularCheckbox({Key? key, required this.onChanged}) : super(key: key);

  @override
  _CircularCheckboxState createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  bool _isSelected = false;

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
      widget.onChanged(_isSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isSelected ? Colors.teal : Colors.white,
          border: Border.all(
            color: _isSelected ? Colors.transparent : AppColors.primary,
            width: 2,
          ),
          boxShadow: [
            if (_isSelected)
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
          ],
        ),
        child: Center(
          child: Icon(
            _isSelected ? Icons.check : Icons.circle,
            color: _isSelected ? Colors.white : AppColors.primary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
