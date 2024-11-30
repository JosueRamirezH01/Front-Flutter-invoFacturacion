class Producto {
  final int? id;
  final String? name;
  final String? category;
  final int? quantity;
  final double? price;

  Producto({
     this.id,
     this.name,
     this.category,
     this.quantity,
     this.price,
  });

  @override
  String toString() {
    return name ?? '' ;  // Combina el nombre con el id
  }
}
