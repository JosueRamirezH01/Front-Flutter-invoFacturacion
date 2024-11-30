import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:invefacturacion/presentation/home/gasto/gasto_controller.dart';
import 'package:invefacturacion/presentation/widget/menu_drawer.dart';

import '../../widget/datePicker.dart';
import '../../widget/message_download.dart';
class GastosPage extends StatefulWidget {
  const GastosPage({super.key});

  @override
  State<GastosPage> createState() => _GastosPageState();
}

class _GastosPageState extends State<GastosPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  final GastosController _con = GastosController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gastos',
            style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis),
          ),
          backgroundColor: Colors.indigoAccent,
        ),
        drawer: WidgetMenu(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
    ),
    );
  }


  Widget _buildBody(){
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
                        labelText: 'Buscar gasto',
                        hintText: 'Nombre',
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
                  child: _con.filteredGasto.isEmpty
                      ? const Center(child: Text('No se encontraron resultados'))
                      : ListView.builder(
                    itemCount: _con.filteredGasto.length,
                    itemBuilder: (context, index) {
                      final item = _con.filteredGasto[index];
                      return _buildGastoItem(item, constraints.maxWidth);
                    },
                  ),
                ),
              ),
            ],
          );
    }
    );
  }


  Widget _buildGastoItem(dynamic item, double maxWidth) {
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
                          '${item.descripcion}',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleMedium,
                          //overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'usuario: ${item.usuario}',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Fecha: ${item.fecha}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Total: S/ ${item.monto?.toStringAsFixed(2)}',
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

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _con.addGasto(context,false);
      },
      child: const Icon(Icons.add),
    );
  }

  void refresh(){
    setState(() {});
  }
}
