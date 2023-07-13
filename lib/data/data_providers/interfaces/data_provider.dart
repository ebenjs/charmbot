abstract class DataProvider<T> {
  T readAll();
  T readById(int id);
}
