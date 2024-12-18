import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:invefacturacion/presentation/home/venta/venta_controller.dart';
import 'package:invefacturacion/presentation/widget/menu_drawer.dart';

import '../../widget/datePicker.dart';
import 'nueva_venta/nueva_venta_page.dart';

class VentaPage extends StatefulWidget {
  const VentaPage({super.key});

  @override
  State<VentaPage> createState() => _VentaPageState();
}

class _VentaPageState extends State<VentaPage> {
  final VentaController _con = VentaController();
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VENTAS'),
        elevation: 4,
        actions: [
          TextButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red)
            ),
              onPressed: (){
            _agregarNuevaVenta();
          },
              child: const Text('Nueva venta', style: TextStyle(color: Colors.white),))
        ],
      ),
      drawer: const WidgetMenu(),
      body: _buildBody(),
    );
  }
  void _agregarNuevaVenta() async {
    final nuevaVenta = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FractionallySizedBox(
        heightFactor: 0.98,
        child: NuevaVentaPage(),
      ),
    );

    if (nuevaVenta != null) {
      setState(() {
        //_con.ventas.add(nuevaVenta);
      });
    }
  }
  Widget _buildBody(){
    return LayoutBuilder(
        builder: (context,constrains){
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
                         // _con.filterByDateRange(_startDate, _endDate);
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
                         // _con.filterByDateRange(_startDate, _endDate);
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
                child: _buildVentasList(),
              )
          )
        ],
      );
    });
  }
  Widget _buildVentasList() {
    return ListView.builder(
      itemCount: _con.ventas.length,
      itemBuilder: (context, index) {
        final venta = _con.ventas[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text('${venta['cliente']} - ${venta['id']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total: \$${(venta['total'] as num).toStringAsFixed(2)}'),
                Text('Fecha: ${venta['fecha']}'),
                Text('Doc: ${venta['doc']} - Usuario: ${venta['usuario']}'),
              ],
            ),
            leading: Icon(
              venta['pagado'] == true ? Icons.check_circle : Icons.cancel,
              color: venta['pagado'] == true ? Colors.green : Colors.red,
            ),
            trailing: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (String result) {
                switch (result) {
                  case 'imprimir':
                    print('Imprimir venta: ${venta['id']}');
                    // Implementa la lógica de impresión aquí
                    break;
                  case 'descargar':
                    print('Descargar venta: ${venta['id']}');
                    // Implementa la lógica de descarga aquí
                    break;
                  case 'ver':
                    print('Ver detalles de venta: ${venta['id']}');
                    // Implementa la lógica para ver detalles aquí
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'imprimir',
                  child: ListTile(
                    leading: Icon(Icons.print),
                    title: Text('Imprimir'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'descargar',
                  child: ListTile(
                    leading: Icon(Icons.download),
                    title: Text('Descargar'),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'ver',
                  child: ListTile(
                    leading: Icon(Icons.visibility),
                    title: Text('Ver'),
                  ),
                ),
              ],
            ),
            onTap: () {
              print('Venta seleccionada: ${venta['id']}');
            },
          ),
        );
      },
    );
  }

  void refresh() {
    setState(() {});
  }
}
