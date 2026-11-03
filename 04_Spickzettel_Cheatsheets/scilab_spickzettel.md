# Scilab-Spickzettel (Cheat Sheet) für die 10. Klasse

Dieser Spickzettel fasst die wichtigsten Befehle, Operatoren und Tipps zusammen, die du für Mathematik und Physik in der 10. Klasse brauchst.

---

## 1. Die goldenen Grundregeln
* **Dezimalpunkt statt Komma:** Immer `3.14` schreiben, niemals `3,14`.
* **Semikolon `;` am Zeilenende:** Führt den Befehl aus, unterdrückt aber die Ausgabe in der Konsole.
* **Groß-/Kleinschreibung:** `sin(x)` funktioniert, `SIN(x)` erzeugt einen Fehler.
* **Kommentare:** Alles hinter zwei Schrägstrichen `//` wird von Scilab ignoriert.

---

## 2. Mathematische Konstanten & Grundfunktionen

| Scilab-Code | Bedeutung | Beispiel |
| :--- | :--- | :--- |
| `%pi` | Kreiszahl $\pi \approx 3{,}14159...$ | `u = 2 * %pi * r` |
| `%e` | Eulersche Zahl $e \approx 2{,}71828...$ | `y = %e^2` |
| `sqrt(x)` | Quadratwurzel $\sqrt{x}$ | `sqrt(16)` $\rightarrow 4$ |
| `abs(x)` | Betrag / Absolutwert \|x\| | `abs(-7.5)` $\rightarrow 7.5$ |
| `exp(x)` | Exponentialfunktion $e^x$ | `exp(-0.5 * t)` |
| `log(x)` | Natürlicher Logarithmus $\ln(x)$ | `log(%e)` $\rightarrow 1$ |
| `sin(x)`, `cos(x)`, `tan(x)` | Trigonometrie (Winkel im **Bogenmaß**!) | `sin(%pi / 2)` $\rightarrow 1$ |
| `round(x)` | Mathematisches Runden auf ganze Zahlen | `round(3.7)` $\rightarrow 4$ |

---

## 3. Vektoren (Zahlenlisten) & Vektorrechnung

| Befehl | Was passiert? |
| :--- | :--- |
| `v = [1, 5, 9]` | Erzeugt eine Liste mit festen Werten. |
| `v(2)` | Greift auf das 2. Element zu (in Scilab startet die Zählung bei 1!). |
| `0:0.5:10` | Zahlen von 0 bis 10 mit Abstand 0.5. |
| `linspace(a, b, n)` | Genau $n$ gleichmäßig verteilte Punkte zwischen $a$ und $b$. |
| `length(v)` | Anzahl der Elemente im Vektor. |
| `min(v)` / `max(v)` | Findet den kleinsten bzw. größten Wert. |
| `sum(v)` | Addiert alle Zahlen des Vektors zusammen. |
| `mean(v)` | Berechnet den arithmetischen Mittelwert (Durchschnitt). |

---

## 4. Der lebenswichtige Punkt-Operator (`.*`, `./`, `.^`)

Wenn du eine Operation mit einer ganzen Zahlenliste (Vektor) durchführen willst:

```scilab
x = [1, 2, 3, 4];

// FALSCH (erzeugt Fehlermeldung):
y = x^2;
y = 10 / x;

// RICHTIG (Elementweise Rechnung):
y = x.^2;     // Liefert [1, 4, 9, 16]
y = 10 ./ x;  // Liefert [10, 5, 3.33, 2.5]
y = x .* x;   // Liefert [1, 4, 9, 16]
```
*(Bei `+` und `-` ist kein Punkt nötig!)*

---

## 5. Grafiken & 2D-Plotting

```scilab
clf;                      // Grafikfenster leeren
x = linspace(0, 10, 200); // 200 Punkte
y = sin(x);

plot(x, y, "b-");         // Zeichnet eine blaue durchgezogene Linie

title("Mein Diagramm");   // Überschrift
xlabel("Zeit t in s");    // x-Achse beschriften
ylabel("Auslenkung in m");// y-Achse beschriften
xgrid();                  // Koordinatengitter einblenden
legend(["Signal 1"]);     // Legende hinzufügen
```

### Format-Kürzel für Linien:
* **Farben:** `"r"` (rot), `"b"` (blau), `"g"` (grün), `"k"` (schwarz), `"m"` (magenta).
* **Stile:** `"-"` (Linie), `"--"` (gestrichelt), `":"` (gepunktet), `"o"` (Kreise), `"*"` (Sterne).

---

## 6. Zufall & Stochastik

```scilab
// Einen Würfel 100-mal werfen (Zahlen von 1 bis 6):
wuerfe = grand(1, 100, "uin", 1, 6);

// Dezimale Zufallszahl zwischen 0 und 1:
p = rand();

// Zählen, wie oft die 6 gewürfelt wurde:
anzahl_sechs = sum(wuerfe == 6);

// Balkendiagramm (Histogramm) zeichnen:
bar(x_werte, haeufigkeiten, "blue");
```

---

## 7. Tastaturkürzel & Konsolen-Hilfen
* **Pfeiltaste nach oben $\uparrow$:** Zuletzt eingetippte Befehle wiederholen und anpassen.
* **Tab-Taste $\rightarrow\vert$:** Automatische Befehlsvervollständigung.
* **`clc`:** Konsole leeren (Variablen bleiben gespeichert).
* **`clear`:** Alle Variablen aus dem Speicher löschen.
* **`help befehl`:** Öffnet das Scilab-Handbuch (z. B. `help plot`).
