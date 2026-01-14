import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/features/my_qr_codes/domain/models/created_qr_code_model.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/bloc/my_qr_codes_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrCodeViewScreen extends StatelessWidget {
  const QrCodeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    CreatedQrCodeModel? qrCode;
    MyQrCodesBloc? bloc;
    
    if (extra is Map<String, dynamic>) {
      qrCode = extra['qrCode'] as CreatedQrCodeModel?;
      bloc = extra['bloc'] as MyQrCodesBloc?;
    }
    
    // If bloc is provided, wrap with BlocProvider.value
    Widget screenContent = _buildScreenContent(context, qrCode, bloc);
    
    if (bloc != null) {
      return BlocProvider.value(
        value: bloc,
        child: screenContent,
      );
    }
    
    return screenContent;
  }
  
  Widget _buildScreenContent(BuildContext context, CreatedQrCodeModel? qrCode, MyQrCodesBloc? bloc) {

    if (qrCode == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No QR code data'),
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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'QR Code',
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
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.06),
                          offset: const Offset(0, 4),
                          blurRadius: 16,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: QrImageView(
                      data: qrCode.rawData,
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.width * 0.75 - 48,
                      backgroundColor: AppColors.whiteColor,
                      foregroundColor: qrCode.color,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.06),
                        offset: const Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        qrCode.title,
                        style: AppFonts.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        qrCode.rawData,
                        style: AppFonts.titleMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.greyTextColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DateFormat('MMM dd, yyyy').format(qrCode.createdAt),
                        style: AppFonts.titleMedium.copyWith(
                          fontSize: 13,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _ActionButtonsRow(
                  onShare: () async {
                    try {
                      await Share.share(qrCode.rawData);
                    } catch (_) {
                      // ignore
                    }
                  },
                  onEdit: () {
                    context.push(
                      '/create_qr_code',
                      extra: {'qrCode': qrCode},
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

}

class _ActionButtonsRow extends StatelessWidget {
  const _ActionButtonsRow({
    required this.onShare,
    required this.onEdit,
  });

  final VoidCallback onShare;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.share,
            label: 'Share',
            color: AppColors.greenColor,
            onTap: onShare,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionButton(
            icon: Icons.edit,
            label: 'Edit',
            color: AppColors.primaryColor,
            onTap: onEdit,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.06),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: AppFonts.titleMedium.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
