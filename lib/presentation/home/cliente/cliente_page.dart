import 'package:flutter/material.dart';
import 'package:invefacturacion/presentation/components/button.dart';
import 'package:invefacturacion/presentation/components/textFormField.dart';
import 'package:invefacturacion/presentation/home/cliente/cliente_controller.dart';
import 'package:invefacturacion/presentation/widget/menu_drawer.dart';
import 'package:invefacturacion/presentation/widget/message_download.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../data/model/cliente.dart';



class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {


  ClienteController _con = ClienteController();

  final int itemsPerPage = 10;
  int _currentPage = 0;
  List<Cliente> _currentData = [];
  TextEditingController _searchController = TextEditingController();

  // Lista de ejemplo de clientes


  @override
  void initState() {
    super.initState();
    _updatePage();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _currentPage = 0;
      _updatePage();
    });
  }

  void _updatePage() {
    final filteredData = _con.data.where((cliente) {
      final query = _searchController.text.toLowerCase();
      return cliente.nombreRazonSocial!.toLowerCase().contains(query) ||
          cliente.documento!.toLowerCase().contains(query) ||
          cliente.tipoCliente!.toLowerCase().contains(query);
    }).toList();

    final startIndex = _currentPage * itemsPerPage;
    setState(() {
      _currentData = filteredData.skip(startIndex).take(itemsPerPage).toList();
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _updatePage();
    });
  }


  @override
  Widget build(BuildContext context) {
    int totalPages = (_con.data.length / itemsPerPage).ceil();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes/Proveedores', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.download),
            onPressed: () {
              MessageDownload.showConfirmationDialog(context: context, action: 'Exportar en excel', isDownload: true ,onConfirm: () {});
            },
          ),
        ],
      ),
      drawer: const WidgetMenu(),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 10, right: 10, bottom: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar cliente',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Tabla
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: {
                    0: FixedColumnWidth(50.0), // Columna de numeración reducida
                    1: FixedColumnWidth(120.0),
                    2: FixedColumnWidth(120.0),
                    3: FixedColumnWidth(120.0),
                    4: FixedColumnWidth(120.0),
                    5: FixedColumnWidth(120.0),
                    6: FixedColumnWidth(50.0),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      children: const [
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('#', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center))),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Nombre/Razón Social', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center))),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Documento', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center))),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center))),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Dirección', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center))),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Teléfono', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center))),
                        TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Icon(LucideIcons.tornado)))

                      ],
                    ),
                    ..._currentData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final cliente = entry.value;
                      return TableRow(
                        children: [
                          TableCell(
                            child: InkWell(
                              onTap: () => {
                              _con.mostrarFormularioRegistro(context, true)
                              },
                              child: Padding(padding: EdgeInsets.all(8.0), child: Text('${_currentPage * itemsPerPage + index + 1}',textAlign: TextAlign.center)),
                            ),
                          ),
                          TableCell(
                            child: InkWell(
                              onTap: () => {
                                _con.mostrarFormularioRegistro(context, true)
                                },
                              child: Padding(padding: const EdgeInsets.all(8.0), child: Text(cliente.nombreRazonSocial!,textAlign: TextAlign.center)),
                            ),
                          ),
                          TableCell(
                            child: InkWell(
                              onTap: () {
                                _con.mostrarFormularioRegistro(context, true);
                              },
                              child: Padding(padding: const EdgeInsets.all(8.0), child: Text(cliente.documento!,textAlign: TextAlign.center)),
                            ),
                          ),
                          TableCell(
                            child: InkWell(
                              onTap: () {
                                _con.mostrarFormularioRegistro(context, true);
                              },
                              child: Padding(padding: const EdgeInsets.all(8.0), child: Text(cliente.tipoCliente!,textAlign: TextAlign.center)),
                            ),
                          ),
                          TableCell(
                            child: InkWell(
                              onTap: () {
                                _con.mostrarFormularioRegistro(context, true);
                              },
                              child: Padding(padding: const EdgeInsets.all(8.0), child: Text(cliente.direccion!,textAlign: TextAlign.center)),
                            ),
                          ),
                          TableCell(
                            child: InkWell(
                              onTap: () {
                                _con.mostrarFormularioRegistro(context, true);
                              },
                              child: Padding(padding: const EdgeInsets.all(8.0), child: Text(cliente.telefono!,textAlign: TextAlign.center)),
                            ),
                          ),
                          TableCell(
                            child: PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert),
                              onSelected: (String result) {
                                if (result == 'editar') {
                                  _con.mostrarFormularioRegistro(context, true);
                                } else if (result == 'deshabilitar') {
                                  MessageDownload.showConfirmationDialog(context: context, action: 'Deshabilitar', itemName: cliente.nombreRazonSocial,isDownload: false,onConfirm: (){});

                                }
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'editar',
                                  child: Text('Editar'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'deshabilitar',
                                  child: Text('deshabilitar'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          // Paginación
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: _currentPage > 0
                      ? () => _onPageChanged(_currentPage - 1)
                      : null,
                ),
                if (_currentPage > 0)
                  GestureDetector(
                    onTap: () => _onPageChanged(_currentPage - 1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '${_currentPage}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                GestureDetector(
                  onTap: () => _onPageChanged(_currentPage),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      '${_currentPage + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                if (_currentPage < totalPages - 1)
                  GestureDetector(
                    onTap: () => _onPageChanged(_currentPage + 1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '${_currentPage + 2}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _currentPage < totalPages - 1
                      ? () => _onPageChanged(_currentPage + 1)
                      : null,
                ),
              ],

            ),

          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           _con.nombreController.clear();
           _con.documentoController.clear();
           _con.direccionController.clear();
           _con.telefonoController.clear();
           _con.correoController.clear();
           setState(() {
             _con.mostrarConfigAvanzadas = false;
           });
          _con.mostrarFormularioRegistro(context, false);
        },
        child: const Icon(Icons.add),
        tooltip: 'Agregar Cliente',
      ),
    );
  }


  @override
  void dispose() {
    _searchController.dispose();
    _con.correoController.dispose();
    _con.direccionController.dispose();
    _con.documentoController.dispose();
    _con.nombreController.dispose();
    _con.telefonoController.dispose();
    super.dispose();
  }


}