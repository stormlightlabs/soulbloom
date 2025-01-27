// Copyright 2025, Stormlight Labs

/// Therapy Modalities
enum TherapyModality {
  art,
  act,
  dbt,
  cbt,
}

/// Activity Difficulty Levels
enum DifficultyLevel {
  easy,
  medium,
  hard,
}

/// Export Options
enum ExportOptions {
  none,
  email,
  csv,
  cloudDropbox,
  cloudGoogleDrive,
  cloudOneDrive,
  cloudICloud,
}

enum DefaultNumericalValues {
  dailyCardDrawLimit(defaultValue: 3),
  notificationTiming(defaultValue: 15),
  soundEffectsVolume(defaultValue: 50),
  backupFrequency(defaultValue: 50),
  sessionDuration(defaultValue: 50);

  const DefaultNumericalValues({required this.defaultValue});

  final int defaultValue;
}

/// An interface of persistence stores for settings.
///
/// Therapeutic Preferences:
///     Preferred therapy modalities (ACT/DBT/CBT)
///     Activity difficulty level
///     Session duration preferences
///
/// Gameplay & Interaction:
///      Daily card draw limits
///      Notification timing/frequency
///      Sound effects volume
///      Background music toggle
///      Activity reminders
///
/// Privacy & Data:
///     Journal privacy lock
///     *Data export options
///     *Cloud sync settings
///     *Backup frequency
///
/// Profile & Personal:
///     Username
///     Timezone settings
///     Audio on/off
///     Music on/off
///     Sounds on/off
abstract class SettingsPersistence {
  Future<bool> getAudioOn({required bool defaultValue});
  Future<void> saveAudioOn(bool value);

  Future<bool> getMusicOn({required bool defaultValue});
  Future<void> saveMusicOn(bool value);

  Future<bool> getSoundsOn({required bool defaultValue});
  Future<void> saveSoundsOn(bool value);

  Future<String> getPlayerName();
  Future<void> savePlayerName(String value);

  Future<String> getTimezone();
  Future<void> saveTimezone(String value);

  Future<bool> getRemindersOn({required bool defaultValue});
  Future<void> saveRemindersOn(bool value);

  Future<int> getReminderTime({required int defaultValue});
  Future<void> saveReminderTime(int value);

  Future<bool> getJournalPrivacyLock({required bool defaultValue});
  Future<void> saveJournalPrivacyLock(bool value);

  Future<int> getDailyCardDrawLimit({required int defaultValue});
  Future<void> saveDailyCardDrawLimit(int value);

  Future<int> getNotificationTiming({required int defaultValue});
  Future<void> saveNotificationTiming(int value);

  Future<int> getSoundEffectsVolume({required int defaultValue});
  Future<void> saveSoundEffectsVolume(int value);

  Future<bool> getCloudSyncOn({required bool defaultValue});
  Future<void> saveCloudSyncOn(bool value);

  Future<int> getBackupFrequency({required int defaultValue});
  Future<void> saveBackupFrequency(int value);

  Future<int> getSessionDuration({required int defaultValue});
  Future<void> saveSessionDuration(int value);

  Future<TherapyModality> getPreferredTherapyModality({required TherapyModality defaultValue});
  Future<void> savePreferredTherapyModality(TherapyModality value);

  Future<DifficultyLevel> getActivityDifficultyLevel(
      {required DifficultyLevel defaultValue});
  Future<void> saveActivityDifficultyLevel(DifficultyLevel value);


  Future<ExportOptions> getExportOptions({required ExportOptions defaultValue});
  Future<void> saveExportOptions(ExportOptions value);
}
