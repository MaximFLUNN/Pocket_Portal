# Проект: UNN Mobile

## Описание
UNN Mobile - это мобильное приложение, разработанное с использованием фреймворка Flutter. Приложение предназначено для предоставления пользователям расписания и других функциональных возможностей, связанных с университетом.

## Структура проекта
![Иллюстрация к проекту](https://github.com/GERONlMO/Pocket_Portal/blob/projectStructure/assets/png/project_structure.png)

### MyApp
- **Методы:**
  - `const MyApp({Key? key})`
  - `build(BuildContext): Widget`
- **Зависимости:**
  - Создает `MaterialApp`
  - Применяет темы `lightMode` и `darkMode`
  - Навигирует на страницы `HomePage` и `SchedulePage`

### MaterialApp
- Создается классом `MyApp`.

### ThemeData
- **Свойства:**
  - `brightness: Brightness`
  - `colorScheme: ColorScheme`
  - `textTheme: TextTheme`
  - `dividerColor: Color`
- **Методы:**
  - `ThemeData.light()`
  - `ThemeData.dark()`
- **Зависимости:**
  - Использует `ColorScheme` и `TextTheme`

### ColorScheme
- **Свойства:**
  - `surface: Color`
  - `primary: Color`
  - `secondary: Color`
  - `inversePrimary: Color`
- **Методы:**
  - `ColorScheme.light()`
  - `ColorScheme.dark()`

### TextTheme
- **Свойства:**
  - `bodyColor: Color`
  - `displayColor: Color`
- **Методы:**
  - `apply()`

### HomePage
- **Методы:**
  - `build(BuildContext): Widget`

### LoginPage
- **Свойства:**
  - `loginController: TextEditingController`
  - `passwordController: TextEditingController`
- **Методы:**
  - `createState(): State<LoginPage>`
  - `login()`

### SchedulePage
- **Свойства:**
  - `_startDate: DateTime`
  - `_scheduleData: List<Map<String, dynamic>>`
  - `_currentIndex: int`
  - `_currentIndexByWeek: int`
  - `_currentLeft: int`
  - `_currentRight: int`
  - `_pageController: PageController`
  - `_isLoading: bool`
- **Методы:**
  - `initState()`
  - `build(BuildContext): Widget`
  - `_fetchScheduleData(int, int)`
  - `_setLoadingState(bool)`
  - `_calculateStartAndEndDates(int): Map<String, DateTime>`
  - `_constructScheduleUrl(DateTime, DateTime): Uri`
  - `_fetchDataFromApi(Uri): Future<http.Response>`
  - `_processApiResponse(http.Response, int)`
  - `_updateScheduleData(Map<String, dynamic>, int)`
  - `_groupDataByDate(List): Map<String, dynamic>`
  - `_handlePageChange(int)`
  - `_buildWeekSchedule(Map<String, List<dynamic>>): Widget`

### MyButton
- **Свойства:**
  - `text: String`
  - `onTap: Function`
- **Методы:**
  - `build(BuildContext): Widget`

### MyTextField
- **Свойства:**
  - `hintText: String`
  - `obscureText: bool`
  - `controller: TextEditingController`
- **Методы:**
  - `build(BuildContext): Widget`

### HelperFunctions
- **Методы:**
  - `displayMessageToUser(String, BuildContext)`

### http
- Используется для выполнения HTTP-запросов.
