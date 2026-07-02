#include "LCD_Ekran_TinyDL_RP.h"
#include "Arduino.h"

// Pico GPIO Pin Tanımlamaları (Segmentlere göre)
#define SEG_A 10 // Ekran Pin 11 (Digit 2)
#define SEG_B 11 // Ekran Pin 10 (Digit 2)
#define SEG_C 12 // Ekran Pin 8 (Digit 2)
#define SEG_D 13 // Ekran Pin 6 (Digit 2)
#define SEG_E 14 // Ekran Pin 5 (Digit 2)
#define SEG_F 16 // Ekran Pin 12 (Digit 2)
#define SEG_G 17 // Ekran Pin 7 (Digit 2)

void clearSegments() {
    digitalWrite(SEG_A, LOW);
    digitalWrite(SEG_B, LOW);
    digitalWrite(SEG_C, LOW);
    digitalWrite(SEG_D, LOW);
    digitalWrite(SEG_E, LOW);
    digitalWrite(SEG_F, LOW);
    digitalWrite(SEG_G, LOW);
}

extern "C" void setupFunctionLCD_Ekran_TinyDL_RP(int8_T I2C_Address, int size_vector__1){
    pinMode(SEG_A, OUTPUT);
    pinMode(SEG_B, OUTPUT);
    pinMode(SEG_C, OUTPUT);
    pinMode(SEG_D, OUTPUT);
    pinMode(SEG_E, OUTPUT);
    pinMode(SEG_F, OUTPUT);
    pinMode(SEG_G, OUTPUT);
    
    // Test: Hepsini 1 saniye yak
    clearSegments();
    digitalWrite(SEG_A, HIGH); digitalWrite(SEG_B, HIGH); digitalWrite(SEG_C, HIGH);
    digitalWrite(SEG_D, HIGH); digitalWrite(SEG_E, HIGH); digitalWrite(SEG_F, HIGH);
    digitalWrite(SEG_G, HIGH);
    delay(1000);
    
    // Test bitti, orta cizgi birak (bekliyor anlaminda)
    clearSegments();
    digitalWrite(SEG_G, HIGH);
}

extern "C" void stepFunctionLCD_Ekran_TinyDL_RP(double AI_Tahmin, int size_vector_a){
    int sonuc = (int)AI_Tahmin;
    
    clearSegments();
    
    if (sonuc == 1) {
        // "1" yazdir
        digitalWrite(SEG_B, HIGH);
        digitalWrite(SEG_C, HIGH);
    } 
    else if (sonuc == 2) {
        // "2" yazdir
        digitalWrite(SEG_A, HIGH);
        digitalWrite(SEG_B, HIGH);
        digitalWrite(SEG_G, HIGH);
        digitalWrite(SEG_E, HIGH);
        digitalWrite(SEG_D, HIGH);
    } 
    else {
        // Diger tum degerler icin "0" yazdir (boyle en azindan birsey gorunur)
        digitalWrite(SEG_A, HIGH);
        digitalWrite(SEG_B, HIGH);
        digitalWrite(SEG_C, HIGH);
        digitalWrite(SEG_D, HIGH);
        digitalWrite(SEG_E, HIGH);
        digitalWrite(SEG_F, HIGH);
    }
}