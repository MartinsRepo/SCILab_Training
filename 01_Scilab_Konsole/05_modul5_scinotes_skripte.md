# Modul 5: Eigene Skripte in SciNotes (Vom Tippen zum Programmieren)

Bisher haben wir Befehle einzeln in die Konsole getippt. Doch was machst du, wenn du dein Programm morgen noch einmal ausführen oder an Freunde weitergeben möchtest?

Dafür gibt es in Scilab den integrierten Programmeditor: **SciNotes**. Hier schreibst du ganze Programme, speicherst sie als Datei ab und startest sie mit einem einzigen Klick!

---

## 1. SciNotes starten und Skripte speichern

1. Klicke in der Menüleiste auf das Editor-Symbol (ein Notizblock mit Stift) oder wähle **Anwendungen $\rightarrow$ SciNotes**.
2. Es öffnet sich der Editor mit einem leeren Dokument `Ohne Titel 1`.
3. Tippe deinen Code ein.
4. Klicke auf **Datei $\rightarrow$ Speichern unter...** und gib deiner Datei einen sinnvollen Namen, z. B. `mein_erstes_skript.sce`.

> **Die Dateiendung `.sce`:**  
> Scilab-Skripte enden auf `.sce` (*Scilab Execution*). Wenn du eine `.sce`-Datei doppelklickst, öffnet Scilab sie automatisch.

### Das Programm ausführen
Um dein Skript auszuführen, klickst du in SciNotes einfach auf den **grünen Play-Button ▶** (oder drückst `Strg + E`).  
Scilab führt den gesamten Code aus und zeigt die Ergebnisse und Plots direkt in der Konsole an!

---

## 2. Strukturierte Programme: Kommentare & Aufräumen

Gute Programmiererinnen und Programmierer halten ihren Code sauber:

```scilab
// ==========================================================
// Programmname: Mein erstes Skript
// Autor: Max Mustermann (Klasse 10a)
// Datum: November 2026
// ==========================================================

clc;   // Leert den Konsolenbildschirm
clear; // Löscht alte Variablen aus dem Speicher
clf;   // Leert das Grafikfenster
```

> **Kommentare mit `//`:**  
> Alles, was hinter zwei Schrägstrichen `//` steht, ignoriert Scilab beim Rechnen. Nutze Kommentare, um deine Gedankengänge festzuhalten!

---

## 3. Bedingungen: Wenn-Dann-Entscheidungen (`if ... then ... else`)

Oft soll der Computer je nach Situation anders reagieren:

```scilab
speed = 65; // Gemessene Geschwindigkeit im Ort

if speed <= 50 then
    disp("Alles super! Vorbildliche Fahrweise.");
elseif speed <= 60 then
    disp("Leichte Überschreitung: Verwarnung!");
else
    disp("Zu schnell! Bußgeld und Punkt in Flensburg drohen.");
end
```

### Vergleichsoperatoren im Überblick:
* `==` : ist gleich (Achtung: zwei Gleichheitszeichen!)
* `<>` oder `~=` : ist ungleich
* `<` / `>` : kleiner / größer als
* `<=` / `>=` : kleiner-gleich / größer-gleich

---

## 4. Schleifen: Wiederholungen automatisieren

### A. Die `for`-Schleife (Feste Anzahl an Schritten)
Wenn du genau weißt, wie oft etwas wiederholt werden soll:

```scilab
// 10 Jahre Zinseszins bei 5 % Zinsen auf 1000 € berechnen:
kapital = 1000;

for jahr = 1:10
    kapital = kapital * 1.05;
    disp("Jahr " + string(jahr) + ": " + string(round(kapital*100)/100) + " €");
end
```

### B. Die `while`-Schleife (Wiederholen, bis ein Ziel erreicht ist)
Wenn du **nicht** im Voraus weißt, wie viele Schritte nötig sind, sondern eine Bedingung das Ende bestimmt:

```scilab
// Wie viele Jahre dauert es, bis sich 1000 € verdoppelt haben?
kapital = 1000;
jahre = 0;

while kapital < 2000
    kapital = kapital * 1.05;
    jahre = jahre + 1;
end

disp("Nach " + string(jahre) + " Jahren ist das Kapital verdoppelt!");
```

---

## 5. Das große Physik-Beispiel: Numerische Bremsweg-Simulation

Im Physikunterricht lernst du die Formel für den Bremsweg bei konstanter Verzögerung $a$:
$$s = \frac{v_0^2}{2 \cdot a}$$

