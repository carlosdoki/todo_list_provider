import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';
import 'migrations/migration_v2.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() {
    return [
      MigrationV1(),
    ];
  }

  List<Migration> getUpdateMigration(int version) {
    final migrations = <Migration>[];
    if (version == 1) {
      migrations.add(MigrationV2());
    }

    return migrations;
  }
}
