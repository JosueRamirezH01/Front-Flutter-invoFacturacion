import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invefacturacion/presentation/widget/menu_drawer.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.indigoAccent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Implementar visualización de notificaciones
            },
          ),
        ],
      ),
      drawer: WidgetMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCards(),
              SizedBox(height: 24),
              _buildSalesVsExpensesChart(),
              SizedBox(height: 24),
              _buildMonthlySalesChart(),
              SizedBox(height: 24),
              _buildTopProductsTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth > 600
            ? _buildWideCards()
            : _buildNarrowCards();
      },
    );
  }

  Widget _buildWideCards() {
    return Row(
      children: [
        Expanded(child: _buildCard('Ventas', '\$15,230', Icons.attach_money, Colors.blue)),
        SizedBox(width: 16),
        Expanded(child: _buildCard('Gastos', '\$8,340', Icons.shopping_bag, Colors.red)),
        SizedBox(width: 16),
        Expanded(child: _buildCard('Ganancias', '\$6,890', Icons.trending_up, Colors.green)),
        SizedBox(width: 16),
        Expanded(child: _buildCard('Productos', '1,234', Icons.inventory, Colors.orange)),
      ],
    );
  }

  Widget _buildNarrowCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildCard('Ventas', 'S/.15,230', Icons.attach_money, Colors.blue)),
            SizedBox(width: 16),
            Expanded(child: _buildCard('Gastos', 'S/.8,340', Icons.shopping_bag, Colors.red)),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildCard('Ganancias', 'S/.6,8900', Icons.trending_up, Colors.green)),
            SizedBox(width: 16),
            Expanded(child: _buildCard('Productos', '1,239', Icons.inventory, Colors.orange)),
          ],
        ),
      ],
    );
  }

  Widget _buildCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesVsExpensesChart() {
    return _buildChartCard(
      'Ventas vs Gastos (Anual)',
      AspectRatio(
        aspectRatio: 1.7,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20000,
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(fontSize: 10);
                    String text;
                    switch (value.toInt()) {
                      case 0: text = 'Ene'; break;
                      case 1: text = 'Feb'; break;
                      case 2: text = 'Mar'; break;
                      case 3: text = 'Abr'; break;
                      case 4: text = 'May'; break;
                      case 5: text = 'Jun'; break;
                      case 6: text = 'Jul'; break;
                      case 7: text = 'Ago'; break;
                      case 8: text = 'Sep'; break;
                      case 9: text = 'Oct'; break;
                      case 10: text = 'Nov'; break;
                      case 11: text = 'Dic'; break;
                      default: text = '';
                    }
                    return SideTitleWidget(
                      child: Text(text, style: style),
                      axisSide: meta.axisSide,
                      angle: 45,
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text('\$${value.toInt()}', style: TextStyle(fontSize: 10)),
                    );
                  },
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 5000,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey[300],
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(show: false),
            barGroups: [
              _makeSalesExpensesGroupData(0, 15000, 8000),
              _makeSalesExpensesGroupData(1, 14000, 9000),
              _makeSalesExpensesGroupData(2, 16000, 8500),
              _makeSalesExpensesGroupData(3, 13000, 7500),
              _makeSalesExpensesGroupData(4, 17000, 9500),
              _makeSalesExpensesGroupData(5, 19000, 10000),
              _makeSalesExpensesGroupData(6, 18000, 9000),
              _makeSalesExpensesGroupData(7, 16500, 8500),
              _makeSalesExpensesGroupData(8, 14500, 7000),
              _makeSalesExpensesGroupData(9, 15500, 8000),
              _makeSalesExpensesGroupData(10, 17500, 9500),
              _makeSalesExpensesGroupData(11, 19500, 10500),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTopProductsTable() {
    final List<Map<String, dynamic>> topProducts = [
      {'name': 'Producto A', 'quantity': 150, 'revenue': '\$3,000'},
      {'name': 'Producto B', 'quantity': 120, 'revenue': '\$2,400'},
      {'name': 'Producto C', 'quantity': 100, 'revenue': '\$2,000'},
      {'name': 'Producto D', 'quantity': 80, 'revenue': '\$1,600'},
      {'name': 'Producto E', 'quantity': 60, 'revenue': '\$1,200'},
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Productos Más Vendidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Cantidad')),
                  DataColumn(label: Text('Ingresos')),
                ],
                rows: topProducts.map((product) {
                  return DataRow(cells: [
                    DataCell(Text(product['name'])),
                    DataCell(Text(product['quantity'].toString())),
                    DataCell(Text(product['revenue'])),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            chart,
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeSalesExpensesGroupData(int x, double sales, double expenses) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: sales,
          color: Colors.blue,
          width: 8,
        ),
        BarChartRodData(
          toY: expenses,
          color: Colors.red,
          width: 8,
        ),
      ],
    );
  }


  Widget _buildMonthlySalesChart() {
    final currentMonth = DateFormat('MMMM yyyy').format(DateTime.now());

    return _buildChartCard(
      'Ventas de $currentMonth ',
      Column(
        children: [
          AspectRatio(
            aspectRatio: 1.7,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50000,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    // tooltipBgColor: Colors.blueGrey,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String typeName;
                      switch(group.x) {
                        case 0: typeName = 'Boletas'; break;
                        case 1: typeName = 'Facturas'; break;
                        case 2: typeName = 'Notas de Venta'; break;
                        default: typeName = '';
                      }
                      return BarTooltipItem(
                        '$typeName\nS/ ${rod.toY.round()}',
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(fontSize: 12);
                        String text;
                        switch (value.toInt()) {
                          case 0: text = 'Boletas'; break;
                          case 1: text = 'Facturas'; break;
                          case 2: text = 'Notas de Venta'; break;
                          default: text = '';
                        }
                        return SideTitleWidget(
                          child: Text(text, style: style),
                          axisSide: meta.axisSide,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 60,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text('S/ ${value.toInt()}', style: TextStyle(fontSize: 12)),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 30000,
                        color: Colors.blue,
                        width: 60,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 45000,
                        color: Colors.green,
                        width: 60,
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 15000,
                        color: Colors.orange,
                        width: 60,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }




}