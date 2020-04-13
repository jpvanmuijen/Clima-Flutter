import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  // Set taskTwoResult after task2 has finished (i.e. the Future has returned a String)
  String taskTwoResult = await task2();
  task3(taskTwoResult);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

// Future is something that returns something (in this case; a String) in the future (called Promise in js)
// A future can be more specific by defining a data type
Future<String> task2() async {
  Duration threeSconds = Duration(seconds: 3);
  String result; 
  await Future.delayed(threeSconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  // After the delay, return the String value
  return result;
}

void task3(String taskTwoData) {
  String result = 'task 3 data';
  print('Task 3 complete with $taskTwoData');
}
