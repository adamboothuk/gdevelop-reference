# GDevelop Audio — Full Reference

Extracted from `AudioExtension.cpp`. Extension ID: `BuiltinAudio`.

> Note: Many actions use `AddCodeOnlyParameter("currentScene", "")` as their
> first parameter. This is internal — do NOT include it in JSON `parameters[]`.
> Parameter numbering in sentences (PARAM0, PARAM1...) starts after code-only params.

---

## Playing Audio

### [ACTION] `PlaySoundOnChannel`
**Label:** Play a sound on a channel
**Sentence:** Play the sound _PARAM1_ on channel _PARAM2_, vol.: _PARAM4_, loop: _PARAM3_
**Parameters:**
- PARAM0: (soundfile) Audio file or resource name
- PARAM1: (expression) Channel identifier (number)
- PARAM2: (yesorno) Repeat — default `"no"`
- PARAM3: (expression) Volume 0–100 — default `100`
- PARAM4: (expression) Pitch/speed — default `1`

```json
{
  "type": { "value": "PlaySoundOnChannel" },
  "parameters": ["\"sound.wav\"", "1", "no", "100", "1"]
}
```

### [ACTION] `PlayMusicOnChannel`
**Sentence:** Play the music _PARAM1_ on channel _PARAM2_, vol.: _PARAM4_, loop: _PARAM3_
**Parameters:** same as `PlaySoundOnChannel` but uses musicfile type

### [ACTION] `PlaySound`
**Label:** Play a sound (no channel)
**Sentence:** Play the sound _PARAM1_, vol.: _PARAM3_, loop: _PARAM2_
**Parameters:**
- PARAM0: (soundfile) Audio file or resource name
- PARAM1: (yesorno) Repeat
- PARAM2: (expression) Volume 0–100
- PARAM3: (expression) Pitch — default `1`

### [ACTION] `PlayMusic`
**Label:** Play a music file (no channel)
**Parameters:** same structure as `PlaySound` using musicfile type

### [ACTION] `PreloadSound`
**Sentence:** Preload the sound file _PARAM1_
**Parameters:** PARAM0: (soundfile) Audio file

### [ACTION] `PreloadMusic`
**Sentence:** Preload the music file _PARAM1_
**Parameters:** PARAM0: (musicfile) Audio file

---

## Stop / Pause / Resume

### [ACTION] `StopSoundChannel`
**Sentence:** Stop the sound of channel _PARAM1_
**Parameters:** PARAM0: (expression) Channel identifier

### [ACTION] `PauseSoundChannel`
**Sentence:** Pause the sound of channel _PARAM1_
**Parameters:** PARAM0: (expression) Channel identifier

### [ACTION] `ResumeSoundChannel`
**Sentence:** Resume the sound of channel _PARAM1_
**Parameters:** PARAM0: (expression) Channel identifier

### [ACTION] `StopMusicChannel`
**Sentence:** Stop the music of channel _PARAM1_
**Parameters:** PARAM0: (expression) Channel identifier

### [ACTION] `PauseMusicChannel`
**Sentence:** Pause the music of channel _PARAM1_
**Parameters:** PARAM0: (expression) Channel identifier

### [ACTION] `ResumeMusicChannel`
**Sentence:** Resume the music of channel _PARAM1_
**Parameters:** PARAM0: (expression) Channel identifier

---

## Volume / Pitch / Offset

### [ACTION] `SetGlobalVolume`
**Sentence:** the global sound level (operator) value
**Parameters:** operator, expression (volume 0–100)

### [ACTION] `SetSoundChannelVolume`
**Sentence:** the volume of the sound on channel _PARAM1_ (operator) value
**Parameters:** PARAM0: (expression) Channel, then operator + value (0–100)

### [ACTION] `SetMusicChannelVolume`
**Parameters:** PARAM0: Channel, then operator + value (0–100)

### [ACTION] `SetSoundChannelPitch`
**Sentence:** the pitch of the sound on channel _PARAM1_ (operator) value
**Parameters:** PARAM0: Channel, then operator + value (1 = default)

### [ACTION] `SetMusicChannelPitch`
**Parameters:** PARAM0: Channel, then operator + value

### [ACTION] `SetSoundChannelPlayingOffset`
**Sentence:** the playing offset of the sound on channel _PARAM1_ (operator) value
**Parameters:** PARAM0: Channel, then operator + value (position in seconds)

### [ACTION] `SetMusicChannelPlayingOffset`
**Parameters:** PARAM0: Channel, then operator + value (seconds)

### [ACTION] `FadeSoundVolume`
**Sentence:** Fade the sound on channel _PARAM1_ to volume _PARAM2_ within _PARAM3_ seconds
**Parameters:**
- PARAM0: (expression) Channel identifier
- PARAM1: (expression) Final volume (0–100)
- PARAM2: (expression) Fading time in seconds

### [ACTION] `FadeMusicVolume`
**Sentence:** Fade the music on channel _PARAM1_ to volume _PARAM2_ within _PARAM3_ seconds
**Parameters:** same as `FadeSoundVolume`

---

## Conditions

### [CONDITION] `SoundPlaying`
**Sentence:** Sound on channel _PARAM1_ is being played
**Parameters:** PARAM0: (expression) Channel

### [CONDITION] `SoundPaused`
**Parameters:** PARAM0: Channel

### [CONDITION] `SoundStopped`
**Parameters:** PARAM0: Channel

### [CONDITION] `MusicPlaying`
**Sentence:** Music on channel _PARAM1_ is being played
**Parameters:** PARAM0: Channel

### [CONDITION] `MusicPaused`
**Parameters:** PARAM0: Channel

### [CONDITION] `MusicStopped`
**Parameters:** PARAM0: Channel

### [CONDITION] `SoundChannelVolume`
**Sentence:** the volume of the sound on channel _PARAM1_ (operator) value
**Parameters:** PARAM0: Channel, then relationalOperator + value

### [CONDITION] `GlobalVolume`
**Sentence:** the global game volume (operator) value
**Parameters:** relationalOperator + value

### [CONDITION] `MusicChannelPitch`
**Parameters:** PARAM0: Channel, then relationalOperator + value

### [CONDITION] `SoundChannelPlayingOffset`
**Parameters:** PARAM0: Channel, then relationalOperator + value

### [CONDITION] `MusicChannelPlayingOffset`
**Parameters:** PARAM0: Channel, then relationalOperator + value

---

## Expressions

| Expression | Description | Parameters |
|-----------|-------------|-----------|
| `GlobalVolume` | Global volume (0–100) | — |
| `SoundChannelVolume` | Volume of sound on channel | channel |
| `MusicChannelVolume` | Volume of music on channel | channel |
| `SoundChannelPitch` | Pitch of sound on channel | channel |
| `MusicChannelPitch` | Pitch of music on channel | channel |
| `SoundChannelPlayingOffset` | Playing position of sound (seconds) | channel |
| `MusicChannelPlayingOffset` | Playing position of music (seconds) | channel |