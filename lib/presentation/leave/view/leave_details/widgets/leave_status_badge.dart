import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LeaveStatusBadge extends StatelessWidget {
  const LeaveStatusBadge({super.key, required this.status, this.colorCode, this.isCancelled = false});

  final LeaveStatusEnum? status;
  final String? colorCode;
  final bool isCancelled;

  Color _statusColor() {
    if (isCancelled || status == LeaveStatusEnum.canceled) {
      return Colors.red;
    }
    if (colorCode != null) {
      final parsed = int.tryParse(colorCode!);
      if (parsed != null) return Color(parsed);
    }
    switch (status) {
      case LeaveStatusEnum.approved:
        return Colors.green;
      case LeaveStatusEnum.rejected:
        return Colors.red;
      case LeaveStatusEnum.pending:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        isCancelled ? 'Cancelled' : status?.status ?? '',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
