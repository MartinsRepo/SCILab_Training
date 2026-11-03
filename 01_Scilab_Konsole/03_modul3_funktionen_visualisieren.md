# Modul 3: Funktionen visualisieren (2D-Plotting)

Ein Bild sagt mehr als tausend Zahlen! In der 10. Klasse begegnen dir in Mathematik und Physik ständig Funktionsgraphen: Schwingungen, Wachstumskurven oder Bewegungsdiagramme ($s(t), v(t), a(t)$).

Mit Scilab kannst du Funktionsgraphen in Sekundenschnelle zeichnen, formatieren und vergleichen.

---

## 1. Dein erster Plot: Schritt für Schritt

Um einen Graphen zu zeichnen, brauchst du zwei Dinge:
1. Einen Vektor mit den $x$-Werten (z. B. mit `linspace` erzeugt).
2. Einen Vektor mit den zugehörigen $y$-Werten.

Öffne die Scilab-Konsole und tippe:

```scilab
// 1. Altes Grafikfenster leeren (wichtig!)
clf;

// 2. 200 x-Werte von -2*pi bis +2*pi erzeugen
x = linspace(-2*%pi, 2*%pi, 200);

// 3. Sinus berechnen
y = sin(x);

// 4. Zeichnen!
plot(x, y);
```
Es öffnet sich automatisch das **Grafikfenster (Graphic Window)** mit einer glatten Sinuswelle!

> **Tipp:** Schreibe vor jeden neuen Plot den Befehl `clf;` (*clear figure*). Sonst zeichnet Scilab den neuen Graphen einfach über den alten drüber.

---

## 2. Diagramme veredeln: Titel, Achsen & Gitter

Ein nackter Graph ohne Achsenbeschriftung gibt im Physik- und Matheunterricht Punktabzug. So machst du dein Diagramm schulbuchreif:

```scilab
clf;
x = linspace(0, 10, 100);
y = 0.5 * x.^2;

plot(x, y, "b-"); // "b-" bedeutet: blaue durchgezogene Linie

// Titel und Beschriftungen hinzufügen:
title("Gleichmäßig beschleunigte Bewegung");
xlabel("Zeit t in Sekunden");
ylabel("Zurückgelegter Weg s in Meter");

// Ein Koordinatengitter einblenden:
xgrid();
```

### Farben und Linienstile anpassen
Hinter `plot(x, y, "...")` kannst du das Aussehen festlegen:

* **Farben:** `"r"` (rot), `"b"` (blau), `"g"` (grün), `"k"` (schwarz), `"m"` (magenta), `"c"` (cyan).
* **Linienstile:** `"-"` (durchgezogen), `"--"` (gestrichelt), `":"` (gepunktet), `"-."` (Strich-Punkt).
* **Punkte statt Linien:** `"o"` (Kreise), `"*"` (Sterne), `"+"` (Kreuze).
* *Kombinationen:* `"r--"` (rot gestrichelt), `"k*"` (schwarze Sterne), `"bo-"` (blaue Linie mit Kreis-Markern).

---

## 3. Zwei Kurven in einem Diagramm vergleichen

Wenn du mehrere Funktionen vergleichen willst, übergibst du sie einfach nacheinander an `plot`:

$$\text{Syntax: } \text{plot}(x_1, y_1, \text{"Stil1"}, x_2, y_2, \text{"Stil2"})$$

Mit `legend()` erzeugst du eine Legende in der Ecke:

```scilab
clf;
x = linspace(0, 4*%pi, 200);
y_sin = sin(x);
y_cos = cos(x);

plot(x, y_sin, "b-", x, y_cos, "r--");
xgrid();
title("Vergleich: Sinus vs. Kosinus");
xlabel("Winkel x in Radian");
ylabel("Funktionswert");
legend(["Sinus: sin(x)", "Kosinus: cos(x)"]);
```

---

## 4. LehrplanPLUS Mathe: Schwingungen modellieren

Im Lehrplan der 10. Klasse lernst du die allgemeine Sinusfunktion kennen:
$$f(t) = a \cdot \sin(b \cdot (t - c)) + d$$

* $a$: **Amplitude** (maximale Auslenkung nach oben/unten)
* $b$: **Frequenzfaktor** (Periodendauer $T = \frac{2\pi}{b}$)
* $c$: **Phasenverschiebung** (Verschiebung nach links/rechts)
* $d$: **Ruhelage** (Verschiebung nach oben/unten)

### Praxis-Beispiel: Die Steckdose (Wechselspannung 230 V, 50 Hz)
Die Netzspannung aus der Steckdose in Deutschland schwingt mit einer Frequenz von $f = 50\,\text{Hz}$.  
Die Scheitelspannung beträgt $\hat{U} \approx 325\,\text{V}$ (woraus sich der Effektivwert $230\,\text{V}$ ergibt).

Die Formel lautet:
$$u(t) = 325 \cdot \sin(2\pi \cdot 50 \cdot t)$$

