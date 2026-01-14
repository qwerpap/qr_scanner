import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_cubit.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_state.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/content_type_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/design_options_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/text_input_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/website_url_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/wifi_button.dart';
import 'package:qr_scanner/features/my_qr_codes/domain/models/created_qr_code_model.dart';

class CreateQrCodeScreen extends StatelessWidget {
  const CreateQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    CreatedQrCodeModel? editingQrCode;
    
    if (extra is Map<String, dynamic>) {
      editingQrCode = extra['qrCode'] as CreatedQrCodeModel?;
    }

    return BlocProvider(
      create: (context) {
        final cubit = getIt<CreateQrCodeCubit>();
        if (editingQrCode != null) {
          cubit.initializeForEditing(editingQrCode);
        }
        return cubit;
      },
      child: Scaffold(
        body: BlocConsumer<CreateQrCodeCubit, CreateQrCodeState>(
          listener: (context, state) {
            if (state.generatedQrCode != null) {
              final cubit = context.read<CreateQrCodeCubit>();
              context.go('/qr_code_ready', extra: cubit);
            }
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  title: editingQrCode != null ? 'Edit QR Code' : 'Create QR Code',
                  showCloseButton: true,
                  showDivider: false,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      ContentTypeSection(
                        selectedTypeId: state.selectedTypeId,
                        onTypeSelected: (typeId) {
                          context
                              .read<CreateQrCodeCubit>()
                              .changeContentType(typeId);
                        },
                      ),
                      const SizedBox(height: 24),
                      if (state.selectedTypeId != 'wifi') ...[
                        if (state.selectedTypeId == 'url')
                          const WebsiteUrlSection()
                        else if (state.selectedTypeId == 'text')
                          const TextInputSection()
                        else if (state.selectedTypeId == 'contact')
                          const TextInputSection(isContact: true),
                        const SizedBox(height: 40),
                      ] else
                        const WifiButton(),
                      const SizedBox(height: 17.5),
                      const DesignOptionsSection(),
                      const SizedBox(height: 17),
                      CustomElevatedButton(
                        onPressed: () {
                          context
                              .read<CreateQrCodeCubit>()
                              .generateQrCode();
                        },
                        title: state.editingQrCodeId != null
                            ? 'Update QR Code'
                            : 'Generate QR Code',
                      ),
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
