# Recorder App Specification

Specification for the Python voice recording and transcription application (`recorder/recorder.py`).

---

## Requirements

- Python 3.12+
- Whisper model (medium or large, local) for transcription
- Record from microphone
- Save audio files to `recordings/`
- Live microphone volume meter
- Pause / resume recording
- Copy transcription to clipboard automatically
- Minimal dependencies

---

## Dependencies

| Package | Purpose |
|---------|---------|
| `pyaudio` or `sounddevice` | Microphone capture |
| `numpy` | Audio data manipulation |
| `whisper` (openai-whisper) | Local transcription |
| `pyperclip` or `tkinter` | Clipboard access |
| `wave` (stdlib) | WAV file writing |
| `threading` (stdlib) | Async UI + recording |

---

## UI Design (Terminal-Based)

A simple terminal UI. No GUI framework needed — keep it lightweight.

```
╔════════════════════════════════════╗
║  🎤 WA Lore Recorder              ║
║                                    ║
║  Volume: ████████░░░░░░░░░  45%   ║
║  Duration: 00:03:24               ║
║  Status: ● RECORDING              ║
║                                    ║
║  [Space] Pause   [R] Reset        ║
║  [S] Stop & Transcribe            ║
║  [Q] Quit                         ║
╚════════════════════════════════════╝
```

### Volume Bar
- Real-time bar (updated every ~100ms)
- Horizontal bar using block characters
- Shows percentage next to bar

### Status States
| State | Display |
|-------|---------|
| Ready (idle) | ○ READY |
| Recording | ● RECORDING |
| Paused | ⏸ PAUSED |
| Transcribing | ⟳ TRANSCRIBING... |
| Done | ✓ DONE — Copied to clipboard |

### Controls

| Key | Action |
|-----|--------|
| `Space` | Toggle pause/resume during recording |
| `R` | Reset current recording (discard, return to READY) |
| `S` | Stop recording and start transcription |
| `Q` | Quit the application |
| `Ctrl+C` | Also quits |

---

## Audio Specifications

| Parameter | Value |
|-----------|-------|
| Sample rate | 16000 Hz (Whisper's preferred rate) |
| Channels | 1 (mono) |
| Format | 16-bit PCM |
| Output file | WAV (`recordings/recording_YYYYMMDD_HHMMSS.wav`) |
| Buffer size | 1024 frames per chunk |

---

## Workflow (Internal)

### Recording Phase
1. Open microphone stream at 16kHz mono.
2. Start a background thread reading audio chunks into a buffer.
3. Update volume bar from the chunk's RMS level.
4. On Space → pause flag set (buffer continues but not appended; or stop reading).
5. On R → clear buffer, reset timer, go to READY.
6. On S → close stream, save WAV, enter TRANSCRIBING state.

### Transcription Phase
1. Load the saved WAV file.
2. Run Whisper model (`whisper.load_model("medium")` or `"large"`) on the file.
3. Get the transcription text.

### Clipboard Phase
1. Copy the transcription text to clipboard via `pyperclip`.
2. Print confirmation message: "✓ Transcribed! Copied to clipboard."
3. Print the transcription so the user can verify.

---

## Whisper Model Loading

- Load the model **once** at first transcription, keep in memory for subsequent runs.
- Default: `"medium"` (balance of speed and accuracy).
- Fallback: if medium fails, try `"base"`.
- The app should log model load time and detected device (CPU/CUDA).

---

## File Output

- Audio files: `recordings/recording_YYYYMMDD_HHMMSS.wav`
- Clean up by the user (or optionally add a `--keep-last N` flag later).

---

## Setup & Usage

### Virtual Environment (Recommended)

```bash
cd recorder
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
python recorder.py
```

### Direct

```bash
cd recorder
pip install -r requirements.txt
python recorder.py
```

---

## Edge Cases

| Case | Behavior |
|------|----------|
| No microphone found | Print error, exit gracefully |
| Whisper model download fails | Print helpful error (suggest offline model path) |
| Empty recording (0 seconds) | Refuse to transcribe, warn user |
| Clipboard unavailable | Print transcription to stdout with warning |
| Very long recording (>30 min) | Transcribe normally (may take longer) |