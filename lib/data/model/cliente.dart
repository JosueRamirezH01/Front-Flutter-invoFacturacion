class Cliente {
  int? id;
  String? nombreRazonSocial;
  String? documento;
  String? tipoCliente;
  String? direccion;
  String? telefono;

  Cliente({
     this.nombreRazonSocial,
     this.documento,
     this.tipoCliente,
     this.direccion,
     this.telefono,
      this.id,
  });

  @override
  String toString() {
    return nombreRazonSocial ?? '';  // Esto asegura que se muestre el nombre del producto
  }

}