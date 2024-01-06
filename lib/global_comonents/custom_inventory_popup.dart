import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/main_screens/bank_main_screens/bank_home_screen/bank_main_function.dart';
import 'package:blood_link/models/bloodType.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';

class InventoryPopup extends StatefulWidget {
  const InventoryPopup({super.key, required this.bloodType});
  final BloodType bloodType;
  @override
  State<InventoryPopup> createState() => _InventoryPopupState();
}

class _InventoryPopupState extends State<InventoryPopup> {
  final TextEditingController _qController = TextEditingController();
  final TextEditingController _uController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _qController.text = widget.bloodType.pints.toString();
    _uController.text = widget.bloodType.unit;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40,
            top: -40,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                backgroundColor: Constants.white,
                child: Icon(
                  Icons.close,
                  color: Constants.darkPink,
                ),
              ),
            ),
          ),
          Container(
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Update "),
                Text(
                  'Kindly input the new data of your inventory',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Constants.grey),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantity:",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: CustomTextField(
                            controller: _qController,
                            keyboardType: TextInputType.number,
                            hintText: "20",
                            onChange: () {
                              setState(() {});
                            },
                            prefix: IconButton(
                              onPressed: () {
                                int pints = int.parse(_qController.text);
                                if (pints != 0) pints = --pints;
                                _qController.text = pints.toString();
                                setState(() {});
                              },
                              icon: Icon(Icons.remove),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                int pints = int.parse(_qController.text);
                                pints = ++pints;
                                _qController.text = pints.toString();
                                setState(() {});
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Unit :",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: CustomTextField(
                            controller: _uController,
                            keyboardType: TextInputType.number,
                            hintText: "900",
                            onChange: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomButton(
                  loading: loading,
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    BloodType bloodType = widget.bloodType;

                    BloodType newBloodType = BloodType(
                        symbol: bloodType.symbol,
                        name: bloodType.name,
                        pints: int.parse(_qController.text),
                        unit: _uController.text);
                    BloodBankMainFunction.updateBloodType(
                      dataToUpdate: newBloodType,
                      field: bloodType.name,
                      context: context,
                    );
                    setState(() {
                      loading = false;
                    });
                  },
                  title: "Save changes",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
