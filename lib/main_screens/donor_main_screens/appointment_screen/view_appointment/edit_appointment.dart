import 'package:blood_link/Firebase/auth.dart';
import 'package:blood_link/global_comonents/custom_button.dart';
import 'package:blood_link/global_comonents/custom_textfield.dart';
import 'package:blood_link/hive/bankAdapter.dart';
import 'package:blood_link/main_screens/donor_main_screens/appointment_screen/view_appointment/view_appointment_function.dart';
import 'package:blood_link/main_screens/donor_main_screens/book_appointment/book_appointment_function.dart';
import 'package:blood_link/models/appointment.dart';
import 'package:blood_link/providers/auth_provider.dart';
import 'package:blood_link/settings/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';

class EditAppointmentScreen extends StatefulWidget {
  const EditAppointmentScreen({super.key, required this.appointment});
  final Appointment appointment;
  @override
  State<EditAppointmentScreen> createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  TextEditingController descriptionController = TextEditingController();
  DateTime? dateTime;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Appointment appointment = widget.appointment;
    descriptionController.text = appointment.note;
    dateTime = appointment.date.toDate();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: true);
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reschedule Appointment"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirm a date and time for your appointment with a general practictioner. Include a note as well",
                style: TextStyle(
                  color: Constants.grey,
                ),
              ),
              Constants.gap(height: 20),
              Text(
                "DATE & TIME",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Constants.grey,
                ),
              ),
              Constants.gap(height: 10),
              GestureDetector(
                onTap: () {
                  DateTime date = DateTime.now();
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    minTime: date,
                    maxTime: DateTime(date.year + 1, date.month, date.day),
                    onChanged: (date) {},
                    onConfirm: (date) {
                      setState(() {
                        dateTime = date;
                      });
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                  );
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFEFEFF0),
                  ),
                  child: Center(
                    child: Text(
                      dateTime == null
                          ? "Select Date and Time"
                          : "Date: ${dateTime!.day}/${dateTime!.month}/${dateTime!.year}\tTime: ${dateTime!.hour}:${dateTime!.minute.toString().length < 2 ? ("0" + dateTime!.minute.toString()) : dateTime!.minute}",
                    ),
                  ),
                ),
              ),
              Constants.gap(height: 10),
              Divider(),
              Constants.gap(height: 20),
              Text(
                "NOTE",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Constants.grey,
                ),
              ),
              Constants.gap(height: 5),
              CustomTextField(
                controller: descriptionController,
                hintText: "Type anythning you would like to tell us....",
                onChange: () {
                  setState(() {});
                },
                maxLines: 10,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: CustomButton(
            loading: loading,
            enable: dateTime != null && descriptionController.text.isNotEmpty,
            onTap: () async {
              setState(() {
                loading = true;
              });
              Appointment appointment = Appointment(
                date: FirebaseAuthentication.convertDateTimeToTimestamp(
                    dateTime!),
                note: descriptionController.text,
                email: authProvider.donor!.email,
                bankId: widget.appointment.bankId,
                status: Constants.validStatuses[1],
                timestamp: widget.appointment.timestamp,
              );

              await ViewAppointmentFunction.updateAppointmentsByTimestamp(
                  appointment: appointment,
                  scaffoldKey: scaffoldKey,
                  context: context);
              setState(() {
                loading = false;
              });
            },
            title: "Book Appointment",
          ),
        ),
      ),
    );
  }
}
