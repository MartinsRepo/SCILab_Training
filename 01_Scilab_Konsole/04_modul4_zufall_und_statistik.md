# Modul 4: Zufall & Wahrscheinlichkeit (Stochastik 10. Klasse)

In der 10. Klasse lernst du in Mathe die Grundlagen der Stochastik kennen: Mehrstufige Zufallsexperimente, relative Häufigkeiten, das Gesetz der großen Zahlen und Bernoulli-Ketten.

In der Schule wirft man meist mühsam 20-mal einen echten Holzwürfel und zählt Striche auf dem Papier. In Scilab lassen wir den Computer **100.000 Würfel in weniger als einer Sekunde** werfen! So wird Wahrscheinlichkeit greifbar und sichtbar.

---

## 1. Zufallszahlen in Scilab erzeugen

Scilab bietet mächtige Funktionen für Zufallsexperimente:

### A. Ganzzahlige Zufallszahlen: Die `grand()`-Funktion
Um das Werfen eines sechsseitigen Würfels (Augenzahlen 1 bis 6) zu simulieren:

$$\text{Syntax: } \text{grand}(\text{Zeilen}, \text{Spalten}, \text{"uin"}, \text{Minimum}, \text{Maximum})$$
*(„uin“ steht für uniform integer – gleichmäßig verteilte ganze Zahlen).*

```scilab
// Einen Würfel 1-mal werfen:
--> wuerfel = grand(1, 1, "uin", 1, 6)
 wuerfel  =
   4.

// Einen Würfel 10-mal werfen (eine Zeile mit 10 Werten):
--> serie = grand(1, 10, "uin", 1, 6)
 serie  =
   2.   6.   1.   4.   6.   5.   3.   2.   1.   6.
```

### B. Dezimal-Zufallszahlen zwischen 0 und 1: `rand()`
Die Funktion `rand(1, 5)` liefert 5 Zufallszahlen zwischen $0$ und $1$:
```scilab
--> rand(1, 5)
 ans  =
   0.2113249   0.7560439   0.0002211   0.3303271   0.6653811
```
*Tipp:* Wenn eine Münze mit $50\,\%$ Wahrscheinlichkeit Kopf zeigt, können wir prüfen: `rand() < 0.5`.

---

## 2. Statistische Kennwerte berechnen

Hast du eine Datenreihe vorliegen, liefert Scilab die wichtigsten statistischen Maße mit einem einzigen Befehl:

* `length(v)`: Anzahl der Messwerte im Vektor.
* `sum(v)`: Summe aller Werte.
* `mean(v)`: Arithmetischer Mittelwert (Durchschnitt).
* `min(v)` und `max(v)`: Kleinster und größter Wert.

```scilab
--> noten = [2, 1, 3, 2, 4, 1, 2, 3, 5, 2];
--> durchschnitt = mean(noten)
 durchschnitt  =
   2.5
```

---

## 3. Das Gesetz der großen Zahlen am Bildschirm erleben

Die theoretische Wahrscheinlichkeit, mit einem fairen Würfel eine **6** zu würfeln, beträgt:
$$P(\text{Sechs}) = \frac{1}{6} \approx 0{,}1667 = 16{,}67\,\%$$

Wenn du nur 10-mal würfelst, hast du vielleicht zweimal eine Sechs ($20\,\%$) oder gar keine ($0\,\%$).  
Was passiert aber, wenn wir $N = 100.000$ Würfe simulieren?

Probieren wir es in der Konsole aus:

```scilab
// 100.000 Würfe auf einmal simulieren:
N = 100000;
wuerfe = grand(1, N, "uin", 1, 6);

// Zählen, wie oft genau eine 6 gewürfelt wurde:
// Der Vergleich (wuerfe == 6) liefert eine Liste aus %T (True = 1) und %F (False = 0)
anzahl_sechser = sum(wuerfe == 6);

// Relative Häufigkeit berechnen:
h_relativ = anzahl_sechser / N
```

