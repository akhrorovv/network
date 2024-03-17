import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  _createPost() async {
    String name = _nameController.text.toString().trim();
    String age = _salaryController.text.toString().trim();
    String salary = _ageController.text.toString().trim();

    Employee employee = Employee(employeeName: name, employeeAge: int.parse(age), employeeSalary: int.parse(salary));

    var response = await Network.POST(Network.API_EMPLOYEE_CREATE, Network.paramsCreate(employee));
    LogService.d(response!);
    backToFinish();
  }

  backToFinish() {
    Navigator.of(context).pop(true);
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
          title: Text("Create Employee"),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
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
                    _createPost();
                  },
                  child: Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}