import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_text_field.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_cubit.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_state.dart';

class TextInputSection extends StatelessWidget {
  const TextInputSection({super.key, this.isContact = false});

  final bool isContact;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateQrCodeCubit, CreateQrCodeState>(
      buildWhen: (previous, current) =>
          previous.textData != current.textData ||
          previous.selectedTypeId != current.selectedTypeId,
      builder: (context, state) {
        final isContactType = state.selectedTypeId == 'contact';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isContactType ? 'Contact Name' : 'Text',
              style: AppFonts.titleMedium,
            ),
            const SizedBox(height: 11),
            CustomTextField(
              hintText: isContactType ? 'Enter contact name...' : 'Enter text...',
              initialValue: state.textData,
              showLinkIcon: false,
              onChanged: (value) {
                context.read<CreateQrCodeCubit>().updateTextData(value);
              },
            ),
          ],
        );
      },
    );
  }
}
