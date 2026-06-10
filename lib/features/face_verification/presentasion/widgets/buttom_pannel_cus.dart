import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/recognizing_face/recognizing_face_bloc.dart';

class ButtomPannelCus extends StatelessWidget {
  final int index;
  final Widget recognizingBloc;
  final VoidCallback onScan;
  final VoidCallback onCheck;

  const ButtomPannelCus({
    super.key,
    required this.index,
    required this.recognizingBloc,
    required this.onScan,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status output
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: recognizingBloc,
          ),
          const SizedBox(height: 10),

          // Buttons
          Row(
            children: [
              Expanded(
                child: BlocBuilder<RecognizingFaceBloc, RecognizingFaceState>(
                  builder: (context, state) {
                    final isProcessing = state.maybeWhen(
                      processingUpdate: (embedding, message) => false,
                      similaritySuccess: (embedding, messge) => true,
                      processingErrol: (message) => true,
                      processing: (messge) => false,
                      success: (embedding, message) => true,
                      failed: (message) => true,
                      orElse: () => true,
                    );
                    final isCheckSuccess = state.maybeWhen(
                      similaritySuccess: (embedding, messge) => true,
                      orElse: () => false,
                    );
                    return FilledButton(
                      onPressed: index == 1
                          ? isProcessing
                                ? onScan
                                : null
                          : isCheckSuccess
                          ? onCheck
                          : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF2d6a4f),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        index == 1
                            ? 'Đăng ký khuôn mặt'
                            : 'Nhận diện khuôn mặt',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              // const SizedBox(width: 8),
              // OutlinedButton.icon(
              //   onPressed: onCheck,
              //   icon: const Icon(Icons.face_retouching_natural, size: 16),
              //   label: const Text('Verify'),
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: Colors.white70,
              //     side: BorderSide(color: Colors.white.withOpacity(0.12)),
              //     padding: const EdgeInsets.symmetric(
              //       vertical: 12,
              //       horizontal: 14,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
