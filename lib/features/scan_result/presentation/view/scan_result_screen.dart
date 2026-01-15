import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/custom_app_bar.dart';
import 'package:qr_scanner/core/shared/widgets/custom_divider.dart';
import 'package:qr_scanner/core/utils/time_formatter.dart';
import 'package:qr_scanner/features/scan_result/domain/entities/qr_code_type.dart';
import 'package:qr_scanner/features/scan_result/presentation/bloc/scan_result_bloc.dart';
import 'package:qr_scanner/features/scan_result/presentation/bloc/scan_result_event.dart';
import 'package:qr_scanner/features/scan_result/presentation/bloc/scan_result_state.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/action_buttons_row.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/full_content_card.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/open_link_button.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/qr_code_info_card.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/qr_code_metadata.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/scan_success_header.dart';
import 'package:qr_scanner/core/ads/presentation/cubit/ads_cubit.dart';

class ScanResultScreen extends StatefulWidget {
  final String qrData;

  const ScanResultScreen({super.key, required this.qrData});

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  bool _hasShownInterstitial = false;

  @override
  void initState() {
    super.initState();
    // Показываем interstitial рекламу после небольшой задержки
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && !_hasShownInterstitial) {
          _hasShownInterstitial = true;
          context.read<AdsCubit>().showInterstitialAd();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ScanResultBloc>()..add(ScanResultInitialized(widget.qrData)),
      child: Scaffold(
        appBar: CustomAppBar(title: context.l10n.scanResult, showCloseButton: true),
        body: BlocBuilder<ScanResultBloc, ScanResultState>(
          builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null && state.qrCodeData == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${context.l10n.error}: ${state.errorMessage}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.pop(),
                        child: Text(context.l10n.goBack),
                      ),
                    ],
                  ),
                );
              }

              final qrCodeData = state.qrCodeData;
              if (qrCodeData == null) {
                return Center(child: Text(context.l10n.noQrCodeData));
              }

              final scannedTime = TimeFormatter.formatScannedTime(
                qrCodeData.scannedAt,
                context.l10n,
              );

              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 22,
                ),
                children: [
                  const ScanSuccessHeader(),
                  const SizedBox(height: 21),
                  BaseContainer(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        QrCodeInfoCard(
                          title: qrCodeData.displayTitle,
                          url: qrCodeData.displayUrl,
                          iconPath: qrCodeData.type.iconPath,
                        ),
                        const CustomDivider(),
                        FullContentCard(content: qrCodeData.rawData),
                        const CustomDivider(),
                        QrCodeMetadata(
                          scannedTime: scannedTime,
                          type: qrCodeData.type.displayName,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 21),
                  if (qrCodeData.type == QrCodeType.url)
                    OpenLinkButton(
                      onPressed: state.isSaving
                          ? null
                          : () {
                              context.read<ScanResultBloc>().add(
                                const ScanResultOpenLinkRequested(),
                              );
                            },
                    ),
                  if (qrCodeData.type == QrCodeType.url)
                    const SizedBox(height: 13),
                  ActionButtonsRow(
                    onCopy: state.isSaving
                        ? null
                        : () {
                            context.read<ScanResultBloc>().add(
                              const ScanResultCopyRequested(),
                            );
                          },
                    onShare: state.isSaving
                        ? null
                        : () {
                            context.read<ScanResultBloc>().add(
                              const ScanResultShareRequested(),
                            );
                          },
                    onSave: state.isSaving
                        ? null
                        : () {
                            context.read<ScanResultBloc>().add(
                              const ScanResultSaveRequested(),
                            );
                          },
                    isSaving: state.isSaving,
                    isSaved: state.isSaved,
                  ),
                ],
              );
          },
        ),
      ),
    );
  }
}
