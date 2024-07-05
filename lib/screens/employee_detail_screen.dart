import 'package:employee_list/model/employee.dart';
import 'package:flutter/material.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;

  EmployeeDetailScreen({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Name: ${employee.name}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 8),
              Text('Age: ${employee.age}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Salary: ${employee.salary}',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
