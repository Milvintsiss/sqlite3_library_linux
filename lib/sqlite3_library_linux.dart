library sqlite3_library_linux;

import 'dart:ffi' show DynamicLibrary;
import 'dart:io' show File, Platform;

///relative path to default SQLite3 library file
const default_sqlite3_linux_libraryPath =
    '/data/flutter_assets/packages/sqlite3_library_linux/default/libsqlite3.so';

///relative path to old SQLite3 library file
const old_sqlite3_linux_libraryPath =
    '/data/flutter_assets/packages/sqlite3_library_linux/debian/libsqlite3.so';

///This function open SQLite3 in memory and return the associated DynamicLibrary
///object.
///
/// You can obtain [sqliteLibraryPath] by running [getSQLiteLibraryPathOnLinux]
DynamicLibrary openSQLiteOnLinux() {
  DynamicLibrary library;

  String executableDirectoryPath =
      File(Platform.resolvedExecutable).parent.path;

  print('executableDirectoryPath: $executableDirectoryPath');
  try {
    String sqliteLibraryPath =
        executableDirectoryPath + default_sqlite3_linux_libraryPath;
    print('SQLite3LibraryPath: $sqliteLibraryPath');

    library = DynamicLibrary.open(sqliteLibraryPath);

    print(_yellow("SQLite3 successfully loaded"));
  } catch (e) {
    try {
      print(e);
      //some linux distributions like debian cannot run the first version
      print(_red("Failed to load SQLite3, "
          "trying to load an old version of the SQLite3..."));
      String sqliteLibraryPath =
          executableDirectoryPath + old_sqlite3_linux_libraryPath;
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
  }
  return library;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
