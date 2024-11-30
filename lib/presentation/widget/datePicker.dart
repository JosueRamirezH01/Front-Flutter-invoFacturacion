import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime?) onDateSelected;

  const DatePickerWidget({
    Key? key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (selectedDate == null) {
          // Si no hay una fecha seleccionada, abre el selector de fechas
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (picked != null && picked != selectedDate) {
            onDateSelected(picked);
          }
        } else {
          // Si hay una fecha seleccionada, permite limpiar la fecha
          onDateSelected(null);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: selectedDate != null
                        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                        : 'Seleccionar fecha', // Texto de fecha o 'Seleccionar fecha'
                    style: TextStyle(
                      fontSize: selectedDate != null ? 14 : 12, // Tamaño de texto dinámico
                      color: selectedDate != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selectedDate == null ? Icons.calendar_today : Icons.clear,
              color: selectedDate == null ? null : Colors.red, size: 17,
            ),
          ],
        ),
      ),
    );
  }
}
