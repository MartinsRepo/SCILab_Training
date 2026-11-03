// ===================================================================
// Scilab 2027.0.0 - Musterlösung zu Schüler-Projekt B
// Thema: Modellierung der Tageslänge in München (Mathe 10 Trigonometrie)
// ===================================================================

clc;
clear;

disp("=========================================================");
disp("       MUSTERLÖSUNG: TAGESLÄNGEN IM JAHRESVERLAUF         ");
disp("=========================================================");

// 1. Mathematische Parameter der allgemeinen Sinusfunktion herleiten:
// f(t) = a * sin(b * (t - c)) + d
T_max = 16.1; // Sommersonnenwende (21. Juni) in Stunden
T_min = 8.3;  // Wintersonnenwende (21. Dezember) in Stunden

d = (T_max + T_min) / 2;       // Ruhelage: 12.2 Stunden
a = (T_max - T_min) / 2;       // Amplitude: 3.9 Stunden
T = 365;                       // Periodendauer: 365 Tage
b = (2 * %pi) / T;             // Frequenzfaktor: ca. 0.0172 rad/Tag
c = 80;                        // Frühlings-Tagundnachtgleiche (ca. 21. März)

disp("Modellparameter:");
disp("- Ruhelage d:  " + string(d) + " Stunden");
disp("- Amplitude a: " + string(a) + " Stunden");
disp("- Periode T:   " + string(T) + " Tage (b = " + string(round(b*10000)/10000) + ")");
disp("- Phase c:     Tag " + string(c) + " (Frühlingsanfang)");
disp("---------------------------------------------------------");

// 2. Mathematische Kurve über das ganze Jahr (365 Tage) berechnen
t = 1:365;
tageslaenge = a * sin(b * (t - c)) + d;

// 3. Reale meteorologische Messwerte für München (jeweils 21. des Monats)
mess_tage = [21, 52, 80, 111, 141, 172, 202, 233, 264, 294, 325, 355];
mess_werte = [9.0, 10.4, 12.2, 14.0, 15.4, 16.1, 15.6, 14.1, 12.3, 10.6, 9.1, 8.3];

// 4. Tage mit mehr als 14 Stunden Tageslicht analysieren
lange_tage = find(tageslaenge >= 14.0);
anzahl_lange_tage = length(lange_tage);
erster_tag = lange_tage(1);
letzter_tag = lange_tage($);

disp("Analyse der langen Sommertage (mindestens 14 Stunden Licht):");
disp("- Anzahl der Tage: " + string(anzahl_lange_tage) + " Tage im Jahr");
disp("- Beginn:          Tag " + string(erster_tag) + " (Mitte April)");
disp("- Ende:            Tag " + string(letzter_tag) + " (Ende August)");
disp("---------------------------------------------------------");

// 5. Grafische Darstellung
clf;
plot(t, tageslaenge, "b-", "LineWidth", 2);
xgrid();

// Reale Messpunkte als rote Punkte einzeichnen
plot(mess_tage, mess_werte, "ro", "MarkerSize", 8, "Thickness", 2);

// 14-Stunden-Schwelle markieren
plot([1, 365], [14, 14], "g--", "LineWidth", 2);

title("Modellierung der Tageslänge in München (Sinusfunktion)", "fontsize", 3);
xlabel("Tag im Jahr (1 = 1. Januar, 365 = 31. Dezember)", "fontsize", 2);
ylabel("Tageslicht in Stunden", "fontsize", 2);
legend(["Sinus-Modell: f(t) = 3.9*sin(b*(t-80)) + 12.2", "Reale Messwerte München (21. jedes Monats)", "14-Stunden-Sommer-Schwelle"]);

disp("Grafikfenster geöffnet. Die Übereinstimmung von Modell und Natur ist exzellent!");
