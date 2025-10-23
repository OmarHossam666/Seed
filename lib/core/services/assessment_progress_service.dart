import 'package:shared_preferences/shared_preferences.dart';

class AssessmentProgressService {
  static late final SharedPreferences _sharedPreferences;

  static const String _mcqCompletedKey = 'mcq_completed';
  static const String _essayCompletedKey = 'essay_completed';
  static const String _softSkillsCompletedKey = 'soft_skills_completed';

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setMcqCompleted() async {
    await _sharedPreferences.setBool(_mcqCompletedKey, true);
  }

  static Future<void> setEssayCompleted() async {
    await _sharedPreferences.setBool(_essayCompletedKey, true);
  }

  static Future<void> setSoftSkillsCompleted() async {
    await _sharedPreferences.setBool(_softSkillsCompletedKey, true);
  }

  static bool isMcqCompleted() {
    return _sharedPreferences.getBool(_mcqCompletedKey) ?? false;
  }

  static bool isEssayCompleted() {
    return _sharedPreferences.getBool(_essayCompletedKey) ?? false;
  }

  static bool isSoftSkillsCompleted() {
    return _sharedPreferences.getBool(_softSkillsCompletedKey) ?? false;
  }

  static Future<int> getCompletedAssessmentsCount() async {
    int count = 0;
    if (isMcqCompleted()) count++;
    if (isEssayCompleted()) count++;
    if (isSoftSkillsCompleted()) count++;
    return count;
  }

  static Future<void> resetAssessmentProgress() async {
    await _sharedPreferences.remove(_mcqCompletedKey);
    await _sharedPreferences.remove(_essayCompletedKey);
    await _sharedPreferences.remove(_softSkillsCompletedKey);
  }
}
