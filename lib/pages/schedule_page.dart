import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ExpandableLesson extends StatefulWidget {
  final String date;
  final List<dynamic> lessons;

  const ExpandableLesson({
    Key? key,
    required this.date,
    required this.lessons,
  }) : super(key: key);

  @override
  _ExpandableLessonState createState() => _ExpandableLessonState();
}

Color _getBorderColor(String kindOfWork) {
  // Функция для определения цвета границы в зависимости от типа занятия
  switch (kindOfWork) {
    case 'Лекция':
      return Colors.lightGreen;
    case 'Практика (семинарские занятия)':
      return Colors.orange;
    case 'Лабораторная':
      return Colors.lightBlue;
    case 'Консультации перед экзаменом':
      return Colors.purple;
    case 'Экзамен':
    case 'Зачёт':
      return Colors.pink;
    default:
      return Colors.red;
  }
}

class _ExpandableLessonState extends State<ExpandableLesson>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dateTime = DateFormat('yyyy.MM.dd').parse(widget.date);
    final weekday = DateFormat('EEEE', 'ru').format(dateTime);
    String formattedDate = DateFormat('EEEE, d MMMM', 'ru_RU').format(dateTime);
    String weekday1 = DateFormat('EEEE', 'ru_RU').format(dateTime);
    String dayMonth = DateFormat('d MMMM', 'ru_RU').format(dateTime);
    weekday1 = '${weekday1[0].toUpperCase()}${weekday1.substring(1)}';
    return Card(
      //margin: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 225),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft:
                      _isExpanded ? Radius.circular(0) : Radius.circular(16.0),
                  bottomRight:
                      _isExpanded ? Radius.circular(0) : Radius.circular(16.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // День недели слева с отступом
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0), // Задаем отступ слева
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        weekday1,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Дата справа с отступом
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0), // Задаем отступ справа
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        dayMonth,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            child: AnimatedCrossFade(
              firstChild:
                  _buildLessonsList(), // Содержимое при развернутом состоянии
              secondChild:
                  Container(), // Пустой контейнер при свернутом состоянии
              crossFadeState: _isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 225),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsList() {
    // Виджет списка уроков
    return Column(
      children: widget.lessons.map((lesson) {
        return _LessonTile(lesson: lesson);
      }).toList(),
    );
  }
}

class _LessonTile extends StatefulWidget {
  final Map<String, dynamic> lesson;

