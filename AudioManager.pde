import javax.sound.sampled.*;
public void BeginCapture() {
         try {
            // Set the audio format
            AudioFormat audioFormat = new AudioFormat(AudioFormat.Encoding.PCM_SIGNED, 44100, 16, 2, 4, 44100, false);

            // Get a mixer that supports the specified audio format
            Mixer.Info[] mixerInfos = AudioSystem.getMixerInfo();
            Mixer mixer = null;

            for (Mixer.Info mixerInfo : mixerInfos) {
                mixer = AudioSystem.getMixer(mixerInfo);
                Line.Info[] targetLineInfos = mixer.getTargetLineInfo();
                for (Line.Info targetLineInfo : targetLineInfos) {
                    if (targetLineInfo instanceof DataLine.Info) {
                        AudioFormat[] formats = ((DataLine.Info) targetLineInfo).getFormats();
                        for (AudioFormat format : formats) {
                            if (format.matches(audioFormat)) {
                                break;
                            }
                        }
                        break;
                    }
                }
                break; // Found a suitable mixer, exit the loop
            }

            if (mixer == null) {
                System.err.println("No suitable mixer found!");
                System.exit(1);
            }

            // Get a target data line for capture from the selected mixer
            DataLine.Info dataLineInfo = new DataLine.Info(TargetDataLine.class, audioFormat);
            TargetDataLine targetDataLine = (TargetDataLine) mixer.getLine(dataLineInfo);
            targetDataLine.open(audioFormat);
            targetDataLine.start();

            // Create a buffer to read audio data
            byte[] buffer = new byte[1024];

            // Open a source data line for playback (optional)
            SourceDataLine sourceDataLine = AudioSystem.getSourceDataLine(audioFormat);
            sourceDataLine.open(audioFormat);
            sourceDataLine.start();

            // Capture and play audio in a loop
            while (true) {
                int bytesRead = targetDataLine.read(buffer, 0, buffer.length);
                sourceDataLine.write(buffer, 0, bytesRead);
            }

        } catch (LineUnavailableException e) {
            e.printStackTrace();
        }
}
