// ===================================================================
// Scilab 2027.0.0 - Beispielskript zu Modul 3 (Teil 1)
// Thema: Trigonometrie & Schwingung (Wechselspannung 50 Hz)
// ===================================================================

clc;
clear;

// 1. Parameter der Wechselspannung (Steckdose)
U_eff = 230;             // Effektivspannung in Volt
U_max = U_eff * sqrt(2); // Scheitelwert: ca. 325.27 V
f = 50;                  // Netzfrequenz in Hertz (1/s)
omega = 2 * %pi * f;     // Kreisfrequenz

// 2. Zeitvektor für 2 volle Schwingungsperioden (T = 1/50 s = 20 ms)
T_periode = 1 / f;
t = linspace(0, 2 * T_periode, 600); // in Sekunden

// 3. Spannungsverlauf berechnen: u(t) = U_max * sin(omega * t)
u = U_max * sin(omega * t);

// 4. Grafische Darstellung
clf;
plot(t * 1000, u, "r-", "LineWidth", 2); // Zeitachse in Millisekunden anzeigen
xgrid(12);

// Diagramm beschriften
title("Netzwechselspannung in Deutschland (230 V eff, 50 Hz)", "fontsize", 3);
xlabel("Zeit t in Millisekunden [ms]", "fontsize", 2);
ylabel("Momentanspannung u(t) in Volt [V]", "fontsize", 2);

// Wichtige Linien für Effektivwert und Scheitelwert einzeichnen
plot([0, 40], [U_eff, U_eff], "k--");
plot([0, 40], [-U_eff, -U_eff], "k--");
legend(["u(t) = 325 V * sin(2*pi*50*t)", "Effektivwert (+230 V)", "Effektivwert (-230 V)"]);

disp("Netzschwingung erfolgreich gezeichnet! Periodendauer T = 20 ms.");
