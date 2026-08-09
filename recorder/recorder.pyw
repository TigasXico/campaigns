#!/usr/bin/env python3
"""
WA Lore Recorder â€” GUI Application
Records voice notes, transcribes with Whisper, copies to clipboard.
Run with pythonw.exe for no console window (pinnable to taskbar).
"""

import os, sys, time, threading, queue, struct, wave
from datetime import datetime
from pathlib import Path
import numpy as np
import sounddevice as sd
import pyperclip
try:
    import whisper
except ImportError:
    whisper = None
import tkinter as tk

SAMPLE_RATE = 16000; CHANNELS = 1; DTYPE = "int16"; BLOCK_SIZE = 1024
RECORDINGS_DIR = Path(__file__).resolve().parent.parent / "recordings"
TRANSCRIPTIONS_DIR = Path(__file__).resolve().parent.parent / "transcriptions"
WHISPER_MODEL_NAME = "medium"
RECORDINGS_DIR.mkdir(parents=True, exist_ok=True)
TRANSCRIPTIONS_DIR.mkdir(parents=True, exist_ok=True)

C_BG="#1e1e2e"; C_FG="#cdd6f4"; C_ACCENT="#89b4fa"; C_RED="#f38ba8"
C_GREEN="#a6e3a1"; C_YELLOW="#f9e2af"; C_SURFACE="#313244"; C_SUBTLE="#6c7086"
FONT=("Segoe UI",10); FONT_B=("Segoe UI",10,"bold"); FONT_TIME=("Segoe UI",22,"bold")

