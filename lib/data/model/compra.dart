class Compra {
  final int? numeroCompra;
  final String? tipoDocumento;
  final String? proveedor;
  final double? total;
  final DateTime? fecha;
  final String? usuario;

  Compra({
     this.numeroCompra,
     this.tipoDocumento,
     this.proveedor,
     this.total,
     this.fecha,
     this.usuario,
  });

  // Método para crear una instancia de CompraModel desde un mapa (por ejemplo, desde JSON)
  factory Compra.fromMap(Map<String, dynamic> map) {
    return Compra(
      numeroCompra: map['numeroCompra'],
      tipoDocumento: map['tipoDocumento'],
      proveedor: map['proveedor'],
      total: map['total'],
      fecha: DateTime.parse(map['fecha']),
      usuario: map['usuario'],
    );
  }

  // Método para convertir una instancia de CompraModel a un mapa (por ejemplo, para JSON)
  Map<String, dynamic> toMap() {
    return {
      'numeroCompra': numeroCompra,
      'tipoDocumento': tipoDocumento,
      'proveedor': proveedor,
      'total': total,
      'fecha': fecha,
      'usuario': usuario,
    };
  }
}
