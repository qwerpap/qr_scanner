import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/core/shared/widgets/custom_text_field.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_cubit.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_state.dart';

class WebsiteUrlSection extends StatelessWidget {
  const WebsiteUrlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateQrCodeCubit, CreateQrCodeState>(
      buildWhen: (previous, current) => previous.urlData != current.urlData,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.websiteUrl, style: AppFonts.titleMedium),
            const SizedBox(height: 11),
            CustomTextField(
              hintText: 'https://example.com',
              initialValue: state.urlData,
              onChanged: (value) {
                context.read<CreateQrCodeCubit>().updateUrlData(value);
              },
            ),
          ],
        );
      },
    );
  }
}
