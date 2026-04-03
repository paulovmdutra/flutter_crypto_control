abstract class EntityViewModel<T> {
  void fromEntity(T entity);
  T toEntity();
  void reset();
  void dispose();
}
