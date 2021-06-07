class Wrapper<K> implements Comparable {
  Wrapper(this.value);
  K value;

  @override
  String toString() {
    return value.toString();
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Wrapper<K>) {
      if (value == other.value) {
        return true;
      } else {
        return false;
      }
    } else if (other is K) {
      if (value == other) {
        return true;
      } else {
        return false;
      }
    } else
      return false;
  }

  @override
  int compareTo(other) {
    if (other is Wrapper<K> || other is K) {
      return other.hashCode - hashCode;
    } else {
      throw UnimplementedError();
    }
  }
}
