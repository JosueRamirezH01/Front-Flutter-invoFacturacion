import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:invefacturacion/presentation/home/producto/producto_controller.dart';
import 'package:invefacturacion/presentation/widget/menu_drawer.dart';
import 'package:invefacturacion/presentation/widget/message_download.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool editProducto = false;
  bool editCategoria = false;
  final ProductoController  _con = ProductoController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuilds the FloatingActionButton based on the tab index
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _con.searchController.dispose();
    _con.nombreCategoria.dispose();
    _con.productNameController.dispose();
    _con.quantityController.dispose();
    _con.priceController.dispose();
    _con.discountSolesController.dispose();
    _con.discountPercentageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos/Categorias', overflow: TextOverflow.fade, style: TextStyle(fontSize: 21)),
        backgroundColor: Colors.indigoAccent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Productos'),
            Tab(text: 'Categorías'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.download),
            onPressed: () {
                MessageDownload.showConfirmationDialog(context: context, action: 'Exportar en excel', isDownload: true,onConfirm: (){});


            },
          ),
        ],
      ),
      drawer: const WidgetMenu(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildProductosTab(),
          _buildCategoriasTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            editProducto = false;
            editCategoria = false;
          });
          if (_tabController.index == 0) {
            _con.addProduct(context,editProducto, '');
          } else {
            _con.addCategory(context,editCategoria);
          }
        },
        child: const Icon(Icons.add),
        tooltip: _tabController.index == 0 ? 'Agregar Producto' : 'Agregar Categoría',
      ),
    );
  }

  Widget _buildProductosTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _con.searchController,
            decoration: const InputDecoration(
              labelText: 'Buscar producto',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _con.selectedCategory,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _con.selectedCategory = newValue;
                  });
                }
              },
              items: _con.categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _con.filteredInventory.length,
            itemBuilder: (context, index) {
              final item = _con.filteredInventory[index];
              return InkWell(
                onTap: () {
                  print('Producto presionado: ${item.name}');
                  setState(() {
                    editProducto = true;
                  });
                  _con.addProduct(context,editProducto , '');
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Contenedor de título y subtítulo
                        Expanded(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(item.name!),
                            subtitle: Text('Categoría: ${item.category}'),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Cantidad: ${item.quantity}'),
                                Text('Precio: S/ ${item.price?.toStringAsFixed(2)}'),
                              ],
                            ),
                            const SizedBox(width: 8), // Espacio entre columna y menú
                            PopupMenuButton<String>(
                              onSelected: (String result) {
                                if (result == 'deshabilitar') {

                                  MessageDownload.showConfirmationDialog(context: context, action: 'Deshabilitar', itemName: item.name, isDownload: false, onConfirm: (){});

                                } else if (result == 'editar') {
                                  MessageDownload.showConfirmationDialog(context: context, action: 'Editar', itemName : item.name, isDownload: false,onConfirm: (){});

                                } else if (result == 'eliminar') {
                                  MessageDownload.showConfirmationDialog(context: context, action: 'eliminar',itemName : item.name, isDownload: false,onConfirm: (){});

                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem(
                                  value: 'deshabilitar',
                                  child: Text('Deshabilitar'),
                                ),
                                const PopupMenuItem(
                                  value: 'editar',
                                  child: Text('Editar'),
                                ),
                                const PopupMenuItem(
                                  value: 'eliminar',
                                  child: Text('Eliminar'),
                                ),
                              ],
                              icon: const Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriasTab() {
    return ListView.builder(
      itemCount: _con.categoriesWithDetails.length,
      itemBuilder: (context, index) {
        final category = _con.categoriesWithDetails[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(category['name']),
            subtitle: Text('Código: ${category['code']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(
                  value: category['enabled'],
                  onChanged: (bool value) {
                    setState(() {
                      category['enabled'] = value;
                    });
                  },
                ),
                if (category['enabled'])
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        editCategoria = true;
                      });
                      _con.addCategory(context,editCategoria);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }




  void refresh(){
    setState(() {});
  }
}
