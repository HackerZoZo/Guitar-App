import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsSection(
            title: 'App Info',
            children: [
              _SettingsTile(
                icon: Icons.info,
                title: 'Version',
                subtitle: '1.0.0',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.folder,
                title: 'Storage',
                subtitle: 'All data stored locally',
                onTap: () {},
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          _SettingsSection(
            title: 'Audio',
            children: [
              _SettingsTile(
                icon: Icons.volume_up,
                title: 'Metronome Volume',
                subtitle: 'Adjust system volume',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.vibration,
                title: 'Haptic Feedback',
                subtitle: 'Vibrate on beats',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeThumbColor: AppColors.primary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          _SettingsSection(
            title: 'Practice',
            children: [
              _SettingsTile(
                icon: Icons.access_time,
                title: 'Default BPM',
                subtitle: '80 BPM',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.music_note,
                title: 'Default Time Signature',
                subtitle: '4/4',
                onTap: () {},
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          _SettingsSection(
            title: 'About',
            children: [
              _SettingsTile(
                icon: Icons.help,
                title: 'How to Use',
                subtitle: 'Learn app features',
                onTap: () => _showHowToUse(context),
              ),
              _SettingsTile(
                icon: Icons.star,
                title: 'About Guitar Practice',
                subtitle: 'Offline guitar training app',
                onTap: () => _showAbout(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showHowToUse(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('How to Use'),
        content: const SingleChildScrollView(
          child: Text(
            '• Finger Exercises: Practice fundamental techniques\n\n'
            '• Chords: Learn chord shapes and positions\n\n'
            '• Random Chord Trainer: Practice chord transitions\n\n'
            '• Strumming Patterns: Master rhythm patterns\n\n'
            '• Metronome: Keep time while practicing\n\n'
            'All features work completely offline!',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('About'),
        content: const Text(
          'Guitar Practice App v1.0.0\n\n'
          'A fully offline guitar practice companion designed to help you improve daily.\n\n'
          'Features:\n'
          '• Structured finger exercises\n'
          '• Comprehensive chord library\n'
          '• Random chord progression trainer\n'
          '• Musical strumming pattern generator\n'
          '• Professional metronome\n\n'
          'Practice daily and watch your skills grow!',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
