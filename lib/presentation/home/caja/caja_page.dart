import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(image: AssetImage('assets/img/box1.png'),width: 100, height: 100, ),
                Center(child: Text('NO HAY CAJA ABIERTA'))
              ],
            ),
          ),
          // Pestaña de Historial
          //const HistorialMovimientos(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );
  }

  void refresh(){
    setState(() {});
  }

}


