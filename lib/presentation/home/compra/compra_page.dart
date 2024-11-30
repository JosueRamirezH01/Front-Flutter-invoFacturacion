import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:invefacturacion/presentation/home/compra/compra_controller.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../data/model/cliente.dart';
import '../../../data/model/producto.dart';
import '../../widget/datePicker.dart';
import '../../widget/menu_drawer.dart';
import '../../widget/message_download.dart';

class CompraPage extends StatefulWidget {
  const CompraPage({Key? key}) : super(key: key);

  @override
  State<CompraPage> createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CompraController _con = CompraController();
  TextEditingController autocompleteControllerProveedor = TextEditingController();
  List<Cliente> proveedores = [
    Cliente(
      nombreRazonSocial: 'Proveedor 1 S.A.',
      documento: 'RUC 12345678901',
      tipoCliente: 'Proveedor',
      direccion: 'Av. Proveedores 123, Lima',
      telefono: '+51 987 654 321',
    ),
    Cliente(
      nombreRazonSocial: 'Proveedor 2 S.A.C.',
      documento: 'RUC 98765432109',
      tipoCliente: 'Proveedor',
      direccion: 'Calle Industria 456, Lima',
      telefono: '+51 912 345 678',
    ),
    Cliente(
      nombreRazonSocial: 'Proveedores Unidos S.A.',
      documento: 'RUC 13579246801',
      tipoCliente: 'Proveedor',
      direccion: 'Av. Comercio 789, Lima',
      telefono: '+51 964 738 572',
    ),
    Cliente(
      nombreRazonSocial: 'Distribuidora XYZ S.A.',
      documento: 'RUC 24680135709',
      tipoCliente: 'Proveedor',
      direccion: 'Calle Distribuidores 321, Lima',
      telefono: '+51 955 662 134',
    ),
    Cliente(
      nombreRazonSocial: 'Proveedor Global S.A.C.',
      documento: 'RUC 36925814706',
      tipoCliente: 'Proveedor',
      direccion: 'Av. Global 159, Lima',
      telefono: '+51 986 474 923',
    ),
  ];

  DateTime? _startDate;
  DateTime? _endDate;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _con.init(context, refresh);
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const WidgetMenu(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildComprasTab(),
          _buildInventoryTab()
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Compra/Almacén',
        style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
      ),
      backgroundColor: Colors.indigoAccent,
      bottom: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Compras'),
          Tab(text: 'Almacén'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.download),
          onPressed: () => _showExportDialog(),
          tooltip: 'Exportar a Excel',
        ),
      ],
    );
  }
  Widget _buildInventoryTab() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DatePickerWidget(
                          label: 'Fecha inicio',
                          selectedDate: _startDate,
                          onDateSelected: (date) {
                            setState(() {
                              _startDate = date;
                            });
                            _con.filterByDateRange(_startDate, _endDate);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DatePickerWidget(
                          label: 'Fecha fin',
                          selectedDate: _endDate,
                          onDateSelected: (date) {
                            setState(() {
                              _endDate = date;
                            });
                            _con.filterByDateRange(_startDate, _endDate);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _con.filteredInventory.isEmpty
                    ? const Center(child: Text('No se encontraron resultados'))
                    : ListView.builder(
                  itemCount: _con.filteredInventory.length,
                  itemBuilder: (context, index) {
                    final item = _con.filteredInventory[index];
                    return _buildInventoryItem(item, constraints.maxWidth);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildComprasTab() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _con.searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar compra',
                      hintText: 'Número o proveedor',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DatePickerWidget(
                          label: 'Fecha inicio',
                          selectedDate: _startDate,
                          onDateSelected: (date) {
                            setState(() {
                              _startDate = date;
                            });
                            _con.filterByDateRange(_startDate, _endDate);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DatePickerWidget(
                          label: 'Fecha fin',
                          selectedDate: _endDate,
                          onDateSelected: (date) {
                            setState(() {
                              _endDate = date;
                            });
                            _con.filterByDateRange(_startDate, _endDate);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _con.filteredCompra.isEmpty
                    ? const Center(child: Text('No se encontraron resultados'))
                    : ListView.builder(
                  itemCount: _con.filteredCompra.length,
                  itemBuilder: (context, index) {
                    final item = _con.filteredCompra[index];
                    return _buildCompraItem(item, constraints.maxWidth);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _buildInventoryItem(dynamic item, double maxWidth) {
    final isSmallScreen = maxWidth < 600;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Implementar la lógica para editar el producto aquí
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Información de Compra
                            Expanded(
                              child: Text(
                                'N°: ${item.numero}',
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Información de Origen
                            Expanded(
                              child: Text(
                                'Origen: ${item.origen ?? "No especificado"}',
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end, // Alinear texto al extremo derecho
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Usuario: ${item.usuario}',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Fecha: ${item.fecha}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Tipo: ${item.tipo}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSmallScreen) _buildPopupMenu(item),
                ],
              ),
              if (!isSmallScreen)
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildPopupMenu(item),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompraItem(dynamic item, double maxWidth) {
    final isSmallScreen = maxWidth < 600;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Implementar la lógica para editar el producto aquí
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Compra ${item.numeroCompra}',
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Proveedor: ${item.proveedor}',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Fecha: ${item.fecha}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Total: S/ ${item.total?.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSmallScreen) _buildPopupMenu(item),
                ],
              ),
              if (!isSmallScreen)
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildPopupMenu(item),
                ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildPopupMenu(dynamic item) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        if (result == 'editar') {
          _showConfirmationDialog('Editar', item.numeroCompra);
        } else if (result == 'anular') {
          _showConfirmationDialog('Anular', item.numeroCompra);
        }
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'editar',
          child: Text('Editar'),
        ),
        const PopupMenuItem(
          value: 'anular',
          child: Text('Anular'),
        ),
      ],
      icon: const Icon(Icons.more_vert),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        if (_tabController.index == 0) {
          _con.addCompra(context, false);
        } else {
          _con.addAlmacen(context,false);
        }

      },
      tooltip: _tabController.index == 0 ? 'Agregar Producto' : 'Agregar Categoría',
      child: const Icon(Icons.add),
    );
  }

  void _showExportDialog() {
    MessageDownload.showConfirmationDialog(
      context: context,
      action: 'Exportar en excel',
      isDownload: true,
      onConfirm: () {
        // Implementar lógica de exportación
      },
    );
  }

  void _showConfirmationDialog(String action, String itemName) {
    MessageDownload.showConfirmationDialog(
      context: context,
      action: action,
      itemName: itemName,
      isDownload: false,
      onConfirm: () {
        // Implementar lógica de edición o anulación
      },
    );
  }

  void refresh() {
    setState(() {});
  }
}