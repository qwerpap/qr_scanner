import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';
import 'package:qr_scanner/core/shared/widgets/custom_notification.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_cubit.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_state.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/qr_ready_action_buttons.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/success_header.dart';
import 'package:qr_scanner/features/my_qr_codes/domain/usecases/save_created_qr_code_usecase.dart';

class QrCodeReadyScreen extends StatelessWidget {
  const QrCodeReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateQrCodeCubit, CreateQrCodeState>(
      builder: (context, state) {
        if (state.generatedQrCode == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No QR code generated'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        final qrCode = state.generatedQrCode!;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(
                title: 'Create QR Code',
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
                    const SuccessHeader(),
                    const SizedBox(height: 27),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: QrImageView(
                          data: qrCode.rawData,
                          version: QrVersions.auto,
                          size: 200,
                          backgroundColor: AppColors.whiteColor,
                          foregroundColor: qrCode.color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (state.isSaved)
                      // QR code already saved, show only share button
                      QrReadyActionButtons(
                        onShareTap: () async {
                          try {
                            await Share.share(qrCode.rawData);
                          } catch (_) {
                            // ignore
                          }
                        },
                        onSaveTap: () {
                          // Already saved, do nothing
                        },
                        showSaveButton: false,
                      )
                    else
                      // QR code not saved yet, show both buttons
                      QrReadyActionButtons(
                        onShareTap: () async {
                          try {
                            await Share.share(qrCode.rawData);
                          } catch (_) {
                            // ignore
                          }
                        },
                        onSaveTap: () async {
                          try {
                            final saveUseCase = getIt<SaveCreatedQrCodeUseCase>();
                            await saveUseCase(qrCode);
                            
                            // Update state to reflect that QR code is saved
                            context.read<CreateQrCodeCubit>().markAsSaved();
                            
                            if (context.mounted) {
                              CustomNotification.show(
                                context: context,
                                message: 'QR code saved successfully',
                                isError: false,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              CustomNotification.show(
                                context: context,
                                message: 'Error saving QR code: ${e.toString()}',
                                isError: true,
                              );
                            }
                          }
                        },
                        showSaveButton: true,
                      ),
                    const SizedBox(height: 40),
                    CustomElevatedButton(
                      onPressed: () {
                        context.go('/my_qr_codes');
                      },
                      title: 'Go to My QR Codes',
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
