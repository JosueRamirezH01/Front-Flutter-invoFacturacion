class Almacen {

  int? numero;
  String? tipo;
  DateTime? fecha;
  String? usuario;
  String? origen;

  Almacen({
    this.numero,
    this.tipo,
    this.fecha,
    this.usuario,
    this.origen
  });

  // Método para crear una instancia de CompraModel desde un mapa (por ejemplo, desde JSON)
  factory Almacen.fromMap(Map<String, dynamic> map) {
    return Almacen(
      numero: map['numero'],
      tipo: map['tipo'],
      fecha: DateTime.parse(map['fecha']),
      usuario: map['usuario'],
      origen: map['origen'],

    );
  }

  // Método para convertir una instancia de CompraModel a un mapa (por ejemplo, para JSON)
  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'tipo': tipo,
      'fecha': fecha,
      'usuario': usuario,
      'origen': origen,

    };
  }
}
