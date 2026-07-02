% 1. Adım: Verilerin uzunluğunu 50'nin katlarına yuvarla
pencere_boyutu = 50; 
kuru_uzunluk = floor(length(kuru_veri) / pencere_boyutu) * pencere_boyutu;
islak_uzunluk = floor(length(islak_veri) / pencere_boyutu) * pencere_boyutu;

kuru_kesilmis = kuru_veri(1:kuru_uzunluk);
islak_kesilmis = islak_veri(1:islak_uzunluk);

% 2. Adım: Verileri [1 x 50 x Örnek_Sayısı] boyutunda 1D CNN formatına getir (Sıkıştırma)
X_kuru = reshape(kuru_kesilmis, [1, pencere_boyutu, kuru_uzunluk/pencere_boyutu]);
X_islak = reshape(islak_kesilmis, [1, pencere_boyutu, islak_uzunluk/pencere_boyutu]);

% Kuru ve Islak verileri tek bir "X" matrisinde birleştir
X_Train = cat(3, X_kuru, X_islak);

% 3. Adım: Etiketleri (Y_Train) oluştur. 0 = Kuru, 1 = Islak
Y_kuru = zeros(kuru_uzunluk/pencere_boyutu, 1);
Y_islak = ones(islak_uzunluk/pencere_boyutu, 1);
Y_Train = categorical([Y_kuru; Y_islak]); % Sınıflandırma için categorical yapmalıyız

disp('Veri Seti 1D CNN için Hazır!');