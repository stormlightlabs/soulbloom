// Copyright 2025, Stormlight Labs

import 'settings_persistence.dart';

/// Useful for testing.
class MemoryOnlySettingsPersistence implements SettingsPersistence {
  bool musicOn = true;
  bool soundsOn = true;
  bool audioOn = true;
  String playerName = 'Player';
  String timezone = 'UTC';
  bool remindersOn = true;
  int reminderTime = 9;
  bool journalPrivacyLock = false;
  int dailyCardDrawLimit = 3;
  int notificationTiming = 15;
  int soundEffectsVolume = 50;
  int backupFrequency = 50;
  int sessionDuration = 50;

  @override
  Future<bool> getAudioOn({required bool defaultValue}) async {
    return audioOn;
  }

  @override
  Future<void> saveAudioOn(bool value) async {
    audioOn = value;
  }

  @override
  Future<bool> getMusicOn({required bool defaultValue}) async {
    return musicOn;
  }

  @override
  Future<void> saveMusicOn(bool value) async {
    musicOn = value;
  }

  @override
  Future<bool> getSoundsOn({required bool defaultValue}) async {
    return soundsOn;
  }

  @override
  Future<void> saveSoundsOn(bool value) async {
    soundsOn = value;
  }

  @override
  Future<String> getPlayerName() async {
    return playerName;
  }

  @override
  Future<void> savePlayerName(String value) async {
    playerName = value;
  }

  @override
  Future<String> getTimezone() async {
    return timezone;
  }


  @override
  Future<void> saveTimezone(String value) async {
    timezone = value;
  }

  @override
  Future<bool> getRemindersOn({required bool defaultValue}) async {
    return remindersOn;
  }

  @override
  Future<void> saveRemindersOn(bool value) async {
    remindersOn = value;
  }

  @override
  Future<int> getReminderTime({required int defaultValue}) async {
    return reminderTime;
  }

  @override
  Future<void> saveReminderTime(int value) async {
    reminderTime = value;
  }

  @override
  Future<bool> getJournalPrivacyLock({required bool defaultValue}) async {
    return journalPrivacyLock;
  }

  @override
  Future<void> saveJournalPrivacyLock(bool value) async {
    journalPrivacyLock = value;
  }

  @override
  Future<int> getDailyCardDrawLimit({required int defaultValue}) async {
    return dailyCardDrawLimit;
  }

  @override
  Future<void> saveDailyCardDrawLimit(int value) async {
    dailyCardDrawLimit = value;
  }

  @override
  Future<int> getNotificationTiming({required int defaultValue}) async {
    return notificationTiming;
  }

  @override
  Future<void> saveNotificationTiming(int value) async {
    notificationTiming = value;
  }

  @override
  Future<int> getSoundEffectsVolume({required int defaultValue}) async {
    return soundEffectsVolume;
  }

  @override
  Future<void> saveSoundEffectsVolume(int value) async {
    soundEffectsVolume = value;
  }

  @override
  Future<bool> getCloudSyncOn({required bool defaultValue}) async {
    return false;
  }

  @override
  Future<void> saveCloudSyncOn(bool value) async {
    // Do nothing
  }

  @override
  Future<int> getBackupFrequency({required int defaultValue}) async {
    return backupFrequency;
  }

  @override
  Future<void> saveBackupFrequency(int value) async {
    backupFrequency = value;
  }

  @override
  Future<int> getSessionDuration({required int defaultValue}) async {
    return sessionDuration;
  }

  @override
  Future<void> saveSessionDuration(int value) async {
    sessionDuration = value;
  }

  @override
  Future<TherapyModality> getPreferredTherapyModality({required TherapyModality defaultValue}) async {
    return TherapyModality.art;
  }

  @override
  Future<void> savePreferredTherapyModality(TherapyModality value) async {
    // Do nothing
  }

  @override
  Future<DifficultyLevel> getActivityDifficultyLevel({required DifficultyLevel defaultValue}) async {
    return DifficultyLevel.easy;
  }

  @override

  Future<void> saveActivityDifficultyLevel(DifficultyLevel value) async {
    // Do nothing
  }

  @override
  Future<ExportOptions> getExportOptions({required ExportOptions defaultValue}) async {
    return ExportOptions.csv;
  }

  @override
  Future<void> saveExportOptions(ExportOptions value) async {
    // Do nothing
  }
}
