// ===================================================================
// Scilab 2027.0.0 - Beispielskript zu Modul 3 (Teil 3)
// Thema: Kinematik-Diagramme s(t), v(t), a(t) mit Subplots (Physik 10)
// ===================================================================

clc;
clear;

// 1. Parameter für die Bewegung (Anfahrender Zug)
a_const = 0.8; // konstante Beschleunigung in m/s^2
t_end = 12;    // Beschleunigungsphase über 12 Sekunden

// 2. Zeitachse
t = linspace(0, t_end, 150);

// 3. Physikalische Funktionen berechnen
a = a_const * ones(t);      // a(t) = a = konstant
v = a_const * t;            // v(t) = a * t
s = 0.5 * a_const * t.^2;   // s(t) = 0.5 * a * t^2

// 4. Dreiteiliges Diagramm mit subplots erstellen
clf;

// Teil 1: Weg-Zeit-Diagramm (s-t-Diagramm) - Parabelform!
subplot(3, 1, 1);
plot(t, s, "b-", "LineWidth", 2);
xgrid();
title("Kinematik: Anfahrender Zug mit a = 0.8 m/s²", "fontsize", 3);
ylabel("Weg s in [m]");

// Teil 2: Geschwindigkeits-Zeit-Diagramm (v-t-Diagramm) - Lineare Gerade!
subplot(3, 1, 2);
plot(t, v, "g-", "LineWidth", 2);
xgrid();
ylabel("v in [m/s]");

// Teil 3: Beschleunigungs-Zeit-Diagramm (a-t-Diagramm) - Horizontale!
subplot(3, 1, 3);
plot(t, a, "r-", "LineWidth", 2);
xgrid();
xlabel("Zeit t in Sekunden [s]");
ylabel("a in [m/s²]");

disp("Endwerte nach 12 Sekunden:");
disp("- Zurückgelegter Weg: " + string(s($)) + " m");
disp("- Endgeschwindigkeit: " + string(v($)) + " m/s (" + string(round(v($)*3.6*10)/10) + " km/h)");
