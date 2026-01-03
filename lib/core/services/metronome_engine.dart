import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MetronomeEngine {
  final AudioPlayer _clickPlayer = AudioPlayer();
  final AudioPlayer _accentPlayer = AudioPlayer();
  
  Timer? _timer;
  int _currentBeat = 0;
  int _bpm = 80;
  int _beatsPerBar = 4;
  bool _isRunning = false;
  bool _accentFirstBeat = true;
  
  final StreamController<int> _beatController = StreamController<int>.broadcast();
  Stream<int> get beatStream => _beatController.stream;
  
  bool get isRunning => _isRunning;
  int get bpm => _bpm;
  int get currentBeat => _currentBeat;

  Future<void> initialize() async {
    try {
      await _clickPlayer.setSourceAsset('sounds/click.mp3');
      await _accentPlayer.setSourceAsset('sounds/accent.mp3');
      await _clickPlayer.setReleaseMode(ReleaseMode.stop);
      await _accentPlayer.setReleaseMode(ReleaseMode.stop);
    } catch (e) {
      // Fallback to system sounds if assets not available
      debugPrint('Audio assets not found, using system sounds: $e');
    }
  }

  void start({int? bpm, int? beatsPerBar, bool? accentFirst}) {
    if (bpm != null) _bpm = bpm.clamp(40, 220);
    if (beatsPerBar != null) _beatsPerBar = beatsPerBar;
    if (accentFirst != null) _accentFirstBeat = accentFirst;
    
    _currentBeat = 0;
    _isRunning = true;
    
    final intervalMs = (60000 / _bpm).round();
    
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: intervalMs), (_) {
      _tick();
    });
    
    // Play first beat immediately
    _tick();
  }

  void stop() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
    _currentBeat = 0;
  }

  void setBpm(int newBpm) {
    final wasRunning = _isRunning;
    if (wasRunning) stop();
    _bpm = newBpm.clamp(40, 220);
    if (wasRunning) start();
  }

  void _tick() async {
    final isAccent = _accentFirstBeat && _currentBeat == 0;
    
    try {
      if (isAccent) {
        await _accentPlayer.seek(Duration.zero);
        await _accentPlayer.resume();
      } else {
        await _clickPlayer.seek(Duration.zero);
        await _clickPlayer.resume();
      }
    } catch (e) {
      // Fallback to haptic feedback
      HapticFeedback.lightImpact();
    }
    
    _beatController.add(_currentBeat);
    
    _currentBeat = (_currentBeat + 1) % _beatsPerBar;
  }

  void dispose() {
    _timer?.cancel();
    _beatController.close();
    _clickPlayer.dispose();
    _accentPlayer.dispose();
  }
}
