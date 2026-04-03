class ItemImage {
  final int id;
  final String address;

  final String altText;
  final bool isLocal;

  ItemImage(this.id, this.address, this.altText, {this.isLocal = false});

  ItemImage.placeHolder()
    : this(0, 'assets/images/placeholder.png', 'no image', isLocal: true);
}
