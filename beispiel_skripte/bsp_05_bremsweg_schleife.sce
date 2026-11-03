// ===================================================================
// Scilab 2027.0.0 - Beispielskript zu Modul 5
// Thema: Numerische Bremsweg-Simulation mit While-Schleife (Physik 10)
// ===================================================================

clc;
clear;

disp("=== Numerische Simulation einer Vollbremsung ===");

// 1. Parameter definieren
v0_kmh = 100;              // Ausgangsgeschwindigkeit in km/h
v = v0_kmh / 3.6;          // in m/s (ca. 27.78 m/s)
a = 7.0;                   // Bremsverzögerung in m/s^2 (trockener Asphalt)
dt = 0.01;                 // Simulationszeitschritt in Sekunden (10 ms)

// Variablen für die Simulation
t = 0;
s = 0;

// Messwert-Arrays für Diagramm initialisieren
t_liste = [t];
v_liste = [v];
s_liste = [s];

// 2. Numerische Zeitschritt-Schleife (Euler-Verfahren)
while v > 0
    t = t + dt;
    s = s + v * dt;
    v = v - a * dt;
    
    // Werte mitschreiben
    t_liste = [t_liste, t];
    v_liste = [v_liste, max(0, v)];
    s_liste = [s_liste, s];
end

// 3. Theoretischer Wert nach Lehrbuchformel
s_theorie = (v0_kmh / 3.6)^2 / (2 * a);
t_theorie = (v0_kmh / 3.6) / a;

// 4. Auswertung ausgeben
disp("Ergebnisse der numerischen Simulation:");
disp("- Bremsdauer t_sim    = " + string(round(t*100)/100) + " s (Theorie: " + string(round(t_theorie*100)/100) + " s)");
disp("- Bremsweg s_sim      = " + string(round(s*100)/100) + " m (Theorie: " + string(round(s_theorie*100)/100) + " m)");

// 5. Grafische Auswertung erstellen
clf;
subplot(2, 1, 1);
plot(t_liste, v_liste * 3.6, "r-", "LineWidth", 2);
xgrid();
title("Notbremsung von " + string(v0_kmh) + " km/h auf 0 km/h (a = " + string(a) + " m/s²)", "fontsize", 3);
ylabel("Tempo v(t) in [km/h]", "fontsize", 2);

subplot(2, 1, 2);
plot(t_liste, s_liste, "b-", "LineWidth", 2);
xgrid();
xlabel("Zeit t in Sekunden [s]", "fontsize", 2);
ylabel("Zurückgelegter Weg s(t) in [m]", "fontsize", 2);

disp("Diagramme erfolgreich erstellt!");
