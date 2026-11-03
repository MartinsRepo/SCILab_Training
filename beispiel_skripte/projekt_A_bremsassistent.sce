// ===================================================================
// Scilab 2027.0.0 - Musterlösung zu Schüler-Projekt A
// Thema: Autonomer Notbremsassistent (Physik 10 / Verkehrssicherheit)
// ===================================================================

clc;
clear;

disp("=========================================================");
disp("       MUSTERLÖSUNG: AUTONOMER NOTBREMSASSISTENT         ");
disp("=========================================================");

// 1. Gegebene Parameter
v0_kmh = 50;                     // Innerorts-Geschwindigkeit in km/h
v0 = v0_kmh / 3.6;               // in m/s (ca. 13.89 m/s)
d_hindernis = 22.0;              // Abstand zum Fußgänger beim Erkennen in Meter
t_system = 0.2;                  // Sensor- und Ansprechzeit in Sekunden

// Verzögerungswerte in m/s² für die drei Straßenzustände:
namen = ["1. Trockener Asphalt", "2. Nasse Fahrbahn   ", "3. Blitzeis/Glätte  "];
a_werte = [8.5, 4.5, 1.5];

// 2. Weg während der Systemreaktionszeit
s_reaktion = v0 * t_system; // Auto fährt noch ungebremst mit v0

disp("Ausgangsgeschwindigkeit: " + string(v0_kmh) + " km/h (" + string(round(v0*100)/100) + " m/s)");
disp("Abstand zum Fußgänger:   " + string(d_hindernis) + " m");
disp("Sensor-Reaktionsweg:     " + string(round(s_reaktion*100)/100) + " m");
disp("---------------------------------------------------------");

// 3. Auswertung für jedes Szenario
for i = 1:length(a_werte)
    a = a_werte(i);
    
    // Reiner Bremsweg ab Pedaldruck: s_B = v0^2 / (2 * a)
    s_brems = (v0^2) / (2 * a);
    
    // Gesamter Anhalteweg
    s_gesamt = s_reaktion + s_brems;
    
    disp(namen(i) + " (a = " + string(a) + " m/s²):");
    disp("  - Reiner Bremsweg:     " + string(round(s_brems*100)/100) + " m");
    disp("  - Gesamter Anhalteweg: " + string(round(s_gesamt*100)/100) + " m");
    
    if s_gesamt < d_hindernis then
        sicherheitsabstand = d_hindernis - s_gesamt;
        disp("  -> ERGEBNIS: RECHTZEITIGER STOPP! (" + string(round(sicherheitsabstand*100)/100) + " m Puffer verbleiben)");
    else
        // Aufprall berechnen: Weg nach der Sensorzeit, der zum Bremsen blieb
        d_effektiv = d_hindernis - s_reaktion;
        v_aufprall_ms = sqrt(v0^2 - 2 * a * d_effektiv);
        v_aufprall_kmh = v_aufprall_ms * 3.6;
        disp("  -> ACHTUNG: KOLLISION!");
        disp("  -> Aufprallgeschwindigkeit: " + string(round(v_aufprall_kmh*10)/10) + " km/h (" + string(round(v_aufprall_ms*10)/10) + " m/s)");
    end
    disp("---------------------------------------------------------");
end

// 4. Grafische Darstellung aller drei Verläufe
clf;
t_max = 10;
dt = 0.02;
t = 0:dt:t_max;

farben = ["g-", "b-", "r-"];

for i = 1:length(a_werte)
    a = a_werte(i);
    
    // Verlauf der Distanz zum Hindernis über die Zeit
    distanz = zeros(t);
    for k = 1:length(t)
        akt_t = t(k);
        if akt_t <= t_system then
            // Ungebremste Phase
            distanz(k) = d_hindernis - v0 * akt_t;
        else
            t_brems = akt_t - t_system;
            v_akt = max(0, v0 - a * t_brems);
            // Bereits zurückgelegter Bremsweg
            if v0 - a * t_brems > 0 then
                s_b = v0 * t_brems - 0.5 * a * t_brems^2;
            else
                s_b = (v0^2) / (2 * a);
            end
            distanz(k) = d_hindernis - (s_reaktion + s_b);
        end
    end
    
    plot(t, distanz, farben(i), "LineWidth", 2);
end

xgrid();
title("Notbremsung vor dem Hindernis (22 m Distanz)", "fontsize", 3);
xlabel("Zeit t in Sekunden", "fontsize", 2);
ylabel("Abstand zum Fußgänger in Meter (0 = Kollision)", "fontsize", 2);

// Nulllinie (Kollisionslinie) hervorheben
plot([0, t_max], [0, 0], "k--", "LineWidth", 2);
legend(["Trocken (8.5 m/s²)", "Nass (4.5 m/s²)", "Eis (1.5 m/s²)", "Kollisionsgrenze (Fußgänger)"]);

disp("Simulation beendet. Plotfenster geöffnet!");
