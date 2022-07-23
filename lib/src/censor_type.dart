enum CensorType {
  full(0),
  firstLetter(1);

  const CensorType(this.notCensoredLength);

  final int notCensoredLength;

  int get lengthDisplayed => notCensoredLength;
}