class LoreRecorderApp:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("WA Lore Recorder")
        self.root.configure(bg=C_BG)
        self.root.resizable(False, False)
        self.root.protocol("WM_DELETE_WINDOW", self.quit_app)
        w, h = 480, 380
        sw = self.root.winfo_screenwidth(); sh = self.root.winfo_screenheight()
        self.root.geometry(f"{w}x{h}+{(sw-w)//2}+{(sh-h)//2}")

        self.state = "idle"
        self.audio_buffer = []; self.stream = None
        self.recording_start = 0; self.paused_duration = 0.0; self.pause_start = 0
        self.vol_q = queue.Queue(); self.status_q = queue.Queue()
        self.whisper_model = None; self._timer_job = None

        self._build_ui(); self._bind_keys()
        self._poll_volume(); self._poll_status()
        try:
            sd.query_devices(kind="input")
        except Exception:
            self._show_error("No microphone found!")

    def _build_ui(self):
        top = tk.Frame(self.root, bg=C_BG)
        top.pack(fill="x", padx=20, pady=(16, 4))
        tk.Label(top, text="\U0001f3a4  WA Lore Recorder",
                 font=("Segoe UI", 18, "bold"), bg=C_BG, fg=C_FG).pack(side="left")
        self.lbl_status = tk.Label(top, text="\u25cf READY",
                                   font=FONT_B, bg=C_BG, fg=C_SURFACE)
        self.lbl_status.pack(side="right")

        sep = tk.Frame(self.root, bg=C_SURFACE, height=1)
        sep.pack(fill="x", padx=20, pady=4)

        vf = tk.Frame(self.root, bg=C_BG)
        vf.pack(fill="x", padx=20, pady=(12, 4))
        tk.Label(vf, text="Volume", font=FONT, bg=C_BG,
                 fg=C_SUBTLE, width=6, anchor="w").pack(side="left")
        self.vol_canvas = tk.Canvas(vf, height=18, bg=C_SURFACE,
                                    highlightthickness=0, bd=0)
        self.vol_canvas.pack(side="left", fill="x", expand=True, padx=(4, 8))
        self.lbl_vol_pct = tk.Label(vf, text="0%", font=FONT,
                                    bg=C_BG, fg=C_SUBTLE, width=4, anchor="e")
        self.lbl_vol_pct.pack(side="right")
        self._draw_vol(0)

        df = tk.Frame(self.root, bg=C_BG)
        df.pack(fill="x", padx=20, pady=(2, 12))
        tk.Label(df, text="Duration", font=FONT, bg=C_BG,
                 fg=C_SUBTLE, width=6, anchor="w").pack(side="left")
        self.lbl_dur = tk.Label(df, text="00:00:00",
                                font=FONT_TIME, bg=C_BG, fg=C_FG)
        self.lbl_dur.pack(side="left", padx=(4, 0))

        bf = tk.Frame(self.root, bg=C_BG)
        bf.pack(pady=(8, 6))
        bfont = ("Segoe UI", 11, "bold")
        self.btn_rec = tk.Button(bf, text="\u25cf  Record", bg=C_RED, fg=C_BG,
                                 font=bfont, bd=0, width=13, height=1,
                                 cursor="hand2", command=self.toggle_record)
        self.btn_rec.pack(side="left", padx=4)
        self.btn_pause = tk.Button(bf, text="\u23f8  Pause", bg=C_YELLOW, fg=C_BG,
                                   font=bfont, bd=0, width=12, height=1,
                                   cursor="hand2", state="disabled",
                                   command=self.toggle_pause)
        self.btn_pause.pack(side="left", padx=4)
        self.btn_stop = tk.Button(bf, text="\u25a0  Stop", bg=C_ACCENT, fg=C_BG,
                                  font=bfont, bd=0, width=12, height=1,
                                  cursor="hand2", state="disabled",
                                  command=self.stop_and_transcribe)
        self.btn_stop.pack(side="left", padx=4)

        hk = tk.Frame(self.root, bg=C_BG)
        hk.pack(pady=(2, 2))
        tk.Label(hk, text="[Space] Pause/Resume  [R] Reset  [S] Stop  [Q] Quit",
                 font=("Segoe UI", 8), bg=C_BG, fg=C_SUBTLE).pack()

        self.tx_frame = tk.Frame(self.root, bg=C_BG)
        self.tx_frame.pack(fill="both", expand=True, padx=20, pady=(4, 12))
        self.txt_trans = tk.Text(self.tx_frame, font=("Consolas", 9),
                                 bg=C_SURFACE, fg=C_FG, bd=0,
                                 wrap="word", height=6, state="disabled")
        self.txt_trans.pack(fill="both", expand=True, side="left")
        scroll = tk.Scrollbar(self.tx_frame, command=self.txt_trans.yview,
                              bg=C_SURFACE)
        scroll.pack(side="right", fill="y")
        self.txt_trans.config(yscrollcommand=scroll.set)

        cbf = tk.Frame(self.root, bg=C_BG)
        cbf.pack(pady=(0, 12))
        self.btn_copy = tk.Button(cbf, text="\U0001f4cb  Copy to Clipboard",
                                  bg=C_SURFACE, fg=C_FG, font=FONT,
                                  bd=0, cursor="hand2",
                                  command=self.copy_transcription)
        self.btn_copy.pack()

    def _draw_vol(self, pct):
        w = self.vol_canvas.winfo_width() or 280
        self.vol_canvas.delete("all")
        fw = max(2, int(w * pct))
        c = C_GREEN if pct < 0.6 else C_YELLOW if pct < 0.85 else C_RED
        self.vol_canvas.create_rectangle(0, 0, fw, 18, fill=c, outline="")
        self.vol_canvas.create_rectangle(fw, 0, w, 18, fill=C_SURFACE, outline="")
        self.lbl_vol_pct.config(text=f"{int(pct*100)}%")

    def _set_state(self, state, text, color):
        self.state = state
        self.lbl_status.config(text=text, fg=color)

    def _bind_keys(self):
        for seq, cb in [("<space>", lambda e: self.toggle_pause()),
                        ("r", lambda e: self.reset_recording()),
                        ("s", lambda e: self.stop_and_transcribe()),
                        ("q", lambda e: self.quit_app())]:
            self.root.bind(seq, cb)

    def _show_error(self, msg):
        self._set_state("error", "\u2716 ERROR", C_RED)
        self._append_transcription(f"[ERROR] {msg}\n")

    # â”€â”€ Audio Callback â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

    def _audio_callback(self, indata, frames, time_info, status):
        if status:
            self.status_q.put(f"Audio status: {status}")
        if self.state == "recording":
            self.audio_buffer.append(indata.copy())
            vol = np.sqrt(np.mean(indata.astype(np.float32)**2)) / 32768.0
            self.vol_q.put(min(1.0, vol * 5))

    def _update_timer(self):
        if self.state in ("recording", "paused"):
            if self.state == "recording":
                elapsed = time.time() - self.recording_start - self.paused_duration
            else:
                elapsed = self.pause_start - self.recording_start - self.paused_duration
            h, r = divmod(int(elapsed), 3600)
            m, s = divmod(r, 60)
            self.lbl_dur.config(text=f"{h:02d}:{m:02d}:{s:02d}")
            self._timer_job = self.root.after(200, self._update_timer)

    # â”€â”€ Controls â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

    def toggle_record(self):
        if self.state == "idle":
            self.audio_buffer = []
            self.paused_duration = 0.0
            self.recording_start = time.time()
            self.stream = sd.InputStream(
                samplerate=SAMPLE_RATE, channels=CHANNELS,
                dtype=DTYPE, blocksize=BLOCK_SIZE,
                callback=self._audio_callback
            )
            self.stream.start()
            self._set_state("recording", "\u25cf RECORDING", C_RED)
            self.btn_rec.config(state="disabled")
            self.btn_pause.config(state="normal", text="\u23f8  Pause")
            self.btn_stop.config(state="normal")
            self._update_timer()
            self._append_transcription("")
        elif self.state == "done":
            self._reset_ui()

    def toggle_pause(self):
        if self.state == "recording":
            self.pause_start = time.time()
            self._set_state("paused", "\u23f8 PAUSED", C_YELLOW)
            self.btn_pause.config(text="\u25b6  Resume")
        elif self.state == "paused":
            self.paused_duration += time.time() - self.pause_start
            self._set_state("recording", "\u25cf RECORDING", C_RED)
            self.btn_pause.config(text="\u23f8  Pause")

    def reset_recording(self):
        if self.state in ("recording", "paused"):
            self._stop_stream()
            self.audio_buffer = []
            self.paused_duration = 0.0
            self._set_state("idle", "\u25cf READY", C_SURFACE)
            self.lbl_dur.config(text="00:00:00")
            self._draw_vol(0)
            self._reset_buttons()
            if self._timer_job:
                self.root.after_cancel(self._timer_job)
                self._timer_job = None

    def _stop_stream(self):
        if self.stream:
            try:
                self.stream.stop()
                self.stream.close()
            except Exception:
                pass
            self.stream = None

    def stop_and_transcribe(self):
        if self.state not in ("recording", "paused"):
            return
        self._stop_stream()
        if self._timer_job:
            self.root.after_cancel(self._timer_job)
            self._timer_job = None

        if len(self.audio_buffer) == 0:
            self._set_state("idle", "\u25cf READY", C_SURFACE)
            self._reset_buttons()
            self.lbl_dur.config(text="00:00:00")
            return

        self._set_state("transcribing", "\u27f3 TRANSCRIBING...", C_ACCENT)
        self.btn_pause.config(state="disabled")
        self.btn_stop.config(state="disabled")
        self._append_transcription("\n--- Transcribing... ---\n")

        audio_data = np.concatenate(self.audio_buffer, axis=0).flatten()
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        wav_path = RECORDINGS_DIR / f"recording_{timestamp}.wav"

        with wave.open(str(wav_path), "wb") as wf:
            wf.setnchannels(CHANNELS)
            wf.setsampwidth(2)
            wf.setframerate(SAMPLE_RATE)
            wf.writeframes(audio_data.tobytes())

        threading.Thread(target=self._run_transcription,
                         args=(str(wav_path),), daemon=True).start()

    def _run_transcription(self, wav_path):
        try:
            if self.whisper_model is None:
                if whisper is None:
                    self.status_q.put("err:openai-whisper not installed")
                    return
                self.status_q.put("Loading Whisper model...")
                self.whisper_model = whisper.load_model(WHISPER_MODEL_NAME)

            result = self.whisper_model.transcribe(wav_path)
            text = result.get("text", "").strip()
            if not text:
                text = "[No speech detected]"

            self.status_q.put(f"done:{text}")
        except Exception as e:
            self.status_q.put(f"err:{e}")

    def copy_transcription(self):
        text = self.txt_trans.get("1.0", "end-1c").strip()
        if text:
            try:
                pyperclip.copy(text)
                self.lbl_status.config(text="\u2713 COPIED!", fg=C_GREEN)
                self.root.after(2000, lambda: self.lbl_status.config(
                    text="\u25cf READY", fg=C_SURFACE))
            except Exception:
                self._append_transcription("\n[!] Clipboard unavailable\n")

    def _append_transcription(self, text):
        self.txt_trans.config(state="normal")
        if text:
            self.txt_trans.insert("end", text)
        self.txt_trans.see("end")
        self.txt_trans.config(state="disabled")

    def _reset_buttons(self):
        self.btn_rec.config(state="normal")
        self.btn_pause.config(state="disabled", text="\u23f8  Pause")
        self.btn_stop.config(state="disabled")

    def _reset_ui(self):
        self._reset_buttons()
        self.lbl_dur.config(text="00:00:00")
        self._draw_vol(0)
        self._set_state("idle", "\u25cf READY", C_SURFACE)

    # â”€â”€ Polling â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

    def _poll_volume(self):
        try:
            while True:
                vol = self.vol_q.get_nowait()
                self._draw_vol(vol)
        except queue.Empty:
            pass
        self.root.after(100, self._poll_volume)

    def _poll_status(self):
        try:
            while True:
                msg = self.status_q.get_nowait()
                if msg.startswith("done:"):
                    text = msg[5:]
                    self.transcription_result = text
                    self._append_transcription(f"\n{text}\n")
                    self._set_state("done", "\u2713 Done", C_GREEN)
                    self.btn_rec.config(state="normal", text="\u25cf  New")
                    self.btn_rec.pack()
                    try:
                        pyperclip.copy(text)
                        self._append_transcription("\n[ Copied to clipboard ]\n")
                        self.lbl_status.config(text="\u2713 COPIED!", fg=C_GREEN)
                    except Exception:
                        self._append_transcription("\n[! Copy to clipboard failed ]\n")
                    # Save transcription to text file
                    try:
                        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
                        txt_path = TRANSCRIPTIONS_DIR / f"transcription_{ts}.txt"
                        txt_path.write_text(text, encoding="utf-8")
                    except Exception as e:
                        self._append_transcription(f"\n[! Could not save text file: {e}]\n")
                elif msg.startswith("err:"):
                    self._append_transcription(f"\n[ERROR] {msg[4:]}\n")
                    self._set_state("idle", "\u2716 ERROR", C_RED)
                    self.lbl_dur.config(text="00:00:00")
                    self._reset_buttons()
                else:
                    self._append_transcription(f"\n{msg}\n")
        except queue.Empty:
            pass
        self.root.after(200, self._poll_status)

    def quit_app(self):
        if self.stream:
            self._stop_stream()
        if self._timer_job:
            self.root.after_cancel(self._timer_job)
        self.root.destroy()

    def run(self):
        self.root.mainloop()


if __name__ == "__main__":
    app = LoreRecorderApp()
    app.run()
