import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';

class PageViewTest extends StatefulWidget {
  const PageViewTest({Key? key}) : super(key: key);

  @override
  _PageViewTestState createState() => _PageViewTestState();
}

class _PageViewTestState extends State<PageViewTest> {
  final LoopPageController _controller = LoopPageController();

  @override
  void initState() {
    super.initState();
    // Начальная страница устанавливается в 0 по умолчанию
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Container(color: Colors.red, child: Center(child: Text('1', style: TextStyle(fontSize: 50, color: Colors.white)))),
      Container(color: Colors.green, child: Center(child: Text('2', style: TextStyle(fontSize: 50, color: Colors.white)))),
      Container(color: Colors.blue, child: Center(child: Text('3', style: TextStyle(fontSize: 50, color: Colors.white)))),
      // Добавьте больше виджетов, если нужно
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Loop Page View Test'),
      ),
      body: LoopPageView.builder(
        controller: _controller,
        itemCount: _children.length, // Количество элементов в вашем списке
        itemBuilder: (BuildContext context, int index) {
          // Возвращаем виджет из вашего списка _children
          return _children[index % _children.length];
        },
      ),
    );
  }
}
