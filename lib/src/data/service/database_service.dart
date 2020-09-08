/*
import 'package:task_manager_app/src/data/database/daos.dart';
import 'package:task_manager_app/src/data/database/database.dart';
import 'package:moor/moor.dart';

class DatabaseService {
  static AppDatabase _db = AppDatabase();
  static TasksDao _tasksDao = _db.tasksDao;
  //static CategoriesDao _categoriesDao = _db.categoriesDao;
  //static HelpersDao _helpersDao = _db.helpersDao;
  //static TodosDao _todosDao = _db.todosDao;

  DatabaseService._();

  static DatabaseService get instance => _instance;

  static final _instance = DatabaseService._();

  void dispose() {
    _db.close();
  }

  Future<List<Task>> getAllTasks() {
    return _tasksDao.getAllTasks;
  }

  Stream<List<Task>> watchAllTasks() {
    return _tasksDao.watchAllTasks;
  }

  */
/*Future<List<Category>> getAllCategories() {
    return _categoriesDao.getAllCategories;
  }*/ /*


  */
/*Stream<List<Category>> watchAllCategories() {
    return _categoriesDao.watchAllCategories;
  }*/ /*


  */
/*void addNewCategory(String categoryName) {
    _categoriesDao.insertCategory(CategoriesCompanion(
      categoryName: Value(categoryName),
    ));
  }*/ /*


  */
/*void deleteAllCategories() async {
    await _categoriesDao.deleteAllCategories();
  }*/ /*

}
*/
