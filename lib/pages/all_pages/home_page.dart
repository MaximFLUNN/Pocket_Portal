import 'package:flutter/material.dart';
import 'package:unn_mobile/pages/all_pages/login_page.dart';
import 'package:unn_mobile/pages/all_pages/schedule_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
        backgroundColor: Colors.black87, // Темный фон AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
            Center(
              child: Image(
                image: AssetImage('assets/png/pocket_portal_only_white.png'),
                width: 250,
              ),
            ),
            const Text(
              "POCKET PORTAL",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Spacer(flex: 2,),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildSquareButton(
                  context,
                  iconData: Icons.schedule,
                  label: 'Расписание',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SchedulePage(),
                      ),
                    );
                  },
                ),
                _buildSquareButton(
                  context,
                  iconData: Icons.web,
                  label: 'Портал',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900], // Темный фон Scaffold
    );
  }

  Widget _buildSquareButton(BuildContext context, {required IconData iconData, required String label, required VoidCallback onPressed}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //primary: Colors.deepPurple, // Основной цвет кнопки
            //onPrimary: Colors.amber, // Цвет при нажатии
            shadowColor: Color.fromARGB(255, 45, 45, 45), // Цвет тени
            elevation: 10, // Высота тени
            padding: EdgeInsets.all(26),
          ),
          child: Icon(iconData, size: 36.0, color: Colors.white), // Иконка белого цвета
          onPressed: onPressed,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
