% 1. Veriyi Rastgele Karıştır ve %80 Train, %20 Validation olarak Böl
num_samples = length(Y_Train);
cv = cvpartition(num_samples, 'HoldOut', 0.2);

idxTrain = training(cv);
idxValidation = test(cv);

% Eğitim Seti (%80)
X_Train_Final = X_Train_Cell_Norm(idxTrain);
Y_Train_Final = Y_Train(idxTrain);

% Doğrulama Seti (%20) - Modelin ilk defa göreceği "Sınav" verileri
X_Validation = X_Train_Cell_Norm(idxValidation);
Y_Validation = Y_Train(idxValidation);

% 2. Eğitim Ayarlarını Validation İçerecek Şekilde Güncelle
% Öğrenme hızını (0.001) normal seviyeye çektik ki grafiğin oturuşunu görebilelim.
options = trainingOptions('adam', ...
    'MaxEpochs', 30, ...
    'MiniBatchSize', 16, ...
    'InitialLearnRate', 0.001, ... 
    'ValidationData', {X_Validation, Y_Validation}, ... % İŞTE YENİ VALIDATION SETİMİZ
    'ValidationFrequency', 5, ... % Her 5 iterasyonda bir modeli sınava sok
    'Plots', 'training-progress', ...
    'Verbose', false);

% 3. Modeli Gerçekçi Bir Testle Tekrar Eğit
disp('Validation seti eklendi. Model tekrar eğitiliyor...');
trainedNetwork_1 = trainNetwork(X_Train_Final, Y_Train_Final, layers, options);
disp('Eğitim Tamamlandı!');