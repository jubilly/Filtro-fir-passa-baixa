
fs=44100;
Ts= 1/fs;
%Grava��o do sinal
disp('Come�o da grava��o');
%sinalruido= audiorecorder(fs, 16,1);
%recordblocking(sinalruido, 5);
disp('Fim da grava��o');
disp('Voc� est� ouvindo o som que acabou de gravar');
play(sinalruido);

pause
vetorSom = getaudiodata(sinalruido);

%Ajusta os graficos sinal no tempo e na frequencia
t3 = linspace(0, length(vetorSom)/fs, length(vetorSom));
N3=length(t3);
freq3 = (0:N3-1)* fs/N3;
freq3 = freq3(1:floor(length(freq3)/2));
subplot(211)
plot(t3,vetorSom);
title('Sinal Ru�doso no dominio do tempo');
ylabel('Amplitude');
xlabel('Tempo (s)');

% Gerando o grafico no dominio de frequ�ncia do sinal ruidoso
SINAL_RUIDOSO = fft(vetorSom);
SINAL_RUIDOSO = SINAL_RUIDOSO(1:floor(length(vetorSom)/2));
subplot(212);
plot(freq3,abs(SINAL_RUIDOSO));
title('Sinal Ruidoso no dom�nio da Frequ�ncia');
ylabel('Amplitude');
xlabel('Frequ�ncia (Hz)');

fpass= 0; fstop = 2000;
%normaliza��o das frequencias
wp = (fpass/(fs/2))*pi;
ws = (fstop/(fs/2))*pi;

wt = ws - wp;  % frequencia de transi��o
wc = (wp + ws)/2; % frequencia de corte intermedi�ria

% Filtro passa-baixas FIR
M = ceil((6.2*pi/wt))+1;
hd = ideal_lp(wc,M); % fun��o sinc passa baixas ideal
w_hann = hanning(M)'; % calcula a janela de hanning
h = hd.*w_hann; % multiplica os vetores
figure;
freqz(h); % mostra a magnitude e a fase do filtro;
sinal_filtrado = conv(h, vetorSom);
my_fft(sinal_filtrado, fs); % sinal filtrado no dominio da frequencia
figure;
plot(sinal_filtrado); % sinal filtrado no dominio do tempo

disp('Som filtrado');
sound(sinal_filtrado, fs);