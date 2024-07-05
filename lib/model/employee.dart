class Employee {
  final String name;
  final int age;
  final int salary;

  Employee({required this.name, required this.age, required this.salary});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      age: json['age'],
      salary: json['salary'],
    );
  }
}
