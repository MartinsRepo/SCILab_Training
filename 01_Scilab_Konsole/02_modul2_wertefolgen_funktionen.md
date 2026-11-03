# Modul 2: Wertefolgen & Funktionen – Ganze Messreihen auf einen Schlag

Bisher haben wir mit einzelnen Zahlen gerechnet. In der Physik und Mathematik der 10. Klasse arbeitest du aber fast immer mit **ganzen Messreihen** (z. B. Zeit $t$ und zurückgelegter Weg $s$) oder **Wertetafeln** für Funktionen.

Hier spielt Scilab seine wahre Stärke aus: Statt jeden Wert einzeln in den Taschenrechner einzutippen, rechnen wir mit **Vektoren** (Zahlenlisten) – und erledigen 100 Rechnungen in einem einzigen Wimpernschlag!

---

## 1. Zahlenlisten (Vektoren) erstellen

Ein Vektor ist in Scilab einfach eine Liste von Zahlen in eckigen Klammern `[...]`. Die einzelnen Werte trennst du durch ein Komma `,` oder ein Leerzeichen:

```scilab
--> messung_zeit = [0, 1, 2, 3, 4, 5]
 messung_zeit  =
   0.   1.   2.   3.   4.   5.
```

### Auf einzelne Werte zugreifen
Möchtest du nur den 3. Messwert wissen? Schreibe einfach den Index in runde Klammern `(...)`:

```scilab
--> messung_zeit(3)
 ans  =
   2.
```
> **Wichtig:** In Scilab beginnt die Zählung bei **1** (der erste Wert ist `messung_zeit(1)`). Das ist genau wie in der Schulmathematik!

---

## 2. Zahlenfolgen automatisch erzeugen

Niemand möchte 100 Zahlen von Hand eintippen. Dafür gibt es zwei geniale Werkzeuge in Scilab:

### Methode A: Der Doppelpunkt-Operator (`Start:Schrittweite:Ende`)
Wenn du weißt, welchen Abstand die Zahlen haben sollen:

```scilab
// Zahlen von 0 bis 10 in 2er-Schritten:
--> werte = 0:2:10
 werte  =
   0.   2.   4.   6.   8.   10.

// Zahlen von 0 bis 2 in 0.5er-Schritten:
--> t = 0:0.5:2
 t  =
   0.   0.5   1.   1.5   2.
```
*Tipp:* Wenn du die Schrittweite weglässt (z. B. `1:5`), zählt Scilab automatisch in 1er-Schritten.

### Methode B: Die `linspace`-Funktion
Wenn du weißt, **wie viele Werte** du insgesamt auf einem Intervall haben willst:

$$\text{Syntax: } \text{linspace}(\text{Start}, \text{Ende}, \text{Anzahl})$$

```scilab
// 5 gleichmäßig verteilte Punkte zwischen 0 und 1:
--> linspace(0, 1, 5)
 ans  =
   0.   0.25   0.5   0.75   1.
```
*`linspace` ist perfekt, wenn wir später glatte Kurven zeichnen wollen (z. B. 200 Punkte zwischen $-5$ und $+5$).*

---

## 3. Der wichtigste Trick in Scilab: Der Punkt-Operator (`.*`, `./`, `.^`)

Hier machen 90 % aller Einsteiger ihren ersten Fehler. Pass gut auf:

Angenommen, du hast eine Liste mit Zahlen $x = [1, 2, 3, 4]$ und möchtest jede dieser Zahlen quadrieren ($x^2$).

Wenn du tippst:
```scilab
--> x = [1, 2, 3, 4];
--> x^2
 !--error 10 
Inconsistent multiplication.
```
**Warum meckert Scilab?**  
Scilab denkt bei `x^2` an Matrixmultiplikation aus der linearen Algebra (Mathe-Studium). Du willst aber etwas viel Einfacheres: **Jede einzelne Zahl der Liste soll quadriert werden!**

Dafür setzt du einfach einen **Punkt** vor das Rechenzeichen:

| Gewünschte Operation | Falsch (Fehlermeldung) | Richtig (Elementweise) |
| :--- | :--- | :--- |
| Jedes Element quadrieren | `x^2` | `x.^2` |
| Zwei Listen elementweise multiplizieren | `a * b` | `a .* b` |
| Zwei Listen durcheinander dividieren | `a / b` | `a ./ b` |

Probiere es sofort aus:
```scilab
--> x = [1, 2, 3, 4];
--> x.^2
 ans  =
   1.   4.   9.   16.

--> 10 ./ x
 ans  =
   10.   5.   3.3333333   2.5
```

