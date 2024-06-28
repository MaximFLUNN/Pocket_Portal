import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unn_mobile/components/import_network_handler.dart';
import 'package:unn_mobile/components/ui_toolkit/my_button.dart';
import 'package:unn_mobile/components/ui_toolkit/my_textfield.dart';
import 'package:unn_mobile/helper/helper_functions/helper_functions.dart';
import 'package:http/http.dart' as http;
import 'package:unn_mobile/pages/all_pages/page_view_test.dart';
import 'package:unn_mobile/pages/all_pages/schedule_page.dart';
import 'package:unn_mobile/components/network_handler/api_endpoints.dart';

class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void login() async {

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final networkHandler = NetworkHandler();
    final queryParams = {
      'start': '2024.06.03',
      'finish': '2024.06.09',
      'lng': '1'
    };
    //final url = Uri.parse('https://portal.unn.ru/ruzapi/schedule/group/40749?start=2024.06.03&finish=2024.06.09&lng=1');
    //final url = Uri.parse('https://portal.unn.ru/bitrix/vuz/api/marks2/');
    //final url = Uri.parse('https://portal.unn.ru/auth/?login=yes');
    final login = loginController.text;
    final password = passwordController.text;

    final authString = base64Encode(utf8.encode('$login:$password'));
    final headers = {'Authorization': 'Basic $authString'};



    try {
      if (queryParams['start'] != null && queryParams['finish'] != null && queryParams['lng'] != null) {
        final response = await networkHandler.fetchShedule(
          queryParams['start']!,
          queryParams['finish']!,
          queryParams['lng']!,
          headers
        );

        final responseBody = response.body;

        if (response.statusCode == 200) {
          if (responseBody.contains('Забыли пароль?')) {
            if (context.mounted) Navigator.pop(context);
          // Если в ответе содержится 'Вход в систему', значит данные неверные
          displayMessageToUser('Login failed!', context);
          } 
          else {
            if (context.mounted) Navigator.pop(context);
            // Иначе, авторизация успешна
            //displayMessageToUser('Login successful!', context);
            
            // Переход на страницу расписания и передача JSON-ответа
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SchedulePage(),
              ),
              // MaterialPageRoute(
              //   builder: (context) => const PageViewTest(),
              // ),
            );
          }
        }
        else {
          if (context.mounted) Navigator.pop(context);
        }
      }
      else {
        debugPrint("start, finish or lng == null");
      }
      //final response = await http.get(url, headers: headers);
      //debugPrint(response.body);
      //debugPrint(response.headers as String?);
    } catch (e) {
      // Обработка ошибок
      displayMessageToUser('Error: $e', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
              const SizedBox(height: 25),
          
              const Text(
                "P O R T A L",
                style: TextStyle(fontSize: 20),
              ),
          
              const SizedBox(height: 50),
          
              MyTextField(
                hintText: "Login",
                obscureText: false,
                controller: loginController,
              ),

              const SizedBox(height: 10),

              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: passwordController,
              ),

              const SizedBox(height: 25),

              MyButton(
                text: "Login",
                onTap: login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}