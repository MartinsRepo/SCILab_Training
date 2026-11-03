// ===================================================================
// Scilab 2027.0.0 - Beispielskript zu Modul 2
// Thema: Auswertung einer Messreihe zum Hookeschen Gesetz (Physik 10)
// ===================================================================

clc;
clear;

disp("=== Auswertung: Federkonstante D einer Schraubenfeder ===");

// 1. Messwerte erfassen (cm in m umrechnen)
s_cm = [2.0, 4.1, 5.9, 8.0, 10.2];
s = s_cm / 100; // Auslenkung in Meter

F = [0.5, 1.0, 1.5, 2.0, 2.5]; // Gemessene Zugkraft in Newton

// 2. Elementweise Berechnung der Federhärte D = F / s
// Beachte den Punkt-Operator './' !
D = F ./ s;

// 3. Statistische Kennwerte bestimmen
D_mittel = mean(D);
D_min = min(D);
D_max = max(D);

// 4. Schöne Ausgabe in Tabellenform
disp("Messpunkt | Dehnung s (cm) | Kraft F (N) | Federhärte D (N/m)");
disp("------------------------------------------------------------");
for i = 1:length(s)
    m_str = "   " + string(i) + "      |     " + string(s_cm(i)) + " cm     |    " + string(F(i)) + " N    |   " + string(round(D(i)*100)/100) + " N/m";
    disp(m_str);
end
disp("------------------------------------------------------------");
disp("Mittlere Federkonstante D_mittel = " + string(round(D_mittel*100)/100) + " N/m");
disp("Spannweite der Messung: von " + string(round(D_min*100)/100) + " bis " + string(round(D_max*100)/100) + " N/m");
