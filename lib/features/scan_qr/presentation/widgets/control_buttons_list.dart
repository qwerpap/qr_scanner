import 'package:flutter/material.dart';
import 'package:qr_scanner/features/scan_qr/data/models/control_button_model.dart';
import 'package:qr_scanner/features/scan_qr/presentation/widgets/control_button.dart';

class ControlButtonsList extends StatelessWidget {
  const ControlButtonsList({super.key, required this.buttons});

  final List<ControlButtonModel> buttons;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: buttons.length,
          separatorBuilder: (context, index) => const SizedBox(width: 32),
          itemBuilder: (context, index) {
            return ControlButton(model: buttons[index]);
          },
        ),
      ),
    );
  }
}
