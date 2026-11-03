# Schüler-Projekt B: Sonnenstunden im Jahresverlauf
**Fachbereich:** Mathematik (Trigonometrie, Modellierung) & Geografie / Astronomie  
**Schwierigkeitsgrad:** Mittel (10. Klasse LehrplanPLUS)

---

## ☀️ Die Ausgangssituation

Im Laufe eines Jahres ändern sich die Tageslängen in Bayern drastisch:
* An der **Wintersonnenwende** (um den 21. Dezember) geht die Sonne spät auf und früh unter: Der Tag hat in München nur ca. **$8{,}3\,\text{Stunden}$** Tageslicht.
* An der **Sommersonnenwende** (um den 21. Juni) scheint die Sonne dagegen fast **$16{,}1\,\text{Stunden}$** lang!
* An den **Tagundnachtgleichen (Äquinoktien)** im Frühling (ca. 21. März) und Herbst (ca. 23. September) sind Tag und Nacht exakt gleich lang: ca. **$12{,}2\,\text{Stunden}$**.

Da die Erde die Sonne in genau $365\,\text{Tagen}$ umkreist, wiederholt sich dieser Vorgang periodisch. Wir können den Verlauf der Tageslänge mit einer einzigen **allgemeinen Sinusfunktion** aus der 10. Klasse beschreiben:
$$f(t) = a \cdot \sin(b \cdot (t - c)) + d$$

---

## 📐 Mathematische Herleitung der Parameter

Bevor wir programmieren, bestimmen wir die vier Parameter mit Mathe-Logik:

1. **Die Ruhelage $d$ (Mittelwert der Tageslänge):**
   $$d = \frac{\text{Maximum} + \text{Minimum}}{2} = \frac{16{,}1 + 8{,}3}{2} = 12{,}2\,\text{Stunden}$$
2. **Die Amplitude $a$ (maximale Schwankung um die Ruhelage):**
   $$a = \frac{\text{Maximum} - \text{Minimum}}{2} = \frac{16{,}1 - 8{,}3}{2} = 3{,}9\,\text{Stunden}$$
3. **Der Frequenzfaktor $b$:**
   Ein volles Jahr hat $T = 365\,\text{Tage}$.
   $$b = \frac{2\pi}{T} = \frac{2\pi}{365} \approx 0{,}017214$$
4. **Die Phasenverschiebung $c$:**
   Die Sinusfunktion $\sin(x)$ startet bei Null und steigt nach oben. Das entspricht im Jahreslauf dem **Frühlingsanfang** (Tagundnachtgleiche am 21. März). Im Kalender ist das etwa der **80. Tag des Jahres**. Also gilt:
   $$c = 80$$

---

## 🛠 Deine Projektaufgaben

### Aufgabe 1: Die Jahresschwingung in Scilab plotten
1. Erstelle ein neues Skript `projekt_B_sonne.sce`.
2. Erzeuge einen Vektor `t = 1:365;` für alle Tage des Jahres.
3. Berechne den Vektor der Tageslängen `tageslaenge` mit der oben hergeleiteten Formel.
4. Plotte die Kurve mit blauem Strich (`"b-"`, Linienbreite 2).
5. Füge ein Gitter, Titel und Achsenbeschriftungen hinzu:
   * x-Achse: „Tag im Jahr (1 bis 365)“
   * y-Achse: „Dauer des Tageslichts in Stunden“

### Aufgabe 2: Reale Messpunkte einblenden
Hier sind die realen Messwerte für jeweils den 21. Tag jedes Monats in München:

| Monat | Tag im Jahr | Reale Tageslänge (h) |
| :--- | :--- | :--- |
| Januar | 21 | 9.0 |
| Februar | 52 | 10.4 |
| März | 80 | 12.2 |
| April | 111 | 14.0 |
| Mai | 141 | 15.4 |
| Juni | 172 | 16.1 |
| Juli | 202 | 15.6 |
| August | 233 | 14.1 |
| September | 264 | 12.3 |
| Oktober | 294 | 10.6 |
| November | 325 | 9.1 |
| Dezember | 355 | 8.3 |

* Zeichne diese Messpunkte als **rote Kreise** (`"ro"`) in denselben Plot ein.
* *Erkenntnis:* Wie gut passt deine mathematische Sinuskurve zu den echten astronomischen Daten?

### Aufgabe 3: Wann sind die Tage besonders lang? (Datenanalyse mit Scilab)
1. Finde mit dem Scilab-Befehl `find()` heraus, an welchen Tagen im Jahr die Sonne **mehr als 14 Stunden** scheint:
   ```scilab
   lange_tage = find(tageslaenge >= 14.0);
   anzahl = length(lange_tage);
   ```
2. An wie vielen Tagen im Jahr dürfen sich die Menschen in Bayern über mindestens 14 Stunden Tageslicht freuen?
3. In welchen Monaten liegen diese Tage?
