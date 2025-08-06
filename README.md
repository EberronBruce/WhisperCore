# ``WhisperCore``

WhisperCore is a modular, actor-safe Swift framework for real-time or file-based audio transcription using [Whisper.cpp](https://github.com/ggerganov/whisper.cpp). Designed for embedding into native SwiftUI, UIKit, and cross-platform frameworks like Flutter or React Native.

## 📖 Contents

- [Overview](#overview)
- [Topics](#topics)
- [Example](#example)
- [Model Downloads (for Whisper.cpp)](#model-downloads-for-whispercpp)


## Overview

WhisperCore provides a simplified API for:

- Loading Whisper models (async or callback-based)
- Managing microphone permissions
- Starting, stopping, or toggling audio recording
- Transcribing audio from files
- Optional playback of audio after transcription
- Resetting internal state between sessions
- Receiving transcription results or errors via delegate

It is ideal for voice interfaces, command processing, dictation, or AI-driven mobile assistants.

---

## Topics

### Setup

- ``Whisper/initializeModel(at:)`` – Async/await model loading
- ``Whisper/initializeModel(at:log:completion:)`` – Callback-based model loading
- ``Whisper/callRequestRecordPermission()`` – Requests mic permission from the user

### Recording

- ``Whisper/startRecording()`` – Begins microphone capture
- ``Whisper/stopRecording()`` – Ends microphone capture
- ``Whisper/toggleRecording()`` – Toggles between recording and idle

### Transcription

- ``Whisper/transcribeSample(from:)`` – Transcribes a given audio file

### Playback & State

- ``Whisper/enablePlayback(_:)`` – Enables or disables audio playback
- ``Whisper/reset()`` – Resets the internal state, clears models and sessions
- ``Whisper/canTranscribe()`` – Indicates if transcription is currently possible
- ``Whisper/isRecording()`` – Returns whether audio recording is active
- ``Whisper/isModelLoaded()`` – Returns whether a model is loaded
- ``Whisper/getMessageLogs()`` –  Returns internal logs from WhisperCore
- ``Whisper/benchmark()`` –  Runs model benchmark (DEBUG builds only)

### Delegate Callbacks

To receive transcriptions or error feedback, assign a delegate conforming to ``WhisperDelegate``:

- ``WhisperDelegate/didTranscribe(_:)`` – Called with the transcribed text
- ``WhisperDelegate/recordingFailed(_:)`` – Called when microphone access or recording fails
- ``WhisperDelegate/failedToTranscribe(_:)`` – Called when transcription fails
- ``WhisperDelegate/startRecording(_:)`` – Called when audio recording has started
- ``WhisperDelegate/stopRecording(_:)`` – Called when audio recording has stopped

---

## Example

```swift
class MyHandler: WhisperDelegate {
    func didTranscribe(_ text: String) {
        print("Transcript:", text)
    }

    func recordingFailed(_ error: Error) {
        print("Recording error:", error.localizedDescription)
    }

    func failedToTranscribe(_ error: Error) {
        print("Transcription error:", error.localizedDescription)
    }
}

let whisper = Whisper()
whisper.delegate = MyHandler()

Task {
    let modelPath = Bundle.main.path(forResource: "ggml-base.en", ofType: "bin")! //Example path to model
    try await whisper.initializeModel(at: modelPath)
    await whisper.callRequestRecordPermission()
    await whisper.startRecording()

    // ... wait or monitor user gesture ...

    await whisper.stopRecording()
}


```

## Model Downloads (for Whisper.cpp)

| Model Name              | Info             | Size     | Download URL |
|-------------------------|------------------|----------|---------------|
| tiny                    | F16              | 75 MiB   | [tiny.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.bin) |
| tiny-q5_1               | Quantized        | 31 MiB   | [tiny-q5_1.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny-q5_1.bin) |
| tiny-q8_0               | Quantized        | 42 MiB   | [tiny-q8_0.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny-q8_0.bin) |
| tiny.en                 | F16 (English)    | 75 MiB   | [tiny.en.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en.bin) |
| tiny.en-q5_1            | Quantized        | 31 MiB   | [tiny.en-q5_1.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en-q5_1.bin) |
| tiny.en-q8_0            | Quantized        | 42 MiB   | [tiny.en-q8_0.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en-q8_0.bin) |
| base.en                | F16 (English)    | 142 MiB  | [base.en.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin) |
| base.en-q5_1           | Quantized        | 57 MiB   | [base.en-q5_1.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en-q5_1.bin) |
| base.en-q8_0           | Quantized        | 78 MiB   | [base.en-q8_0.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en-q8_0.bin) |
| small.en-q5_1          | Quantized        | 181 MiB  | [small.en-q5_1.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.en-q5_1.bin) |
| small.en-q8_0          | Quantized        | 252 MiB  | [small.en-q8_0.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small.en-q8_0.bin) |
| large-v3-turbo-q5_0    | Quantized        | 547 MiB  | [large-v3-turbo-q5_0.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo-q5_0.bin) |
| large-v3-turbo-q8_0    | Quantized        | 834 MiB  | [large-v3-turbo-q8_0.bin](https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-turbo-q8_0.bin) |

> 💡 Tip: Smaller quantized models like `tiny-q5_1` load faster and are ideal for lower-end devices or testing. Use `base.en` or larger for more accurate results.
> ✅ Recommended default model for English-only apps: `ggml-base.en.bin` (142 MiB)
You can also explore the [Whisper.cpp GitHub repo](https://github.com/ggerganov/whisper.cpp) for more models, quantization options, and platform-specific setup (including iOS).

## 🔗 Related Repositories

- [WhisperCore iOS Demo](https://github.com/EberronBruce/WhisperCore_iOS_Demo.git) – Project used to build WhsiperCore.


## License

WhisperCore is released under the MIT License.  
See [LICENSE](./LICENSE) for details.
