# Guitar Practice Generator

## Overview

The Practice Generator is a professional guitar training tool that creates realistic strumming patterns combined with random chord progressions, exactly like real songs. It follows strict musical rules to ensure patterns are human-like and musically coherent.

## Features

### Strumming Symbols (STRICT)
Only these symbols are used:
- **D** = Downstroke
- **U** = Upstroke  
- **X** = Mute / Chuck

Output is clean, minimal, and readable - no extra symbols, numbers, arrows, or legends.

### Time Signature Support
- 2/4 - March, punk, fast folk
- 3/4 - Waltz, soft romantic
- 4/4 - Most pop, rock (default)
- 5/4 - Progressive rock
- 6/8 - Compound time, folk
- 7/8 - Odd time signature
- 12/8 - Blues, slow ballads

Strumming patterns automatically adapt to feel natural for each time signature.

### Pattern Length
- **1 Bar** (default) - Quick practice loops
- **2 Bars** - Medium phrases
- **4 Bars** - Full song grooves

Longer patterns feel like real song sections, not simple repetition.

### Difficulty Levels

#### Beginner
- Simple patterns
- Mostly downstrokes
- Fewer mutes
- Easy to follow rhythms

#### Intermediate
- Syncopation
- Down-up combinations
- Strategic mutes
- Longer grooves

#### Advanced
- Complex rhythms
- Lots of syncopation
- Frequent mutes
- Odd time signatures

### Chord Practice Integration

Chords are displayed above the strumming pattern and change per bar:

```
Am        G         F         C
D U X D U U D X U D U X D U
```

#### Chord Categories
- **Major** - C, D, E, G, A, etc.
- **Minor** - Am, Dm, Em, etc.
- **Barre** - F, Bm, etc.
- **Custom** - User-defined chord list

Chords automatically filter by difficulty level.

### Practice Modes

#### Jam Mode
- Both chords and pattern change each generation
- Best for variety and exploration
- Simulates playing different songs

#### Practice Mode
- Same chords, different patterns
- Focus on rhythm variation
- Great for mastering chord transitions

#### Groove Exploration Mode
- Same pattern, different chords
- Focus on chord changes
- Practice one groove across many progressions

### Randomness Logic

Every generation is different through:
- Realistic down/up flow
- Natural stroke sequences
- Varied syncopation
- Musical mute placement
- No impossible strokes
- Human-like feel

### Optional Features

#### Metronome Integration
- Syncs with built-in metronome
- Visual beat tracking
- Highlights current bar

#### BPM Control
- Range: 40-220 BPM
- Adjustable tempo
- Saved with pattern

#### Auto-Generate
- Quick pattern refresh
- One-tap variation
- Maintains settings

## Output Format

**Exact Style:**
```
Am        G         F         C
D U X D U U D X U D U X D U
```

**No explanations, no legends, no extra text**

Clean output ready for practice.

## Usage

### Quick Start

1. **Select Mode** - Choose Jam, Practice, or Groove
2. **Set Time Signature** - Pick from 2/4 to 12/8
3. **Choose Difficulty** - Beginner, Intermediate, or Advanced
4. **Select Chords** - Pick chord categories
5. **Set Tempo** - Adjust BPM (40-220)
6. **Generate** - Create your pattern
7. **Practice** - Start playing with metronome sync

### Tips

- Start with **Beginner** in **4/4** at **80 BPM**
- Use **Practice Mode** to master chord changes
- Try **Groove Mode** to learn new rhythms
- Increase difficulty gradually
- Experiment with different time signatures

## Technical Details

### Pattern Generation Algorithm

The generator uses probabilistic algorithms that consider:
- Beat strength (strong beats vs weak beats)
- Natural stroke alternation (down-up-down-up)
- Syncopation based on difficulty
- Mute placement for musicality
- Time signature characteristics

### Chord Selection

Chords are:
- Randomly selected from enabled categories
- Filtered by current difficulty level
- Changed per bar for practice variety
- Musically coherent (common progressions favored in future updates)

### Files

```
lib/
  core/
    models/
      practice_pattern.dart       # Data models
    services/
      practice_generator.dart     # Pattern generation logic
  features/
    practice_generator/
      providers/
        practice_generator_provider.dart  # State management
      screens/
        practice_generator_screen.dart    # Main UI
      widgets/
        practice_pattern_display.dart     # Pattern visualization
```

## Future Enhancements

- Popular chord progressions (I-V-vi-IV, etc.)
- Pattern favorites/bookmarks
- Export patterns to text/PDF
- Practice history tracking
- Custom pattern builder
- Genre-specific patterns (Rock, Blues, Folk, etc.)
- Multi-bar chord progressions
- Advanced strumming techniques

## Philosophy

This tool is designed by musicians for musicians. Every pattern generated:
- Feels human and musical
- Respects guitar technique
- Avoids impossible or awkward strokes
- Simulates real song structures
- Provides genuine practice value

The goal is to bridge the gap between repetitive exercises and real music, making practice feel like playing actual songs.
