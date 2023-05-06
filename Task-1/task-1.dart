import 'dart:io';

import 'dart:io';

void printFiles(String path, String parentFolder) {
  Directory directory = Directory(path);
  List<FileSystemEntity> files = directory.listSync();

  for (FileSystemEntity file in files) {
    if (file is File) {
      String fileName = File(file.path).basename;
      print('$parentFolder - $fileName');
    } else if (file is Directory) {
      String folderName = Directory(file.path).basename;
      printFiles(file.path, '$parentFolder - $folderName');
    }
  }
}

void main() {
  String rootPath = 'Test';
  String rootFolder = 'Test';
  printFiles(rootPath, rootFolder);
}
