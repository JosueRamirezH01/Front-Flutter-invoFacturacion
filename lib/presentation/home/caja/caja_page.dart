import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:invefacturacion/presentation/home/caja/caja_controller.dart';
import 'package:invefacturacion/presentation/widget/menu_drawer.dart';

class CajaPage extends StatefulWidget {
  const CajaPage({super.key});

  @override
  State<CajaPage> createState() => _CajaPageState();
}

class _CajaPageState extends State<CajaPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CajaController _con = CajaController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      refresh();
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
      appBar: AppBar(
        title: const Text('Gestión de Caja'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Apertura de Caja'),
            Tab(text: 'Historial'),
          ],
        ),
      ),
      drawer: const WidgetMenu(),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Pestaña de Apertura de Caja
          _con.cajaActivada ? cajaAbierta(dialog: true) : cajaCerrada(),
          // Pestaña de Historial (placeholder o implementación futura)
          cajaHistorial()
        ],
      ),
    );
  }

  Widget cajaCerrada() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Image(image: AssetImage('assets/img/box1.png'), width: 100, height: 100),
            const Center(child: Text('NO HAY CAJA ABIERTA',style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                onPressed: () {
                  _con.abrirCajaDialogo();
                },
                child: const Text('Abrir caja', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cajaAbierta( {Map<String, dynamic>? movimiento, bool? dialog}) {
    return SingleChildScrollView(
      child: Padding(
        padding: dialog != null && dialog == true
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            movimiento?['active'] == true
                ? const Text(
              'Caja Abierta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
                : Text(
              'Reporte de caja ${movimiento?['apertura'] ?? 'Sin datos disponibles'}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Fecha y Hora de Apertura: ${_con.fechaApertura != null ? DateFormat('dd/MM/yyyy HH:mm:ss').format(_con.fechaApertura!) : 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Monto Inicial: S/. ${_con.montoInicial.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 20),
            ExpansionTile(
              title: const Text('Ventas'),
              children: [
                ..._con.ventas.map((venta) {
                  return ListTile(
                    title: Text(venta['metodo']),
                    trailing: Text('S/. ${venta['monto'].toStringAsFixed(2)}'),
                  );
                }).toList(),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Total Ventas',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    'S/. ${_con.calcularTotal(_con.ventas).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: const Text('Cobros'),
              children: [
                ..._con.cobros.map((cobro) {
                  return ListTile(
                    title: Text(cobro['metodo']),
                    trailing: Text('S/. ${cobro['monto'].toStringAsFixed(2)}'),
                  );
                }).toList(),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Total Cobros',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    'S/. ${_con.calcularTotal(_con.cobros).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: const Text('Total General'),
              children: [
                ..._con.calcularTotalesPorMetodo().entries.map((entry) {
                  return ListTile(
                    title: Text('Total ${entry.key}'),
                    trailing: Text(
                      'S/. ${entry.value.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Total General',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    'S/. ${_con.calcularTotalGeneral().toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (movimiento?['active'] == true)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                setState(() {
                  _con.desactivarCaja();
                });
              },
              child: const Text(
                'Cerrar Caja',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cajaHistorial() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: _con.historialMovimientos.length,
        itemBuilder: (context, index) {
          var movimiento = _con.historialMovimientos[index];
          return GestureDetector(
            onTap: (){
              abrirCajaHistorial(movimiento);
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Apertura: ${movimiento['apertura']}'),
                subtitle: Text('Cierre: ${movimiento['cierre']}'),
              ),
            ),
          );
        },
      ),
    );
  }
  void refresh() {
    setState(() {});
  }
  void abrirCajaHistorial(Map<String, dynamic> movimiento) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        builder: (BuildContext context) {
      return GestureDetector(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.82,
            child: cajaAbierta(movimiento: movimiento, dialog: true),
          )
      );
    }
    );
  }
}


