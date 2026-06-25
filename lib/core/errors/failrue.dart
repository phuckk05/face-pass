abstract class Failure {
  final String message;
  const Failure(this.message);
}

//timeout failure
class TimeoutFailure extends Failure {
  const TimeoutFailure() : super('Mạng chậm, vui lòng thử lại');
}

//server failure
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

//network failure
class NetworkFailure extends Failure {
  const NetworkFailure() : super('Không có kết nối mạng');
}

//data rỗng
class EmptyDataFailure extends Failure {
  const EmptyDataFailure() : super('Không có dữ liệu');
}

//lỗi ko chính xác
class InvalidDataFailure extends Failure {
  const InvalidDataFailure(super.message);
}
