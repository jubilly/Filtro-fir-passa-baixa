%fft


function [X, frequency ] = my_fft(x, fs)
   % normal - normalizar o eixo das abscissas
   normal = length(x);
   v_aux = 0:normal-1; % vetor auxiliar
   T = normal/fs;
   frequency = v_aux/T; % redimensiona o eixo das abscissas 
   X = fft(x)/normal; % normalizar
   fc = ceil(normal/2); % frequência de corte para ajustar os dados do vetor
   X = X(1:fc);
   figure;
   plot(frequency(1:fc), abs(X)); % abs retorna o modulo do sinal no dominino da frequência
   title('Análise de Espectro');
   xlabel('Frequência Hz');
   ylabel('Amplitude');
end


