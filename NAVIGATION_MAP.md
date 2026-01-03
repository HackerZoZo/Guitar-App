# 🎸 Guitar Practice App - Navigation & Screen Map

## App Flow Diagram

```
┌─────────────────────────────────────────────────────────┐
│                     🏠 HOME SCREEN                       │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │   Finger    │  │   Chords    │  │   Random    │    │
│  │  Exercises  │  │  Practice   │  │   Chord     │    │
│  │     🎹      │  │     🎵      │  │  Trainer ⭐ │    │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘    │
│         │                │                │            │
│  ┌──────┴──────┐  ┌──────┴──────┐  ┌──────┴──────┐    │
│  │ Strumming   │  │ Metronome   │  │  Settings   │    │
│  │  Patterns ⭐│  │     ⏱️      │  │     ⚙️      │    │
│  └─────────────┘  └─────────────┘  └─────────────┘    │
└─────────────────────────────────────────────────────────┘
         │                │                │          │
         ▼                ▼                ▼          ▼
```

---

## Screen Hierarchy

### 📁 Features / Screens

#### 1️⃣ Finger Exercises Flow
```
Home
 └─► Exercises List
      ├─ Spider Exercise
      ├─ 1-2-3-4 Chromatic
      ├─ Finger Stretching
      └─ Speed Building
           └─► Exercise Detail
                ├─ About Section
                ├─ Instructions
                ├─ Benefits
                ├─ BPM Slider
                └─ [Start Practice] → Metronome
```

**Files**:
- `lib/features/exercises/screens/exercises_screen.dart`
- `lib/features/exercises/screens/exercise_detail_screen.dart`

---

#### 2️⃣ Chords Practice Flow
```
Home
 └─► Chords Library
      ├─ Tab: Major (C, D, E, G, A, C7, D7, G7, A7, E7)
      ├─ Tab: Minor (Am, Em, Dm, Bm, Cm)
      └─ Tab: Barre (F, B, Bm, Cm, all barre chords)
           └─► [Tap Chord] → Bottom Sheet
                ├─ Chord Diagram (large)
                ├─ Finger Positions Table
                ├─ [Practice with Metronome]
                └─ [Close]
```

**Files**:
- `lib/features/chords/screens/chords_screen.dart`

---

#### 3️⃣ Random Chord Trainer Flow ⭐
```
Home
 └─► Chord Trainer Setup
      ├─ Select Chords (FilterChips)
      ├─ Choose Difficulty (All/Beginner/Intermediate)
      ├─ Set BPM (40-220)
      └─ Set Bars (4-32)
           └─► [Start Training]
                │
                ▼
           Playing View
                ├─ Large Chord Name (72sp)
                ├─ Chord Diagram (240px)
                ├─ Countdown Ring (animated)
                ├─ Progress (Bar X of Y)
                ├─ Beat Indicator
                └─ [Stop] → Back to Setup
                     │
                     └─ Auto-stop after last bar
```

**Files**:
- `lib/features/chord_trainer/screens/chord_trainer_screen.dart`
- `lib/features/chord_trainer/providers/chord_trainer_provider.dart`

**State Flow**:
```
User Selects Chords → ChordTrainerNotifier.toggleChord()
                    → state.selectedChords updated
                    → UI rebuilds FilterChips

User Taps Start → ChordTrainerNotifier.start()
                → ChordGenerator.generateSequence()
                → MetronomeEngine.start()
                → Beat stream subscription
                → state.isPlaying = true
                → UI switches to Playing View

Beat Tick → beatStream emits
         → ChordTrainerNotifier updates currentBeat
         → Chord changes on bar boundary
         → CountdownRing animates
         → UI reflects new chord
```

---

#### 4️⃣ Strumming Pattern Generator Flow ⭐
```
Home
 └─► Strumming Setup
      ├─ Select Difficulty (Easy/Medium/Advanced)
      ├─ Choose Time Signature (4/4, 3/4, 6/8)
      ├─ Set BPM (40-220)
      └─ Pattern Preview
           ├─ Shows generated pattern
           └─ [Generate New Pattern] → New pattern
                │
                └─► [Start Practice]
                     │
                     ▼
                Playing View
                     ├─ Pattern Display (grouped by beats)
                     ├─ Beat Highlighting (current beat teal)
                     ├─ BPM Display
                     ├─ [New Pattern] → Generate during practice
                     └─ [Stop] → Back to Setup
```

**Files**:
- `lib/features/strumming/screens/strumming_screen.dart`
- `lib/features/strumming/providers/strumming_provider.dart`
- `lib/features/strumming/widgets/pattern_display.dart`

