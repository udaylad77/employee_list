import 'package:employee_list/model/employee.dart';
import 'package:employee_list/services/request_manager.dart';
import 'package:employee_list/utilities/common_widgets/header_text.dart';
import 'package:flutter/material.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final RequestManager requestManager =
      RequestManager('https://aamras.com/dummy/');
  late Future<List<Employee>> futureEmployees;

  @override
  void initState() {
    super.initState();
    futureEmployees = requestManager.get('EmployeeDetails.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HeaderText(text: "Employee"),
      ),
      body: FutureBuilder<List<Employee>>(
        future: futureEmployees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final employees = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Container(
                  margin: EdgeInsets.only(
                      top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                  // padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  child: Material(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.0),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onTap: () {
                        showEmployeeDialog(context, employee);
                      },
                      child: Container(
                        child: EmployeeWidget(
                          employee: employee,
                          onTap: () {
                            showEmployeeDialog(context, employee);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  showEmployeeDialog(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding:
              EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    employee.name.substring(0, 1),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              HeaderText(text: employee.name),
              SizedBox(height: 8.0),
              DescText(boldtext: 'Age: ${employee.age}', normaltext: ""),
              SizedBox(height: 8.0),
              DescText(
                  boldtext: 'Salary: \$${employee.salary}', normaltext: ""),
              SizedBox(height: 12.0),
            ],
          ),
        );
      },
    );
  }
}

class EmployeeWidget extends StatelessWidget {
  final Employee employee;
  final VoidCallback onTap;

  EmployeeWidget({required this.employee, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 80,
            width: 80,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                employee.name.substring(0, 1),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: employee.name),
                DescText(boldtext: 'Age: ${employee.age}', normaltext: ""),
                SizedBox(height: 4),
                DescText(
                    boldtext: 'Salary: \$${employee.salary}', normaltext: ""),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.black,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
