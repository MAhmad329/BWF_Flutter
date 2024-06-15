import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String name;
  final String age;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zip;
  final String country;
  final String date;
  final String time;
  final String gender;
  final String maritalStatus;

  const ResultScreen({
    super.key,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.zip,
    required this.country,
    required this.date,
    required this.time,
    required this.gender,
    required this.maritalStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Name'),
                subtitle: Text(name),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.cake),
                title: const Text('Age'),
                subtitle: Text(age),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(email),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Phone'),
                subtitle: Text(phone),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Address'),
                subtitle: Text(address),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text('City'),
                subtitle: Text(city),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.code),
                title: const Text('ZIP Code'),
                subtitle: Text(zip),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Country'),
                subtitle: Text(country),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Date'),
                subtitle: Text(date),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Time'),
                subtitle: Text(time),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.wc),
                title: const Text('Gender'),
                subtitle: Text(gender),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Marital Status'),
                subtitle: Text(maritalStatus),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