Zeichnen wir zwei volle Schwingungsperioden ($T = \frac{1}{50}\,\text{s} = 0{,}02\,\text{s} \implies 0$ bis $0{,}04\,\text{s}$):

```scilab
clf;
t = linspace(0, 0.04, 500); // 40 Millisekunden
u = 325 * sin(2 * %pi * 50 * t);

plot(t * 1000, u, "r-"); // t * 1000 rechnet Sekunden in Millisekunden um
xgrid();
title("Wechselspannung aus der Steckdose (50 Hz)");
xlabel("Zeit t in Millisekunden (ms)");
ylabel("Spannung u(t) in Volt");
```

---

## 5. LehrplanPLUS Mathe: Exponentieller Zerfall (Koffeinabbau)

Ein klassisches Thema der 10. Klasse sind **Exponentialfunktionen**.  
Trinkst du nachmittags ein großes Glas Cola oder einen Energy-Drink, nimmst du etwa $N_0 = 80\,\text{mg}$ Koffein auf.  
Die biologische **Halbwertszeit** im menschlichen Körper beträgt etwa $T_{1/2} = 5\,\text{Stunden}$.

Das bedeutet: Alle 5 Stunden halbiert sich die verbleibende Koffeinmenge:
$$N(t) = N_0 \cdot \left(\frac{1}{2}\right)^{\frac{t}{T_{1/2}}} = 80 \cdot 0{,}5^{\frac{t}{5}}$$

Wir plotten den Abbau über 24 Stunden und markieren die Halbwertszeit:

```scilab
clf;
t = linspace(0, 24, 200); // 24 Stunden
N0 = 80;
T_halb = 5;

N = N0 * (0.5).^(t / T_halb);

plot(t, N, "b-");
xgrid();
title("Koffeinabbau im Körper über 24 Stunden");
xlabel("Zeit t in Stunden");
ylabel("Koffeinmenge im Blut in mg");

// Halbwertszeit-Linie einzeichnen (nach 5 Stunden nur noch 40 mg):
plot([5, 5], [0, 40], "r--");
plot([0, 5], [40, 40], "r--");
legend(["Koffeinverlauf N(t)", "Halbwertszeit: nach 5h noch 40 mg"]);
```

---

## 6. LehrplanPLUS Physik: Bewegungsdiagramme ($s(t), v(t), a(t)$) mit Subplots

In der Physik ist der Zusammenhang zwischen Beschleunigung $a$, Geschwindigkeit $v$ und Ort $s$ zentral.  
Mit dem Befehl `subplot(Zeilen, Spalten, Nummer)` können wir mehrere Diagramme sauber untereinander anordnen!

### Beispiel: Ein anfahrender Zug (gleichmäßig beschleunigt mit $a = 0{,}8\,\text{m/s}^2$ über $10\,\text{s}$):
* $a(t) = 0{,}8\,\text{m/s}^2 = \text{konstant}$
* $v(t) = a \cdot t$
* $s(t) = \frac{1}{2} \cdot a \cdot t^2$

```scilab
clf;
t = linspace(0, 10, 100);
a_wert = 0.8;

a = a_wert * ones(t);      // Konstante Beschleunigung
v = a_wert * t;            // Lineare Geschwindigkeit
s = 0.5 * a_wert * t.^2;   // Quadratischer Weg

// 1. Diagramm oben: s(t)
subplot(3, 1, 1);
plot(t, s, "b-");
xgrid();
ylabel("s in m");
title("Kinematik: s(t), v(t) und a(t) im direkten Vergleich");

// 2. Diagramm Mitte: v(t)
subplot(3, 1, 2);
plot(t, v, "g-");
xgrid();
ylabel("v in m/s");

// 3. Diagramm unten: a(t)
subplot(3, 1, 3);
plot(t, a, "r-");
xgrid();
xlabel("Zeit t in s");
ylabel("a in m/s²");
```

---

## 7. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Dämpfung einer Schwingung (Physik/Mathe)
Wenn du ein Lineal auf der Tischkante anzupfst, schwingt es, wird aber durch Reibung immer leiser.  
Modelliere eine gedämpfte Schwingung:
$$y(t) = e^{-0{,}5 \cdot t} \cdot \sin(4 \cdot t)$$
1. Erzeuge einen Zeitvektor `t` von $0$ bis $10$ mit 300 Punkten.
2. Berechne `y`. Vergiss nicht den Punkt-Operator: `exp(-0.5 * t) .* sin(4 * t)`.
3. Plotte die Schwingung in grüner Farbe mit Gitter und Achsenbeschriftung.

### Aufgabe 2: Zinseszins und Vermögenswachstum (Mathe)
Du legst dein Konfirmations-/Geburtstagsgeld von $1000\,€$ zu einem Zinssatz von $4\,\%$ an.  
Formel: $K(t) = 1000 \cdot 1{,}04^t$.  
Plotte das Kapital über $t = 0$ bis $t = 30$ Jahre. Nach wie vielen Jahren hat sich dein Geld verdoppelt? Lies es am Graphen ab!