**Pattern Generation Flow**:
```
User Selects Difficulty → StrummingNotifier.setDifficulty()
                        → StrummingPatternGenerator.generate()
                        → Apply difficulty rules:
                           - Easy: Simple templates
                           - Medium: + syncopation + ghost
                           - Advanced: 16th grid + complex
                        → Validate musicality
                        → state.currentPattern updated
                        → PatternDisplay renders

User Taps Start → StrummingNotifier.start()
                → MetronomeEngine.start()
                → Beat stream subscription
                → state.isPlaying = true
                → UI switches to Playing View

Beat Tick → Highlight current beat container
         → Pattern stays same (unless regenerate)
```

---

#### 5️⃣ Metronome Flow
```
Home
 └─► Metronome
      ├─ Large BPM Display (circle)
      ├─ Beat Indicators (3-6 circles)
      ├─ BPM Slider (40-220)
      ├─ Quick Presets
      │   ├─ Slow (60)
      │   ├─ Medium (80)
      │   ├─ Fast (120)
      │   └─ Rock (140)
      ├─ Time Signature (3/4, 4/4, 6/8)
      └─ [Start/Stop]
           └─► Plays clicks with accent on beat 1
```

**Files**:
- `lib/features/metronome/screens/metronome_screen.dart`

**Metronome Engine**:
```
User Taps Start → MetronomeStateNotifier.start()
                → MetronomeEngine.start(bpm, beatsPerBar)
                → Timer.periodic(60000/bpm ms)
                → Each tick:
                   - Determine accent (beat == 0)
                   - Play audio (accent.wav or click.wav)
                   - Emit beat to stream
                   - Trigger haptic if audio fails
                   - Increment beat % beatsPerBar
                → UI: Beat indicators animate
                     Circle glows
```

---

#### 6️⃣ Settings Flow
```
Home
 └─► Settings
      ├─ App Info
      │   ├─ Version: 1.0.0
      │   └─ Storage: All data local
      ├─ Audio
      │   ├─ Metronome Volume
      │   └─ Haptic Feedback (toggle)
      ├─ Practice
      │   ├─ Default BPM: 80
      │   └─ Default Time Signature: 4/4
      └─ About
           ├─ [How to Use] → Dialog with guide
           └─ [About Guitar Practice] → Dialog with info
```

**Files**:
- `lib/features/settings/screens/settings_screen.dart`

---

## Component Usage Map

### 🧩 Reusable Widgets

#### ChordDiagram
**Used in**:
- Chords Screen (grid cards)
- Chord Detail Sheet (large)
- Chord Trainer Playing View (large)

**Props**:
- `chord: Chord` (required)
- `size: double` (default 200)

---

#### CountdownRing
**Used in**:
- Chord Trainer Playing View

**Props**:
- `currentBeat: int` (0-3 for 4/4)
- `totalBeats: int` (4)
- `size: double` (default 120)

---

#### BpmSlider
**Used in**:
- Exercise Detail Screen
- Chord Trainer Setup
- Strumming Setup
- Metronome Screen

**Props**:
- `value: int` (current BPM)
- `onChanged: ValueChanged<int>`
- `min: int` (default 40)
- `max: int` (default 220)

---

#### PrimaryButton
**Used in**:
- All screens (Start, Stop, Practice, etc.)

**Props**:
- `text: String`
- `onPressed: VoidCallback`
- `icon: IconData?` (optional)
- `isLoading: bool` (default false)

---

#### PatternDisplay
**Used in**:
- Strumming Setup (preview)
- Strumming Playing View (with highlight)

**Props**:
- `pattern: StrummingPattern`
- `highlightBeat: int?` (optional)

---

## Data Flow Architecture

### Provider Dependency Tree
```
ProviderScope (root)
 ├─ metronomeEngineProvider (singleton)
 │   └─ Used by all practice features
 ├─ chordRepositoryProvider
 │   └─ Used by: Chords, Chord Trainer
 ├─ exerciseRepositoryProvider
 │   └─ Used by: Exercises
 ├─ chordGeneratorProvider
 │   └─ Used by: Chord Trainer
 ├─ strummingGeneratorProvider
 │   └─ Used by: Strumming
 ├─ metronomeStateProvider (StateNotifier)
 │   └─ Global metronome state
 ├─ chordTrainerProvider (StateNotifier)
 │   └─ Chord trainer state + logic
 └─ strummingProvider (StateNotifier)
     └─ Strumming state + logic
```

### State Update Pattern (Riverpod)
```
User Action
    ↓
UI calls notifier method
    ↓
Notifier updates state (immutable)
    ↓
state = state.copyWith(...)
    ↓
Riverpod notifies listeners
    ↓
Consumer widgets rebuild
    ↓
UI reflects new state
```

---

## Audio & Timing Architecture

### Metronome Integration
```
┌─────────────────────────────────────────────┐
│         MetronomeEngine (Singleton)         │
│  - Timer.periodic for precision             │
│  - AudioPlayer for sounds                   │
│  - Stream<int> for beat broadcast           │
└────────────┬────────────────────────────────┘
             │
             ├──► Exercise Detail (optional)
             ├──► Chord Trainer (required)
             ├──► Strumming (required)
             └──► Metronome Screen (direct control)
```

