class Employee {
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;

  Employee({
    this.id,
    this.employeeName,
    this.employeeSalary,
    this.employeeAge,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employeeName': employeeName,
      'employeeSalary': employeeSalary,
      'employeeAge': employeeAge
    };
  }

  static Employee fromMap(Map map) {
    Employee employee = Employee();
    employee.id = map['id'];
    employee.employeeName = map['employeeName'];
    employee.employeeSalary = map['employeeSalary'];
    employee.employeeAge = map['employeeAge'];
    return employee;
  }

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    employeeName: json["employee_name"],
    employeeSalary: json["employee_salary"],
    employeeAge: json["employee_age"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_name": employeeName,
    "employee_salary": employeeSalary,
    "employee_age": employeeAge,
  };
}