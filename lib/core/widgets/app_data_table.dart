import 'package:flutter/material.dart';

class AppDataTable extends StatelessWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<DataColumn> columns;
  final List<DataRow> rows;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) {
        // Calculate column spacing to fill available width
        // Reserve space for first column (Date) and last column content
        const reservedSpace = 300.0; // Space for date column and some padding
        final availableSpace = constraints.maxWidth - reservedSpace;
        final columnSpacing = columns.length > 1 
            ? availableSpace / (columns.length - 1)
            : 24.0;
        
        return SizedBox(
          width: constraints.maxWidth,
          child: DataTable(
            columns: columns,
            rows: rows,
            columnSpacing: columnSpacing.clamp(24.0, double.infinity),
            // You can add more customization here
            // For example:
            // headingRowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
            // dataRowColor: MaterialStateProperty.all(Theme.of(context).colorScheme.surface),
            // dividerThickness: 1,
          ),
        );
      },
    );
}
