// ===================================================================
// Scilab 2027.0.0 - Beispielskript zu Modul 3 (Teil 2)
// Thema: Exponentieller Zerfall (Koffeinabbau & Halbwertszeit)
// ===================================================================

clc;
clear;

// 1. Parameter
N0 = 80;        // Anfangsdosis Koffein in mg (z. B. 1 Dose Energy Drink)
T_halb = 5;     // Halbwertszeit im menschlichen Körper in Stunden

// 2. Zeitachse über 24 Stunden
t = linspace(0, 24, 300);

// 3. Exponentielle Zerfallsfunktion: N(t) = N0 * (0.5)^(t / T_halb)
// Beachte: Elementweises Potenzieren .^
N = N0 * (0.5).^(t / T_halb);

// 4. Diagramm erstellen
clf;
plot(t, N, "b-", "LineWidth", 2);
xgrid();

title("Biologischer Koffeinabbau im Blut über 24 Stunden", "fontsize", 3);
xlabel("Verstrichene Zeit t in Stunden [h]", "fontsize", 2);
ylabel("Koffeinmenge N(t) in Milligramm [mg]", "fontsize", 2);

// 5. Halbwertszeiten markieren: Nach 5 h (40 mg), nach 10 h (20 mg), nach 15 h (10 mg)
plot([5, 5], [0, 40], "r--");
plot([0, 5], [40, 40], "r--");

plot([10, 10], [0, 20], "m--");
plot([0, 10], [20, 20], "m--");

legend(["Koffeingehalt N(t)", "1. Halbwertszeit: nach 5 h noch 40 mg", "2. Halbwertszeit: nach 10 h noch 20 mg"]);

disp("Koffeinabbau gezeichnet. Nach 24 Stunden verbleiben noch: " + string(round(N($)*10)/10) + " mg im Blut.");
