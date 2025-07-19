mp3_filename = 'my_audio.mp3';

% Read the MP3 file
[audioIn, fs] = audioread(mp3_filename);

wav_filename = 'converted_audio.wav';
audiowrite(wav_filename, audioIn, fs);

disp(['Converted ', mp3_filename, ' to ', wav_filename]);

[audioIn, fs] = audioread('converted_audio.wav');
sound(audioIn, fs); 
disp('Audio loaded successfully');
disp(['Sampling Frequency: ', num2str(fs)]);
t = (0:length(audioIn)-1)/fs; % Time vector
figure;
plot(t, audioIn);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original Audio Signal');
n = length(audioIn); 
Y = abs(fft(audioIn));
f = linspace(0, fs, n); 

figure;
plot(f(1:n/2), Y(1:n/2)); % Plot only positive frequencies
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Spectrum of Original Audio');
cutoff_freq = 1000; 
normalized_cutoff = cutoff_freq / (fs/2);

order = 50; 
b = fir1(order, normalized_cutoff, 'low');

figure;
freqz(b, 1, 1024, fs); 
title('Frequency Response of FIR Low-pass Filter');

audioOut = filter(b, 1, audioIn);


sound(audioOut, fs);
disp('Filtered audio played.');

figure;
subplot(2,1,1);
plot(t, audioIn);
title('Original Audio');

subplot(2,1,2);
plot(t, audioOut);
title('Filtered Audio');
xlabel('Time (s)');
ylabel('Amplitude');


audiowrite('filtered_audio.wav', audioOut, fs);
disp('Filtered audio saved as filtered_audio.wav');

