library sqlite3_library_linux;

import 'dart:ffi' show DynamicLibrary;
import 'dart:io' show File, Platform;

///relative path to default SQLite3 library file
const default_sqlite3_linux_libraryPath =
    '/data/flutter_assets/packages/sqlite3_library_linux/default/libsqlite3.so';

///relative path to debian SQLite3 library file
const debian_sqlite3_linux_libraryPath =
    '/data/flutter_assets/packages/sqlite3_library_linux/debian/libsqlite3.so';

///This function open SQLite3 in memory and return the associated DynamicLibrary
///object.
///
/// You can obtain [sqliteLibraryPath] by running [getSQLiteLibraryPathOnLinux]
DynamicLibrary openSQLiteOnLinux() {
  DynamicLibrary library;
  try {
    String sqliteLibraryPath = getSQLiteLibraryPathOnLinux();
    print('SQLite3LibraryPath: $sqliteLibraryPath');
    library = DynamicLibrary.open(sqliteLibraryPath);

    print(_yellow("SQLite3 successfully loaded"));
  } catch (e) {
    try {
      print(e);
      print(_red("Failed to load SQLite3 from library file, "
          "trying loading from system..."));

      library = DynamicLibrary.open('libsqlite3.so');

      print(_yellow("SQLite3 successfully loaded"));
    } catch (e) {
      print(e);
      print(_red("Failed to load SQLite3."));
    }
  }
  return library;
}

///return absolute path of SQLite3 library file
String getSQLiteLibraryPathOnLinux() {
  String linuxDistribution = getLinuxDistribution();
  print('Linux distribution: $linuxDistribution');

  String executableDirectoryPath =
      File(Platform.resolvedExecutable).parent.path;
  print('executableDirectoryPath: $executableDirectoryPath');
  switch (linuxDistribution) {
    case 'ubuntu':
      return executableDirectoryPath + debian_sqlite3_linux_libraryPath;
      break;
    case 'debian':
      return executableDirectoryPath + debian_sqlite3_linux_libraryPath;
      break;
    default:
      return executableDirectoryPath + debian_sqlite3_linux_libraryPath;
  }
}

String getLinuxDistribution() {
  String linuxDistribution;
  try {
    final List<String> osEtc = File('/etc/os-release').readAsLinesSync();
    linuxDistribution =
        osEtc.firstWhere((element) => element.indexOf("ID=") == 0);
    if (linuxDistribution != null)
      linuxDistribution = linuxDistribution.substring(3).toLowerCase();
    else
      throw Exception;
  } catch (e) {
    try {
      final List<String> osUsr = File('/usr/lib/os-release').readAsLinesSync();
      linuxDistribution =
          osUsr.firstWhere((element) => element.indexOf("ID=") == 0);
      if (linuxDistribution != null)
        linuxDistribution = linuxDistribution.substring(3).toLowerCase();
      else
        throw Exception;
    } catch (e) {
      try {
        final List<String> lsb = File('/etc/lsb-release').readAsLinesSync();
        linuxDistribution =
            lsb.firstWhere((element) => element.indexOf("DISTRIB_ID=") == 0);
        if (linuxDistribution != null)
          linuxDistribution = linuxDistribution.substring(11).toLowerCase();
        else
          throw Exception;
      } catch (e) {
        print(_red("Error getting Linux distribution name"));
        linuxDistribution = 'linux';
      }
    }
  }
  return linuxDistribution;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
