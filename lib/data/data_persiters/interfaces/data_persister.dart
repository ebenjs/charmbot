abstract class DataPersister<T, K, L> {
  T create(K data);
  T update();
  L delete(K data);
}