In der Realität bremsen moderne Autos aber mit ABS: Die Bremskraft ändert sich blitzschnell. Wie berechnet ein Bordcomputer den Weg? **Schritt für Schritt (numerisch)!**

Wir teilen die Zeit in winzige Abschnitte $\Delta t = 0{,}01\,\text{Sekunden}$ ein:
* In jedem Zeitschritt sinkt die Geschwindigkeit um: $\Delta v = a \cdot \Delta t$
* In jedem Zeitschritt legt das Auto eine kurze Strecke zurück: $\Delta s = v \cdot \Delta t$
* Das wiederholen wir mit einer `while`-Schleife, bis $v \le 0$ ist!

### Das vollständige Skript (tippe es in SciNotes ein):

```scilab
clc;
clear;

// 1. Ausgangsparameter
v0_kmh = 100;                 // Tempo 100 auf der Landstraße
v = v0_kmh / 3.6;             // Anfangsgeschwindigkeit in m/s (27.78 m/s)
a = 7.0;                      // Bremsverzögerung in m/s² (gute Reifen, trockener Asphalt)
dt = 0.01;                    // Zeitschritt: 10 Millisekunden

// Zähler auf 0 setzen
t = 0;
s = 0;

// Listen für das Diagramm anlegen
t_verlauf = [t];
v_verlauf = [v];
s_verlauf = [s];

// 2. Die Simulationsschleife: Wiederhole, solange das Auto noch rollt
while v > 0
    t = t + dt;               // Zeit läuft weiter
    s = s + v * dt;           // Weg nimmt zu
    v = v - a * dt;           // Geschwindigkeit nimmt ab
    
    // Werte für den Plot mitschreiben
    t_verlauf = [t_verlauf, t];
    v_verlauf = [v_verlauf, max(0, v)]; // v wird nicht kleiner als 0
    s_verlauf = [s_verlauf, s];
end

// 3. Vergleich mit der Schulbuch-Formel:
s_theorie = (v0_kmh / 3.6)^2 / (2 * a);

// 4. Ausgabe
disp("Bremszeit: " + string(round(t*100)/100) + " s");
disp("Simulierter Bremsweg: " + string(round(s*100)/100) + " m");
disp("Schulbuch-Formel:     " + string(round(s_theorie*100)/100) + " m");

// 5. Diagramm zeichnen
clf;
subplot(2, 1, 1);
plot(t_verlauf, v_verlauf * 3.6, "r-", "LineWidth", 2);
xgrid();
title("Notbremsung von 100 km/h auf 0 km/h (a = 7 m/s²)");
ylabel("Geschwindigkeit in km/h");

subplot(2, 1, 2);
plot(t_verlauf, s_verlauf, "b-", "LineWidth", 2);
xgrid();
xlabel("Zeit t in Sekunden");
ylabel("Zurückgelegter Weg in Meter");
```

**Ergebnis:**  
Die numerische Schleife liefert exakt $55{,}1\,\text{m}$ – genauso wie die theoretische Formel!

> **Brücke zu Teil 2 (Xcos):**  
> Genau das, was wir hier in der Schleife von Hand mit `dt` gerechnet haben ($v$ aufsummieren zu $s$), nennt man in der Mathematik **Integration**.  
> In **Teil 2** lernst du, wie man diese Simulation in **Xcos** mit einem einzigen Funktionsblock ganz ohne Programmcode baut!

---

## 6. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Nasse Fahrbahn
Auf regennasser Straße sinkt die Bremsverzögerung drastisch auf $a = 3{,}5\,\text{m/s}^2$ (nur noch halbe Bodenhaftung!).
1. Ändere im Skript `a = 3.5;`.
2. Wie verändern sich Bremszeit und Bremsweg?

### Aufgabe 2: Reaktionszeit einbauen
In Wirklichkeit vergeht vor dem Tritt auf die Bremse etwa $1{,}0\,\text{Sekunde}$ Schreck- und Reaktionszeit. In dieser Zeit fährt das Auto mit vollen $100\,\text{km/h}$ ungebremst weiter!
1. Berechne den Reaktionsweg: $s_{\text{Reaktion}} = v_0 \cdot 1{,}0\,\text{s}$.
2. Addiere ihn zum Bremsweg. Wie lang ist der gesamte Anhalteweg bei trockener und nasser Fahrbahn?
