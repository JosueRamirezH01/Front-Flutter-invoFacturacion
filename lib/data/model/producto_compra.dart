class ProductoCompra {
  int? idProducto;
  String? nombre;
  int? cantidad;
  double? precio;
  String? igv;

  ProductoCompra({
    this.idProducto,
    this.nombre,
    this.cantidad,
    this.precio,
    this.igv,
  });

  // Método para crear una instancia de CompraModel desde un mapa (por ejemplo, desde JSON)
  factory ProductoCompra.fromMap(Map<String, dynamic> map) {
    return ProductoCompra(
      idProducto: map['idProducto'],
      cantidad: map['cantidad'],
      nombre: map['nombre'],
      precio: map['precio'],
      igv: map['igv'],
    );
  }

  // Método para convertir una instancia de CompraModel a un mapa (por ejemplo, para JSON)
  Map<String, dynamic> toMap() {
    return {
      'idProducto': idProducto,
      'cantidad': cantidad,
      'precio': precio,
      'nombre': nombre,
      'igv': igv,
    };
  }
}
