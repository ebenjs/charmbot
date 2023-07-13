abstract class DataPersister<T, K> {
  T create(K data);
  T update();
}