  const _LessonTile({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  __LessonTileState createState() => __LessonTileState();
}

class __LessonTileState extends State<_LessonTile>
    with AutomaticKeepAliveClientMixin {
  bool _isExpanded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final borderColor = _getBorderColor(widget.lesson['kindOfWork']);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 225),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 0.7),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.lesson['discipline']}',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Аудитория: ${widget.lesson['auditorium']}' +
                          '\n${widget.lesson['building']}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${widget.lesson['beginLesson']} - ${widget.lesson['endLesson']}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedCrossFade(
                firstChild:
                    Container(), // Пустой контейнер для скрытого состояния
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.grey[700],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Преподаватель: ${widget.lesson['lecturer']}',
                        style: TextStyle(color: Colors.white70),
                      ),
                      // Дополнительная информация, которую вы хотите отобразить
                    ],
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 225),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _startDate = _getStartOfWeek(DateTime.now());
  final List<Map<String, dynamic>> _scheduleData = [];
  int _currentIndex = 0;
  int _currentIndexByWeek = 2;
  int _currentLeft = -1;
  int _currentRight = 1;
  late PageController _pageController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1);
    initializeDateFormatting('ru_RU', null).then((_) async {
      await _fetchScheduleData(
          0, 0); // Сначала загружаем данные за текущую неделю
      await _fetchScheduleData(-1, -1); // Затем данные за прошлую неделю
      await _fetchScheduleData(1, 2); // И данные за следующую неделю
      setState(() {
        _isLoading = false;
      });
    });
  }

  static DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  static DateTime _getEndOfWeek(DateTime date) {
    return date.add(Duration(days: 7 - date.weekday));
  }

  Future<void> _fetchScheduleData(int offset, int pos) async {
    if (_isLoading) return;

    _setLoadingState(true);

    final dates = _calculateStartAndEndDates(offset);
    final url = _constructScheduleUrl(dates['start']!, dates['end']!);

    try {
      final response = await _fetchDataFromApi(url);
      _processApiResponse(response, pos);
    } catch (e) {
      debugPrint('Ошибка при запросе данных: $e');
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  Map<String, DateTime> _calculateStartAndEndDates(int offset) {
    final startDate =
        _getStartOfWeek(_startDate.add(Duration(days: 7 * offset)));
    final endDate = _getEndOfWeek(startDate);
    return {'start': startDate, 'end': endDate};
  }

  Uri _constructScheduleUrl(DateTime start, DateTime end) {
    debugPrint('ZAPROS!!!');
    final startDateString = DateFormat('yyyy.MM.dd').format(start);
    final endDateString = DateFormat('yyyy.MM.dd').format(end);
    return Uri.parse(
        'https://portal.unn.ru/ruzapi/schedule/group/40749?start=$startDateString&finish=$endDateString&lng=1');
  }

  Future<http.Response> _fetchDataFromApi(Uri url) async {
    return await http.get(url);
  }

  void _processApiResponse(http.Response response, int pos) {
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body) as List<dynamic>;
      final groupedData = _groupDataByDate(decodedData);
      _updateScheduleData(groupedData, pos);
    } else {
      // Обработка ошибки
    }
  }

  void _updateScheduleData(Map<String, dynamic> groupedData, int pos) {
    //final index = _currentIndex + offset;
    final index = pos;
    if (index >= 0 && index < _scheduleData.length) {
      _scheduleData[index] = groupedData;
    } else if (index >= _scheduleData.length) {
      _scheduleData.add(groupedData);
      _currentRight++;
      //_currentIndexByWeek++;
    } else {
      _minusCurrentIndextByWeek();
      _minusCurrentIndextByWeek();
      _scheduleData.insert(0, groupedData);
      _currentLeft--;
      //_currentIndexByWeek--;
      _pageController.jumpToPage(_currentIndex + 1);
    }
    debugPrint("DATA: left: " +
        _currentLeft.toString() +
        " | right: " +
        _currentRight.toString());
  }

  Map<String, dynamic> _groupDataByDate(List data) {
    Map<String, dynamic> groupedData = {};
    for (var item in data) {
      final date = item['date'];
      if (groupedData.containsKey(date)) {
        groupedData[date].add(item);
      } else {
        groupedData[date] = [item];
      }
    }
    return groupedData;
  }

  void _handlePageChange(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Проверяем, что страница успешно просвайпана
    if (index != _currentIndex) return;
    // if (index > _currentIndexByWeek) {
    //   _plusCurrentIndexByWeek();
    // }
    // else if (index < _currentIndexByWeek) {
    //   _minusCurrentIndextByWeek();
    // }
    // debugPrint("ALLO: " + _currentIndexByWeek.toString());
    // Загружаем данные для новой недели
    if (index == 0 && !_isLoading) {
      _fetchScheduleData(_currentLeft, -1);
      //debugPrint((_currentLeft - 1).toString());
    } else if (index == _scheduleData.length - 1 && !_isLoading) {
      _fetchScheduleData(_currentRight - 1, _scheduleData.length);
    }
  }

  void _plusCurrentIndexByWeek() {
    _currentIndexByWeek++;
  }

  void _minusCurrentIndextByWeek() {
    _currentIndexByWeek--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расписание'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Всегда позволяем пользователю свайпать влево
                    _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    // Если мы находимся на первой странице, загружаем данные за предыдущую неделю
                    //if (_currentIndex == 0) {
                    //_fetchScheduleData(_currentLeft - 1, 0);
                    //_minusCurrentIndextByWeek(); // Уменьшаем индекс недели
                    //}
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 42, 42, 42),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    '${DateFormat('dd.MM.yyyy').format(_getStartOfWeek(_startDate.add(Duration(days: 7 * _currentIndexByWeek - 1))))} - ${DateFormat('dd.MM.yyyy').format(_getEndOfWeek(_startDate.add(Duration(days: 7 * _currentIndexByWeek - 1))))}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                    //if (_currentIndex == _scheduleData.length - 1) {
                    //_fetchScheduleData(_currentRight + 1, _scheduleData.length);
                    //_plusCurrentIndexByWeek();
                    //}
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                if (index == 0) {
                  // Don`t del
                  //_minusCurrentIndextByWeek();
                  //_minusCurrentIndextByWeek();
                } else if (index > _currentIndex) {
                  _plusCurrentIndexByWeek();
                } else if (index < _currentIndex) {
                  _minusCurrentIndextByWeek();
                }
                _handlePageChange(index);
              },
              itemCount: _scheduleData.length + 1,
              itemBuilder: (context, index) {
                if (index >= _scheduleData.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final weekData = _scheduleData[index];
                return _buildWeekSchedule(convertWeekData(weekData));
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<dynamic>> convertWeekData(Map<String, dynamic> weekData) {
    return weekData.map((key, value) {
      // Убедимся, что каждое значение является списком
      return MapEntry(key, value is List ? value : [value]);
    });
  }

  Widget _buildWeekSchedule(Map<String, List<dynamic>> weekData) {
    if (weekData.isEmpty) {
      return const Center(
        child: Text(
          'Нет данных',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: weekData.keys.length,
      itemBuilder: (context, index) {
        final date = weekData.keys.toList()[index];
        final lessons = weekData[date] ?? [];
        return ExpandableLesson(date: date, lessons: lessons);
      },
    );
  }
}