### Beat Synchronization
```
Timer Tick → MetronomeEngine._tick()
          → Play audio (accent or click)
          → Emit beat to stream
          → _beatController.add(beat)
          
Stream Listener (in StateNotifier)
          → Updates state.currentBeat
          → Triggers chord change (Chord Trainer)
          → Triggers beat highlight (Strumming)
          → UI rebuilds automatically
```

---

## File Organization

```
lib/
├── main.dart ────────────► App entry, MaterialApp setup
│
├── core/ ───────────────► Shared infrastructure
│   ├── theme/
│   │   └── app_theme.dart ──► Colors, typography, Material theme
│   ├── models/ ─────────────► Domain objects
│   │   ├── chord.dart ──────► Chord data structure
│   │   ├── exercise.dart ───► Exercise data structure
│   │   ├── strumming_pattern.dart ► Pattern + Stroke structures
│   │   └── models.dart ─────► Barrel export
│   ├── widgets/ ────────────► Reusable UI components
│   │   ├── buttons.dart ────► Primary, Secondary, IconCard
│   │   ├── bpm_slider.dart ─► BPM control widget
│   │   ├── chord_diagram.dart ► Custom painter for chords
│   │   ├── countdown_ring.dart ► Circular progress
│   │   └── widgets.dart ────► Barrel export
│   ├── services/ ───────────► Business logic
│   │   ├── metronome_engine.dart ► Timing + audio engine
│   │   └── generators.dart ─► Chord + pattern generators
│   ├── data/ ───────────────► Data sources
│   │   ├── chord_repository.dart ► 17+ chords
│   │   └── exercise_repository.dart ► 4 exercises
│   └── providers/ ──────────► State management
│       └── providers.dart ──► Riverpod providers + notifiers
│
└── features/ ───────────────► Feature modules
    ├── home/
    │   └── screens/home_screen.dart ► Navigation hub
    ├── exercises/
    │   └── screens/
    │       ├── exercises_screen.dart ► List view
    │       └── exercise_detail_screen.dart ► Practice
    ├── chords/
    │   └── screens/chords_screen.dart ► Tabs + diagrams
    ├── chord_trainer/
    │   ├── screens/chord_trainer_screen.dart ► UI
    │   └── providers/chord_trainer_provider.dart ► Logic
    ├── strumming/
    │   ├── screens/strumming_screen.dart ► UI
    │   ├── providers/strumming_provider.dart ► Logic
    │   └── widgets/pattern_display.dart ► Pattern renderer
    ├── metronome/
    │   └── screens/metronome_screen.dart ► Metronome UI
    └── settings/
        └── screens/settings_screen.dart ► Settings
```

---

## Navigation Routes

### Route Table
```
/ (root) ──────────────────► HomeScreen
/exercises ────────────────► ExercisesScreen
/exercises/:id ────────────► ExerciseDetailScreen
/chords ───────────────────► ChordsScreen
/chord-trainer ────────────► ChordTrainerScreen
/strumming ────────────────► StrummingScreen
/metronome ────────────────► MetronomeScreen
/settings ─────────────────► SettingsScreen
```

### Navigation Method
- **Type**: MaterialPageRoute (imperative)
- **Animation**: Slide from right (default)
- **Back**: Pops route stack

---

## Key User Journeys

### Journey 1: Practice Chord Transitions (Beginner)
```
1. Open app → Home Screen
2. Tap "Random Chord Trainer"
3. Select chords: C, G, D, Am
4. Choose "Beginner" difficulty
5. Set BPM to 60
6. Set bars to 8
7. Tap "Start Training"
8. See: C chord with diagram
9. Practice for 4 beats
10. Chord auto-changes to G
11. Continue through 8 bars
12. See "Great work!" message
13. Tap "Stop" or restart
```

### Journey 2: Learn Strumming Pattern
```
1. Open app → Home Screen
2. Tap "Strumming Patterns"
3. Select "Easy" difficulty
4. Keep 4/4 time signature
5. Set BPM to 80
6. See pattern: D - D U - U
7. Tap "Generate New Pattern" (try different ones)
8. Find pattern you like
9. Tap "Start Practice"
10. Watch beat highlighting
11. Play along with metronome
12. Tap "New Pattern" for variation
13. Tap "Stop" when done
```

### Journey 3: Warm Up with Exercises
```
1. Open app → Home Screen
2. Tap "Finger Exercises"
3. Tap "1-2-3-4 Chromatic"
4. Read instructions
5. Set BPM to 60 (slow)
6. Tap "Start Practice"
7. Play pattern with metronome
8. Increase BPM gradually
9. Tap "Pause" for breaks
10. Return to list for next exercise
```

---

**Navigation Map Version**: 1.0.0  
**Last Updated**: January 2026  
**Status**: Complete ✅

🎸 **Navigate with confidence!** 🗺️
