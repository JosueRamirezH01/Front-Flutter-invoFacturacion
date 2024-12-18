import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:invefacturacion/presentation/widget/menu_drawer.dart';



class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({super.key});
  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}
  class _ResponsiveLayoutState extends State<ResponsiveLayout> {
    bool useNotificationDotOnAppIcon = false;
    @override
    Widget build(BuildContext context) {
      // Usamos LayoutBuilder para adaptarnos a los tamaños disponibles
      return LayoutBuilder(
        builder: (context, constraints) {
          // Obtenemos el ancho de la pantalla
          double screenWidth = constraints.maxWidth;

          // Móvil: Pantalla pequeña (menos de 600px)
          // Tableta: Pantalla mediana (600px - 1200px)
          // Web: Pantalla grande (más de 1200px)
          if (screenWidth < 600) {
            // Diseño para móvil
            return Scaffold(
              appBar: AppBar(title: const Text("Móvil")),
              drawer: WidgetMenu(),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    // User card
                    BigUserCard(
                      backgroundColor:Colors.red ,
                      userName: "Babacar Ndong",
                      userProfilePic: AssetImage("assets/img/perfil.png"),
                      cardActionWidget: SettingsItem(
                        icons: Icons.edit,
                        iconStyle: IconStyle(
                          withBackground: true,
                          borderRadius: 50,
                          backgroundColor: Colors.yellow[600],
                        ),
                        title: "Modify",
                        subtitle: "Tap to change your data",
                        onTap: () {
                          print("OK");
                        },
                      ),
                    ),
                    SettingsGroup(
                      items: [
                        SettingsItem(
                          onTap: () {},
                          icons: CupertinoIcons.pencil_outline,
                          iconStyle: IconStyle(),
                          title: 'Appearance',
                          subtitle: "Make Ziar'App yours",
                        ),
                        SettingsItem(
                          onTap: () {},
                          icons: Icons.dark_mode_rounded,
                          iconStyle: IconStyle(
                            iconsColor: Colors.white,
                            withBackground: true,
                            backgroundColor: Colors.red,
                          ),
                          title: 'Dark mode',
                          subtitle: "Automatic",
                          trailing: Switch.adaptive(
                            value: useNotificationDotOnAppIcon,
                            onChanged: (value) {
                              setState(() {
                                useNotificationDotOnAppIcon = value; // Asignar correctamente
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SettingsGroup(
                      items: [
                        SettingsItem(
                          onTap: () {},
                          icons: Icons.print,
                          iconStyle: IconStyle(
                            backgroundColor: Colors.purple,
                          ),
                          title: 'Impresoras',
                        ),
                      ],
                    ),
                    // You can add a settings title
                    SettingsGroup(
                      settingsGroupTitle: "Account",
                      items: [
                        SettingsItem(
                          onTap: () {},
                          icons: Icons.exit_to_app_rounded,
                          title: "Sign Out",
                        ),
                        SettingsItem(
                          onTap: () {},
                          icons: CupertinoIcons.delete_solid,
                          title: "Delete account",
                          titleStyle: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (screenWidth < 1200) {
            // Diseño para tableta
            return Scaffold(
              appBar: AppBar(title: const Text("Tableta")),
              body: Center(child: Text("Vista para tableta")),
            );
          } else {
            // Diseño para web
            return Scaffold(
              appBar: AppBar(title: const Text("Web")),
              body: Center(child: Text("Vista para web")),
            );
          }
        },
      );
    }
  }

