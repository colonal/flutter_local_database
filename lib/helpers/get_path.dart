import 'package:path_provider/path_provider.dart' as path_provider;

class GetPath {
  Future<String> call() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    return directory.path;
  }
}
