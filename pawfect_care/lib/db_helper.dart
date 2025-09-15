import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String normalize(String e) => e.trim().toLowerCase();

class DBHelper {
  static Database? _db;

  static Future<Database> getDb() async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'pawfectcare.db');

    Future<void> _createTables(Database db) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT,
        password TEXT,
        role TEXT
      );
    ''');

      await db.execute('''
      CREATE TABLE IF NOT EXISTS pets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        name TEXT,
        species TEXT,
        breed TEXT,
        age TEXT,
        gender TEXT,
        photo_path TEXT
      );
    ''');

      await db.execute('''
      CREATE TABLE IF NOT EXISTS health_records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pet_id INTEGER,
        veterinarian_id INTEGER,
        visit_date TEXT,
        diagnosis TEXT,
        prescription TEXT,
        next_due_date TEXT
      );
    ''');

      await db.execute('''
      CREATE TABLE IF NOT EXISTS appointments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pet_id INTEGER,
        veterinarian_id INTEGER,
        date_time TEXT,
        status TEXT,
        notes TEXT
      );
    ''');
    }

    _db = await openDatabase(
      path,
      version: 2, // <-- bump this (from 1 to 2)
      onCreate: (db, v) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldV, newV) async {
        // create any missing tables when upgrading
        await _createTables(db);
      },
      onOpen: (db) async {
        // safety net – ensures tables exist even if version didn't change
        await _createTables(db);
      },
    );
    return _db!;
  }

  static Future<int> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final db = await getDb();
    return await db.insert('users', {
      'name': name,
      'email': normalize(email),
      'phone': phone,
      'password': password,
      'role': null,
    });
  }

  static Future<void> updateRole(int id, String role) async {
    final db = await getDb();
    await db.update('users', {'role': role}, where: 'id=?', whereArgs: [id]);
  }

  static Future<Map<String, dynamic>?> getUser(int id) async {
    final db = await getDb();
    final r = await db.query('users', where: 'id=?', whereArgs: [id], limit: 1);
    if (r.isEmpty) return null;
    return r.first;
  }

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    final db = await getDb();
    final rows = await db.query(
      'users',
      where: 'LOWER(email)=? AND password=?',
      whereArgs: [normalize(email), password],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first;
  }

  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await getDb();
    final rows = await db.query(
      'users',
      where: 'LOWER(email)=?',
      whereArgs: [normalize(email)],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return rows.first;
  }

  static Future<void> updateUserPassword(int id, String newPassword) async {
    final db = await getDb();
    await db.update(
      'users',
      {'password': newPassword},
      where: 'id=?',
      whereArgs: [id],
    );
  }

  // PETS
  static Future<int> addPet({
    required int userId,
    required String name,
    String? species,
    String? breed,
    String? age,
    String? gender,
    String? photoPath,
  }) async {
    final db = await getDb();
    return await db.insert('pets', {
      'user_id': userId,
      'name': name,
      'species': species,
      'breed': breed,
      'age': age,
      'gender': gender,
      'photo_path': photoPath,
    });
  }

  static Future<List<Map<String, dynamic>>> petsByUser(int userId) async {
    final db = await getDb();
    return await db.query('pets', where: 'user_id=?', whereArgs: [userId]);
  }

  // HEALTH
  static Future<int> addHealth({
    required int petId,
    String? visitDate,
    String? diagnosis,
    String? prescription,
    String? nextDueDate,
    int? vetId,
  }) async {
    final db = await getDb();
    return await db.insert('health_records', {
      'pet_id': petId,
      'veterinarian_id': vetId,
      'visit_date': visitDate,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'next_due_date': nextDueDate,
    });
  }

  static Future<List<Map<String, dynamic>>> healthByPet(int petId) async {
    final db = await getDb();
    return await db.query(
      'health_records',
      where: 'pet_id=?',
      whereArgs: [petId],
      orderBy: 'visit_date DESC',
    );
  }

  // APPOINTMENTS
  static Future<int> addAppointment({
    required int petId,
    required int veterinarianId,
    required String dateTime,
    String? status,
    String? notes,
  }) async {
    final db = await getDb();
    return await db.insert('appointments', {
      'pet_id': petId,
      'veterinarian_id': veterinarianId,
      'date_time': dateTime,
      'status': status ?? 'upcoming',
      'notes': notes,
    });
  }

  static Future<List<Map<String, dynamic>>> appointmentsByOwner(
    int userId,
  ) async {
    final db = await getDb();
    // simple: get all pets for user, then all appts for those pets
    final pets = await petsByUser(userId);
    final ids = pets.map((p) => p['id'] as int).toList();
    if (ids.isEmpty) return [];
    final placeholders = List.filled(ids.length, '?').join(',');
    return await db.rawQuery(
      'SELECT * FROM appointments WHERE pet_id IN ($placeholders) ORDER BY date_time DESC',
      ids,
    );
  }

  static Future<List<Map<String, dynamic>>> appointmentsByPet(int petId) async {
    final db = await getDb();
    return await db.query(
      'appointments',
      where: 'pet_id=?',
      whereArgs: [petId],
      orderBy: 'date_time DESC',
    );
  }
}
