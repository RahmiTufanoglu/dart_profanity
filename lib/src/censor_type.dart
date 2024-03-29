/// Creates an [CensorType].
/// CensorType full censors the whole String value.
/// CensorType firstLetter censors the whole String value except the first letter.
enum CensorType {
  full(0),
  firstLetter(1);

  const CensorType(this.notCensoredLength);

  final int notCensoredLength;

  @override
  String toString() => '$CensorType';
}
