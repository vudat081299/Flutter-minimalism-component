import 'package:collection/collection.dart';

enum PointXTeamType {
  postOfficeConfirmSession, // Bưu cục về chốt phiên
  pick, // Lấy
  deliver, // Giao
  returnItem, // Trả
  selfDeliver, // Giao ngay
  importStation, // Chờ nhập
  exportStation, // Chờ xuất
  xTeamLoading,
  exportRoot,
  returnExport, // Điểm xuất trả

  // Getter để lấy title tương ứng với từng case
  ;

  int get rawValue {
    switch (this) {
      case PointXTeamType.postOfficeConfirmSession:
        return 0;
      case PointXTeamType.pick:
        return 1;
      case PointXTeamType.deliver:
        return 2;
      case PointXTeamType.returnItem:
        return 3;
      case PointXTeamType.selfDeliver:
        return 4;
      case PointXTeamType.importStation:
        return 5;
      case PointXTeamType.exportStation:
        return 6;
      case PointXTeamType.xTeamLoading:
        return 7;
      case PointXTeamType.exportRoot:
        return 8;
      case PointXTeamType.returnExport:
        return 9;
    }
  }

  String get title {
    switch (this) {
      case PointXTeamType.importStation:
        return "NHẬP";
      case PointXTeamType.pick:
        return "LẤY";
      case PointXTeamType.deliver:
      case PointXTeamType.selfDeliver:
        return "GIAO";
      case PointXTeamType.returnItem:
        return "TRẢ";
      case PointXTeamType.exportStation:
        return "XUẤT";
      case PointXTeamType.postOfficeConfirmSession:
      case PointXTeamType.xTeamLoading:
      case PointXTeamType.exportRoot:
      case PointXTeamType.returnExport:
        return "";
      default:
        return "";
    }
  }

  // Factory constructor để tạo enum từ rawValue
  static PointXTeamType? fromRawValue(int? rawValue) {
    return PointXTeamType.values
        .firstWhereOrNull((type) => type.rawValue == rawValue);
  }
}
