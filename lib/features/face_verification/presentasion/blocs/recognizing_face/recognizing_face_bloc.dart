import 'package:facepass/features/face_verification/domain/usecase/resgister_face.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/utils/camera_utils.dart';
import '../../../../../core/utils/camera_utils.dart';
import '../../../domain/entities/face_embedding .dart';
part 'recognizing_face_bloc.freezed.dart';

part 'recognizing_face_state.dart';
part 'recognizing_face_event.dart';

class RecognizingFaceBloc
    extends Bloc<RecognizingFaceEvent, RecognizingFaceState> {
  final RegisterFaceUseCase registerFaceUseCase;
  FaceEmbedding? _currentEmbedding;

  RecognizingFaceBloc({required this.registerFaceUseCase})
    : super(const RecognizingFaceState.initial(messge: null)) {
    /* 1 */
    on<InitProcessFaceEvent>(_initProcessFace);
    /* 2 */
    on<ProcessingFaceEvent>(_processFace);
    /*3 */
    on<CheckSimilarityEvent>(_checkProcessing);
    /*4*/
    on<UpdateFaceEmbedding>(_updateFaceEmbedding);
    /*5 */
    on<CreateTempFaceEmbedding>(_createTempFaceEmbedding);
    /*6 */
    on<StopVerifyingEvent>(_stopVerifying);
  }

  void _stopVerifying(
    StopVerifyingEvent event,
    Emitter<RecognizingFaceState> emit,
  ) {
    emit(RecognizingFaceState.failed(message: event.message));
  }

  //init process face event
  void _initProcessFace(
    InitProcessFaceEvent event,
    Emitter<RecognizingFaceState> emit,
  ) async {
    _currentEmbedding = null;
    emit(
      const RecognizingFaceState.initial(
        messge: "Vui lòng cho khuôn mặt vào khung để nhận diện",
      ),
    );
    //bắn sự kiện đang xử lý
    emit(
      const RecognizingFaceState.processing(
        messge: "Đang nhận diện khuôn mặt...",
      ),
    );
  }

  //process face event
  void _processFace(
    ProcessingFaceEvent event,
    Emitter<RecognizingFaceState> emit,
  ) async {
    if (_currentEmbedding == null) return;
    if (event.newEmbedding == null || event.newEmbedding!.isEmpty) {
      emit(
        const RecognizingFaceState.failed(
          message: "Khuôn mặt không khớp, vui lòng thử lại",
        ),
      );
      return;
    }
    if (event.index == 1) {
      add(UpdateFaceEmbedding(embedding: event.newEmbedding!, index: 1));
      return;
    }

    final similarity = CameraUtils.cosineSimilarity(
      event.newEmbedding!,
      _currentEmbedding!.vector1,
    );
    if (similarity > 0.8) {
      add(
        UpdateFaceEmbedding(
          embedding: event.newEmbedding!,
          index: event.index ?? 1,
        ),
      );
    } else {
      emit(
        const RecognizingFaceState.processingErrol(
          message: "Khuôn mặt không khớp, vui lòng thử lại",
        ),
      );
    }
  }

  void _checkProcessing(
    CheckSimilarityEvent event,
    Emitter<RecognizingFaceState> emit,
  ) async {
    emit(RecognizingFaceState.processingErrol(message: event.message));
  }

  void _updateFaceEmbedding(
    UpdateFaceEmbedding event,
    Emitter<RecognizingFaceState> emit,
  ) {
    if (_currentEmbedding == null || event.embedding == null) return;
    switch (event.index) {
      case 1:
        _currentEmbedding = _currentEmbedding!.copyWith(
          vector1: _currentEmbedding!.vector1.isEmpty
              ? event.embedding!
              : _currentEmbedding!.vector1,
        );
        break;
      case 2:
        _currentEmbedding = _currentEmbedding!.copyWith(
          vector2: _currentEmbedding!.vector2.isEmpty
              ? event.embedding!
              : _currentEmbedding!.vector2,
        );
        break;
      case 3:
        _currentEmbedding = _currentEmbedding!.copyWith(
          vector3: _currentEmbedding!.vector3.isEmpty
              ? event.embedding!
              : _currentEmbedding!.vector3,
        );
        break;
      case 4:
        _currentEmbedding = _currentEmbedding!.copyWith(
          vector4: _currentEmbedding!.vector4.isEmpty
              ? event.embedding!
              : _currentEmbedding!.vector4,
        );
        break;
      case 5:
        _currentEmbedding = _currentEmbedding!.copyWith(
          vector5: _currentEmbedding!.vector5.isEmpty
              ? event.embedding!
              : _currentEmbedding!.vector5,
        );
        //cập nhật success luôn
        emit(
          RecognizingFaceState.success(
            embedding: _currentEmbedding!,
            messge: "Xác minh thành công",
          ),
        );
        return;
    }
    final message = switch (event.index) {
      1 => "Đang lấy khuôn mặt thứ 1",
      2 => "Đang lấy khuôn mặt thứ 2",
      3 => "Đang lấy khuôn mặt thứ 3",
      4 => "Đang lấy khuôn mặt thứ 4",
      5 => "Đang lấy khuôn mặt thứ 5",
      _ => null,
    };

    emit(
      RecognizingFaceState.processingUpdate(
        embedding: _currentEmbedding!,
        message: message,
      ),
    );
  }

  void _createTempFaceEmbedding(
    CreateTempFaceEmbedding event,
    Emitter<RecognizingFaceState> emit,
  ) {
    final FaceEmbedding tempFaceEmbedding = FaceEmbedding(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: event.userId,
      vector1: [],
      vector2: [],
      vector3: [],
      vector4: [],
      vector5: [],
      registeredAt: DateTime.now(),
    );
    _currentEmbedding = tempFaceEmbedding;
    emit(
      RecognizingFaceState.processingUpdate(
        embedding: tempFaceEmbedding,
        message: "Đang khởi tạo, vui lòng đợi...",
      ),
    );
  }
}
