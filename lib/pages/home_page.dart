import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:network/pages/update_page.dart';
import '../models/employee_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';
import 'create_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Employee> employeesList = [];

  _loadEmployees() async {
    setState(() {
      isLoading = true;
    });
    var response =
    await Network.GET(Network.API_EMPLOYEE_LIST, Network.paramsEmpty());
    LogService.d(response!);
    List<Employee> postList = Network.parseEmployees(response);
    setState(() {
      employeesList = postList;
      isLoading = false;
    });
  }

  _deleteEmployee(Employee employee) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.DEL(
      Network.API_EMPLOYEE_DELETE + employee.id.toString(),
      Network.paramsEmpty(),
    );
    LogService.d(response!);
    _loadEmployees();
  }

  Future _callCreatePage() async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const CreatePage();
    }));

    if (result) {
      _loadEmployees();
    }
  }

  Future _callUpdatePage(Employee employee) async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UpdatePage(employee: employee);
    }));

    if (result) {
      _loadEmployees();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadEmployees();
  }

  Future _handleRefresh() async {
    _loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Employees",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            child: ListView.builder(
              itemCount: employeesList.length,
              itemBuilder: (ctx, index) {
                return _itemOfEmployee(employeesList[index]);
              },
            ),
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _callCreatePage();
        },
      ),
    );
  }

  Widget _itemOfEmployee(Employee employee) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _callUpdatePage(employee);
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _deleteEmployee(employee);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${employee.employeeName}",
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Text("Age: ${employee.employeeAge}"),
            Text("Salary: \$${employee.employeeSalary}"),
            const Divider(thickness: 1)
          ],
        ),
      ),
    );
  }
}