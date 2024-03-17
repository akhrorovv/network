import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class UpdatePage extends StatefulWidget {
  final Employee employee;

  const UpdatePage({super.key, required this.employee});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  _updatePost() async {
    String name = _nameController.text.toString().trim();
    String age = _ageController.text.toString().trim();
    String salary = _salaryController.text.toString().trim();

    Employee newEmployee = widget.employee;
    newEmployee.employeeName = name;
    newEmployee.employeeAge = int.parse(age);
    newEmployee.employeeSalary = int.parse(salary);

    var response = await Network.PUT(
      Network.API_EMPLOYEE_UPDATE + newEmployee.id.toString(),
      Network.paramsUpdate(newEmployee),
    );
    LogService.d(response!);
    // Employee postRes = Network.parseEmployees(response);
    backToFinish();
  }

  backToFinish() {
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.employee.employeeName!;
    _ageController.text = widget.employee.employeeAge.toString();
    _salaryController.text = widget.employee.employeeSalary.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Update Employee"),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Name"),
                ),
              ),
              Container(
                child: TextField(
                  controller: _ageController,
                  decoration: InputDecoration(hintText: "Age"),
                ),
              ),
              Container(
                child: TextField(
                  controller: _salaryController,
                  decoration: InputDecoration(hintText: "Salary"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    _updatePost();
                  },
                  child: Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}