import 'package:equatable/equatable.dart';

/// Represents a speech recognition locale with ID and display name
class SpeechLocale extends Equatable {
  /// Locale identifier (e.g., "en_US", "bn_BD", "ar_SA")
  final String id;
  
  /// Human-readable name (e.g., "English (United States)")
  final String name;
  
  const SpeechLocale(this.id, this.name);
  
  @override
  List<Object> get props => [id, name];
  
  @override
  String toString() => 'SpeechLocale(id: $id, name: $name)';
}