> [!TIP]
> **Merksatz:**  
> Sobald ein Vektor im Spiel ist und du multiplizierst (`.*`), dividierst (`./`) oder potenzierst (`.^`), gehört ein **Punkt vor das Zeichen**!  
> (Bei `+` und `-` braucht man keinen Punkt, da addiert Scilab ohnehin automatisch jedes Element).

---

## 4. Eigene mathematische Funktionen definieren

Im Matheunterricht schreibst du $f(x) = 2x^2 - 3x + 1$. In Scilab definierst du Funktionen ganz ähnlich mit dem Schlüsselwort `function`:

```scilab
function y = f(x)
    y = 2*x.^2 - 3*x + 1;
endfunction
```
*(Achte auf das `.^2` in der Formel!)*

Jetzt kannst du die Funktion für einzelne Zahlen oder ganze Vektoren aufrufen:
```scilab
// Einzelne Zahl:
--> f(3)
 ans  =
   10.

// Eine ganze Wertetabelle auf einen Schlag:
--> x_werte = -2:1:2;
--> y_werte = f(x_werte)
 y_werte  =
   15.   6.   1.   0.   3.
```
Das spart beim Zeichnen von Wertetabellen im Vergleich zu Papier und Taschenrechner enorm viel Zeit!

---

## 5. Praxisbeispiel aus der 10. Klasse (Physik): Das Hookesche Gesetz

Im Physikunterricht untersucht ihr eine Schraubenfeder: Ihr hängt verschiedene Massestücke an und messt die Auslenkung (Dehnung) $s$.

Das **Hookesche Gesetz** besagt:
$$F = D \cdot s \quad \iff \quad D = \frac{F}{s}$$
Dabei ist $D$ die Federkonstante (Federhärte) in $\text{N/m}$.

### Die Messreihe:
* Auslenkung $s$ in Zentimetern: $2{,}0\,\text{cm}$, $4{,}1\,\text{cm}$, $5{,}9\,\text{cm}$, $8{,}0\,\text{cm}$, $10{,}2\,\text{cm}$
* Gemessene Zugkraft $F$ in Newton: $0{,}5\,\text{N}$, $1{,}0\,\text{N}$, $1{,}5\,\text{N}$, $2{,}0\,\text{N}$, $2{,}5\,\text{N}$

Wir werten die gesamte Messreihe in der Scilab-Konsole aus:

```scilab
// 1. Messdaten erfassen (Dehnung in Meter umrechnen: cm durch 100 teilen!)
s_cm = [2.0, 4.1, 5.9, 8.0, 10.2];
s = s_cm / 100;

// Kräfte in Newton
F = [0.5, 1.0, 1.5, 2.0, 2.5];

// 2. Federhärte D für jeden einzelnen Messpunkt berechnen (elementweise mit ./)
D = F ./ s

// 3. Den Mittelwert der Federhärte bestimmen
D_mittel = mean(D)
```

**Ausgabe in Scilab:**
```scilab
 D  =
   25.   24.390244   25.423729   25.   24.509804

 D_mittel  =
   24.864755
```

**Ergebnis:**  
Die Federkonstante schwankt aufgrund kleiner Messungenauigkeiten nur minimal um $24{,}86\,\text{N/m}$. Mit zwei Zeilen Code hast du die gesamte Physik-Hausaufgabe fehlerfrei ausgewertet!

---

## 6. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Wertetabelle einer quadratischen Funktion (Mathe)
Gegeben ist die Parabel $p(x) = -0{,}5 x^2 + 2x + 1{,}5$.
1. Erzeuge einen Vektor `x` von $-2$ bis $+6$ mit der Schrittweite $0{,}5$.
2. Berechne den Vektor `y` mit der Formel (Punkt-Operator nicht vergessen!).
3. Bei welchem $x$-Wert erreicht die Parabel ihren höchsten Punkt (Scheitelpunkt)? Lies den Wert aus den Daten ab.

### Aufgabe 2: Bremsweg bei verschiedenen Geschwindigkeiten (Physik)
Der reine Bremsweg $s_B$ (ohne Reaktionsweg) bei einer Notbremsung auf trockener Straße mit Bremsverzögerung $a = 7{,}0\,\text{m/s}^2$ berechnet sich nach:
$$s_B = \frac{v^2}{2 \cdot a}$$
1. Erstelle einen Vektor `v_kmh = [30, 50, 80, 100, 130]`.
2. Rechne den gesamten Vektor in $\text{m/s}$ um: `v = v_kmh / 3.6;`.
3. Berechne den Bremsweg-Vektor `s_B` mit `a = 7.0;`.
4. Vergleiche Tempo 50 mit Tempo 100: Wie vervielfacht sich der Bremsweg?
