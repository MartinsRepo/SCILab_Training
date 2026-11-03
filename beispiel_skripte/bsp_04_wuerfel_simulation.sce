// ===================================================================
// Scilab 2027.0.0 - Beispielskript zu Modul 4
// Thema: Stochastik & Simulation (Augensumme zweier Würfel)
// ===================================================================

clc;
clear;

disp("=== Stochastik-Simulation: Wurf von 2 fairen Würfeln ===");

// 1. Anzahl der Simulationsversuche festlegen
N = 50000;
disp("Simuliere " + string(N) + " Würfe mit jeweils 2 Würfeln...");

// 2. Würfe unabhängig voneinander generieren
w1 = grand(1, N, "uin", 1, 6); // Würfel 1 (1 bis 6)
w2 = grand(1, N, "uin", 1, 6); // Würfel 2 (1 bis 6)

// 3. Augensumme bestimmen (Werte zwischen 2 und 12)
summen = w1 + w2;

// 4. Häufigkeiten der Augensummen von 2 bis 12 ermitteln
moegliche_summen = 2:12;
h_absolut = zeros(1, length(moegliche_summen));

for i = 1:length(moegliche_summen)
    s = moegliche_summen(i);
    h_absolut(i) = sum(summen == s);
end

// Relative Häufigkeiten berechnen
h_relativ = (h_absolut / N) * 100; // in Prozent

// 5. Ergebnisse in der Konsole anzeigen
disp("Augensumme | Absolut | Relativ (%) | Theorie (%)");
disp("------------------------------------------------");
// Theoretische Wahrscheinlichkeiten (Kombinationen aus 36)
theorie_kombinationen = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1];
theorie_prozent = (theorie_kombinationen / 36) * 100;

for i = 1:length(moegliche_summen)
    zeile = "    " + string(moegliche_summen(i)) + "      |  " + string(h_absolut(i)) + "  |    " + string(round(h_relativ(i)*100)/100) + " %    |   " + string(round(theorie_prozent(i)*100)/100) + " %";
    disp(zeile);
end

// 6. Grafische Ausgabe als Balkendiagramm
clf;
bar(moegliche_summen, h_absolut, "blue");
xgrid();

title("Simulation der Augensumme zweier Würfel (N = " + string(N) + ")", "fontsize", 3);
xlabel("Augensumme (2 bis 12)", "fontsize", 2);
ylabel("Gemessene Häufigkeit", "fontsize", 2);

disp("Grafikfenster erstellt! Die Glockenform (Dreiecksverteilung) ist deutlich sichtbar.");
