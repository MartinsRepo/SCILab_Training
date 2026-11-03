// ===================================================================
// Scilab 2027.0.0 - Beispielskript zu Modul 1
// Thema: Kinetische Energie & Bremsenergie beim E-Scooter (Physik 10)
// ===================================================================

// Konsole aufräumen und alle alten Variablen löschen
clc;
clear;

disp("--- Berechnung der kinetischen Energie beim E-Scooter ---");

// 1. Gegebene Werte festlegen
m = 85;               // Masse (Scooter + Fahrerin) in kg
v1_kmh = 20;          // Gesetzliche Höchstgeschwindigkeit in km/h
v2_kmh = 25;          // Leicht getuntes Tempo in km/h

// 2. Umrechnung in physikalische SI-Einheiten (m/s)
v1 = v1_kmh / 3.6;
v2 = v2_kmh / 3.6;

// 3. Berechnung der kinetischen Energie: E = 0.5 * m * v^2
E1 = 0.5 * m * v1^2;  // in Joule (J)
E2 = 0.5 * m * v2^2;  // in Joule (J)

// 4. Differenz und Zuwachs berechnen
diff_E = E2 - E1;
prozent_zuwachs = (diff_E / E1) * 100;

// 5. Ergebnisse formatiert in der Konsole anzeigen
disp("Geschwindigkeit 1: " + string(v1_kmh) + " km/h (" + string(round(v1*100)/100) + " m/s)");
disp("Kinetische Energie 1: " + string(round(E1)) + " Joule");
disp("-------------------------------------------------------");
disp("Geschwindigkeit 2: " + string(v2_kmh) + " km/h (" + string(round(v2*100)/100) + " m/s)");
disp("Kinetische Energie 2: " + string(round(E2)) + " Joule");
disp("-------------------------------------------------------");
disp("Zusätzliche Bremsenergie: +" + string(round(diff_E)) + " Joule");
disp("Prozentualer Zuwachs: +" + string(round(prozent_zuwachs*10)/10) + " %");
