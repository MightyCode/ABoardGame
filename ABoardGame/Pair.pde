public class Pair<K, V> {
  public K key;
  /** Value. */
  public V value;

  public Pair(K k, V v) {
    key = k;
    value = v;
  }

  public Pair() {
    key = null;
    value = null;
  }
  
  @Override
  public String toString(){
    return "{k : " + key.toString() + ", v : " + value.toString() + "}";
  }
  
  @Override
  public boolean equals(Object object){
    if (object == this) return true;
    
    if (((Pair)object).key.equals(key) && ((Pair)object).value.equals(value)) return true;
    
    return false;
  }
}