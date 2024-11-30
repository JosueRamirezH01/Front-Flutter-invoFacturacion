class Gastos {
  final String? descripcion;
  final String? cuenta;
  final double? monto;
  final DateTime? fecha;
  final String? usuario;

  Gastos({
    this.descripcion,
    this.cuenta,
    this.monto,
    this.fecha,
    this.usuario,
  });

  // Método para crear una instancia de CompraModel desde un mapa (por ejemplo, desde JSON)
  factory Gastos.fromMap(Map<String, dynamic> map) {
    return Gastos(
      descripcion: map['descripcion'],
      cuenta: map['cuenta'],
      monto: map['monto'],
      fecha: DateTime.parse(map['fecha']),
      usuario: map['usuario'],
    );
  }

  // Método para convertir una instancia de CompraModel a un mapa (por ejemplo, para JSON)
  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'cuenta': cuenta,
      'monto': monto,
      'fecha': fecha,
      'usuario': usuario,
    };
  }
}
