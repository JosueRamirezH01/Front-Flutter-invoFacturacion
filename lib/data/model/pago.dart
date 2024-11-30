class Pago {

   String? tipoPago;
   double? total;
   DateTime? fecha;
   String? usuario;

  Pago({
    this.tipoPago,
    this.total,
    this.fecha,
    this.usuario,
  });

  // Método para crear una instancia de CompraModel desde un mapa (por ejemplo, desde JSON)
  factory Pago.fromMap(Map<String, dynamic> map) {
    return Pago(
      tipoPago: map['tipoPago'],
      total: map['total'],
      fecha: DateTime.parse(map['fecha']),
      usuario: map['usuario'],
    );
  }

  // Método para convertir una instancia de CompraModel a un mapa (por ejemplo, para JSON)
  Map<String, dynamic> toMap() {
    return {
      'tipoDocumento': tipoPago,
      'total': total,
      'fecha': fecha,
      'usuario': usuario,
    };
  }
}
