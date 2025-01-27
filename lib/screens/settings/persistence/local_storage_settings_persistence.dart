// Copyright 2025, Stormlight Labs

import 'package:shared_preferences/shared_preferences.dart';

import 'settings_persistence.dart';

class LocalStorageSettingsPersistence extends SettingsPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  @override
  Future<bool> getAudioOn({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('audioOn') ?? defaultValue;
  }

  @override
  Future<void> saveAudioOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('audioOn', value);
  }


  @override
  Future<bool> getMusicOn({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('musicOn') ?? defaultValue;
  }

  @override
  Future<void> saveMusicOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('musicOn', value);
  }

  @override
  Future<bool> getSoundsOn({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('soundsOn') ?? defaultValue;
  }

  @override
  Future<void> saveSoundsOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('soundsOn', value);
  }

  @override
  Future<String> getPlayerName() async {
    final prefs = await instanceFuture;
    return prefs.getString('playerName') ?? 'Player';
  }

  @override
  Future<void> savePlayerName(String value) async {
    final prefs = await instanceFuture;
    await prefs.setString('playerName', value);
  }

  @override
  Future<String> getTimezone() async {
    final prefs = await instanceFuture;
    return prefs.getString('timezone') ?? 'UTC';
  }

  @override
  Future<void> saveTimezone(String value) async {
    final prefs = await instanceFuture;
    await prefs.setString('timezone', value);
  }

  @override
  Future<bool> getRemindersOn({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('remindersOn') ?? defaultValue;
  }

  @override
  Future<void> saveRemindersOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('remindersOn', value);
  }

  @override
  Future<int> getReminderTime({required int defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getInt('reminderTime') ?? defaultValue;
  }

  @override
  Future<void> saveReminderTime(int value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('reminderTime', value);
  }

  @override
  Future<bool> getJournalPrivacyLock({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('journalPrivacyLock') ?? defaultValue;
  }

  @override
  Future<void> saveJournalPrivacyLock(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('journalPrivacyLock', value);
  }

  @override
  Future<int> getDailyCardDrawLimit({required int defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getInt('dailyCardDrawLimit') ?? defaultValue;
  }

  @override
  Future<void> saveDailyCardDrawLimit(int value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('dailyCardDrawLimit', value);
  }

  @override
  Future<int> getNotificationTiming({required int defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getInt('notificationTiming') ?? defaultValue;
  }

  @override
  Future<void> saveNotificationTiming(int value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('notificationTiming', value);
  }

  @override
  Future<int> getSoundEffectsVolume({required int defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getInt('soundEffectsVolume') ?? defaultValue;
  }

  @override
  Future<void> saveSoundEffectsVolume(int value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('soundEffectsVolume', value);
  }

  @override
  Future<bool> getCloudSyncOn({required bool defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getBool('cloudSyncOn') ?? defaultValue;
  }

  @override
  Future<void> saveCloudSyncOn(bool value) async {
    final prefs = await instanceFuture;
    await prefs.setBool('cloudSyncOn', value);
  }

  @override
  Future<int> getBackupFrequency({required int defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getInt('backupFrequency') ?? defaultValue;
  }

  @override
  Future<void> saveBackupFrequency(int value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('backupFrequency', value);
  }

  @override
  Future<int> getSessionDuration({required int defaultValue}) async {
    final prefs = await instanceFuture;
    return prefs.getInt('sessionDuration') ?? defaultValue;
  }

  @override
  Future<void> saveSessionDuration(int value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('sessionDuration', value);
  }

  @override
  Future<TherapyModality> getPreferredTherapyModality(
      {required TherapyModality defaultValue}) async {
    final prefs = await instanceFuture;
    final therapyModalityIndex = prefs.getInt('preferredTherapyModality') ?? 0;
    return TherapyModality.values[therapyModalityIndex];
  }


  @override
  Future<void> savePreferredTherapyModality(TherapyModality value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('preferredTherapyModality', value.index);
  }

  @override
  Future<DifficultyLevel> getActivityDifficultyLevel(
      {required DifficultyLevel defaultValue}) async {
    final prefs = await instanceFuture;
    final difficultyLevelIndex = prefs.getInt('activityDifficultyLevel') ?? 0;
    return DifficultyLevel.values[difficultyLevelIndex];
  }

  @override
  Future<void> saveActivityDifficultyLevel(DifficultyLevel value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('activityDifficultyLevel', value.index);
  }

  @override
  Future<ExportOptions> getExportOptions(
      {required ExportOptions defaultValue}) async {
    final prefs = await instanceFuture;
    final exportOptionsIndex = prefs.getInt('exportOptions') ?? 0;
    return ExportOptions.values[exportOptionsIndex];
  }

  @override
  Future<void> saveExportOptions(ExportOptions value) async {
    final prefs = await instanceFuture;
    await prefs.setInt('exportOptions', value.index);
  }
}