**Mögliches Ergebnis in Scilab:**
```scilab
 h_relativ  =
   0.16682
```
Die relative Häufigkeit stimmt bis auf die dritte Nachkommastelle mit dem theoretischen Wert $\frac{1}{6} \approx 0{,}16667$ überein!

---

## 4. Häufigkeiten als Balkendiagramm (Histogramm) darstellen

Lass uns zählen, wie oft jede Augenzahl von 1 bis 6 geworfen wurde, und das Ergebnis mit `bar()` als Balkendiagramm zeichnen:

```scilab
clf;
N = 6000; // 6000 Würfe (theoretisch sollte jede Zahl etwa 1000-mal fallen)
wuerfe = grand(1, N, "uin", 1, 6);

// Häufigkeit für jede Zahl von 1 bis 6 ermitteln
haeufigkeit = zeros(1, 6);
for zahl = 1:6
    haeufigkeit(zahl) = sum(wuerfe == zahl);
end

// Balkendiagramm zeichnen:
bar(1:6, haeufigkeit, "blue");
xgrid();

title("Ergebnis von 6.000 Würfen mit einem fairen Würfel");
xlabel("Augenzahl");
ylabel("Absolute Häufigkeit");

// Erwartungswert-Linie bei 1000 einzeichnen
plot([0.5, 6.5], [1000, 1000], "r--", "LineWidth", 2);
legend(["Beobachtete Häufigkeit", "Theoretischer Erwartungswert (1000)"]);
```

---

## 5. LehrplanPLUS Mathe: Die Summe zweier Würfel

Im Unterricht wird oft die Summe beim Wurf von **zwei Würfeln** berechnet (Minimum 2, Maximum 12).  
Welche Summe fällt am häufigsten? Die 7! Warum? Weil es für 7 die meisten Kombinationen gibt: $(1+6, 2+5, 3+4, 4+3, 5+2, 6+1)$.

Mit Scilab simulieren wir das in drei Zeilen:

```scilab
N = 20000;
w1 = grand(1, N, "uin", 1, 6); // Erster Würfel
w2 = grand(1, N, "uin", 1, 6); // Zweiter Würfel

summe = w1 + w2; // Die Augensummen

clf;
haeufigkeiten_summe = zeros(1, 11); // Summen von 2 bis 12 (11 mögliche Werte)
for s = 2:12
    haeufigkeiten_summe(s - 1) = sum(summe == s);
end

bar(2:12, haeufigkeiten_summe, "green");
xgrid();
title("Verteilung der Augensumme zweier Würfel (20.000 Versuche)");
xlabel("Augensumme (2 bis 12)");
ylabel("Absolute Häufigkeit");
```
*Im Diagramm siehst du sofort eine wunderschöne Dreiecksverteilung mit der 7 an der Spitze!*

---

## 6. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Das „Mensch ärgere Dich nicht“-Experiment
Beim Spiel *Mensch ärgere Dich nicht* darfst du deine Spielfigur erst heraussetzen, wenn du eine 6 gewürfelt hast.  
1. Simuliere 1.000 Versuche mit je 3 Würfen (`grand(1, 3, "uin", 1, 6)`).
2. Berechne experimentell die Wahrscheinlichkeit, dass bei 3 Würfen **mindestens eine 6** dabei ist.  
*(Tipp aus der Mathe-Theorie: $P(\text{mind. eine 6}) = 1 - \left(\frac{5}{6}\right)^3 \approx 42{,}1\,\%$).*

### Aufgabe 2: Basketball-Freiwürfe (Bernoulli-Experiment)
Eine Basketballspielerin trifft Freiwürfe mit einer Trefferwahrscheinlichkeit von $p = 75\,\%$ ($0{,}75$).  
1. Simuliere 10 Freiwürfe mit `rand(1, 10) < 0.75`.
2. Wie viele Treffer erzielt sie im Durchschnitt bei 100 Wiederholungen dieser Serie?
