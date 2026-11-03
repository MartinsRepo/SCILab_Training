# Modul 8: Physik-Simulation II – Mechanische Schwingungen (Das Federpendel)

In der 10. Klasse Physik lernst du **mechanische Schwingungen** kennen: Uhrenpendel, Stoßdämpfer im Auto, Saiten einer Gitarre oder das klassische **Federpendel**.

Bisher hast du in Modul 3 die mathematische Sinusfunktion $y(t) = a \cdot \sin(\omega t)$ gezeichnet. Doch **warum** schwingt ein Körper eigentlich sinusförmig?  
In diesem Modul baust du ein Federpendel in Xcos auf. Du wirst sehen: Eine Sinusschwingung entsteht ganz automatisch, wenn eine Rückstellkraft auf eine träge Masse wirkt!

---

## 1. Die Physik hinter dem Federpendel

Hängst du eine Masse $m$ an eine Feder mit Federhärte $D$ und ziehst sie um die Strecke $x$ nach unten, zieht die Feder nach dem Hookeschen Gesetz mit folgender Kraft zurück:
$$F_{\text{Feder}} = -D \cdot x$$

Nach Newtons berühmtem Grundgesetz der Mechanik gilt:
$$F = m \cdot a \quad \implies \quad a(t) = -\frac{D}{m} \cdot x(t)$$

Schau dir diese Gleichung genau an:
* Die **Beschleunigung $a$** ist proportional zur **Auslenkung $x$** – aber mit einem Minuszeichen (sie will die Masse immer zurück zur Mitte ziehen).
* Aus der Beschleunigung $a$ wird durch Integration die Geschwindigkeit $v$.
* Aus der Geschwindigkeit $v$ wird durch erneute Integration die Auslenkung $x$.
* Und diese Auslenkung $x$ bestimmt wieder die Beschleunigung $a$!

Ein perfekter Kreis – und genau so bauen wir es in Xcos auf!

---

## 2. Modell 1: Das ungedämpfte Federpendel in Xcos

Wir schalten zwei Integratoren hintereinander und schließen die Schleife über einen Verstärkerblock (`GAINBLK`).

### Benötigte Blöcke:
1. Zwei Blöcke `INTEGRAL_m` (Palette *Continuous*):
   * Integrator 1 (Geschwindigkeit $v$): Startwert `Initial condition = 0.0`.
   * Integrator 2 (Auslenkung $x$): Startwert `Initial condition = 0.5` (wir lenken die Feder zu Beginn um $0{,}5\,\text{m}$ aus!).
2. Ein Block `GAINBLK` (Palette *Math operations*):
   * Faktor $\frac{D}{m}$. Nehmen wir für den Start $m = 1\,\text{kg}$ und $D = 4\,\text{N/m}$.  
   * Also: $\text{Gain} = \frac{4}{1} = 4{,}0$.
3. Ein Block `GAINBLK` (Palette *Math operations*) für das Vorzeichen:
   * `Gain = -1.0` (oder du setzt direkt `-4.0` in den ersten Gain-Block!).
4. `CSCOPE` & `CLOCK_c`.

### Das Schaltbild in Xcos:

```
              a(t)             v(t)             x(t)
          +--------->[INTEGRAL_m]--->[INTEGRAL_m]----+----> Zur Anzeige (CSCOPE)
          |           (v0 = 0)       (x0 = 0.5)     |
          |                                         |
          |           +-----------------+           |
          +-----------|     GAINBLK     |<----------+
                      |   Gain = -4.0   |
                      +-----------------+
```

### Oszilloskop einstellen & Simulation starten:
* `CSCOPE`: `Ymin = -0.8`, `Ymax = 0.8`, `Refresh period = 15`.
* `Simulation Setup`: `Final integration time = 15.0`.
* Drücke auf **Play ▶**!

**Ergebnis:**  
Du siehst eine absolut perfekte, unaufhörliche Kosinuskurve! Die Masse schwingt rhythmisch zwischen $+0{,}5\,\text{m}$ und $-0{,}5\,\text{m}$ hin und her.

---

## 3. Der Physik-Mathe-Check: Stimmt die Periodendauer?

In der Physik-Formelsammlung der 10. Klasse steht für die Schwingungsdauer $T$ eines Federpendels:
$$T = 2\pi \cdot \sqrt{\frac{m}{D}}$$

Rechnen wir es für unsere Werte ($m = 1\,\text{kg}$, $D = 4\,\text{N/m}$) aus:
$$T = 2\pi \cdot \sqrt{\frac{1}{4}} = 2\pi \cdot \frac{1}{2} = \pi \approx 3{,}14\,\text{Sekunden}$$

**Schau auf dein Oszilloskop in Xcos:**  
Die erste Spitze ist bei $t = 0$. Die zweite Spitze liegt exakt bei $t \approx 3{,}14\,\text{s}$, die dritte bei $t \approx 6{,}28\,\text{s}$!  
Deine Simulation bestätigt die theoretische Formel bis auf die Nachkommastelle.

---

## 4. Modell 2: Das gedämpfte Federpendel (Reale Reibung)

In der echten Welt schwingt keine Feder ewig. Luftwiderstand und innere Reibung bremsen das System ab.  
Die Bremskraft ist geschwindigkeitsproportional: $F_R = -d \cdot v$.

Die neue Bewegungsgleichung lautet:
$$a(t) = -\frac{D}{m} \cdot x - \frac{d}{m} \cdot v$$

### So erweiterst du deine Schaltung in Xcos:
1. Ersetze den einzelnen Gain-Rückkopplungsdraht durch einen `SUMMATION`-Block mit zwei Minus-Eingängen `[-1; -1]`.
2. Zweige vom Geschwindigkeits-Signal $v$ (Ausgang des ersten Integrators) eine zweite Leitung ab.
3. Führe sie über einen neuen `GAINBLK` (Dämpfungskonstante $d/m$, z. B. `0.4`) auf den zweiten Minus-Eingang des Summierers.

```
                  +-----+   a(t)        v(t)        x(t)
                  |  -  |----->[INT 1]----+--->[INT 2]----+---> CSCOPE
                  |     |       (v0=0)    |    (x0=0.5)   |
                  |  -  |                 |               |
                  +-----+                 |               |
                     ^                    |               |
                     |     +---------+    |               |
                     +-----| GAIN: d |<---+               |
                     |     +---------+                    |
                     |                                    |
                     |     +---------+                    |
                     +-----| GAIN: D |<-------------------+
                           +---------+
```

---

## 5. Die drei Schwingungsfälle der 10. Klasse erforschen

Passe nun die Dämpfungskonstante $d$ im Dämpfungs-Gain-Block an und beobachte, was passiert:

### Fall A: Der Schwingfall (Schwache Dämpfung, z. B. $d = 0{,}3$)
Die Schwingung schwingt munter hin und her, aber die Auslenkung (Amplitude) wird von Periode zu Periode exponentiell kleiner. Nach ca. 20 Sekunden kommt das Pendel zur Ruhe.

### Fall B: Der aperiodische Grenzfall (Kritische Dämpfung, z. B. $d = 4{,}0$)
Erhöhe den Dämpfungs-Gain auf `4.0`.  
Klicke auf Play. **Was passiert?**  
Das Pendel schwingt **überhaupt nicht mehr** über die Nulllinie hinweg! Es kehrt in der schnellstmöglichen Zeit sanft zur Ruhelage zurück.
> **Alltagsbezug:**  
> Genau so werden Stoßdämpfer in Autos und Motorrädern abgestimmt! Würden sie schwingen (Fall A), würde das Auto nach jedem Schlagloch gefährlich hüpfen.

### Fall C: Der Kriechfall (Starke Dämpfung, z. B. $d = 10{,}0$)
Erhöhe den Gain auf `10.0` (wie ein Pendel in dickflüssigem Honig).  
Die Masse braucht ewig, um wieder die Ruhelage zu erreichen – sie „kriecht“ ganz langsam zurück.

---

## 6. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Die Vierfache Masse
Wie ändert sich die Schwingungsdauer, wenn du die Masse vervierfachst ($m = 4\,\text{kg}$ statt $1\,\text{kg}$)?
1. Berechne den neuen Feder-Gain: $\frac{D}{m} = \frac{4}{4} = 1{,}0$.
2. Was sagt die Theorie für die Periodendauer: $T = 2\pi \sqrt{\frac{4}{4}} = 2\pi \approx 6{,}28\,\text{s}$.
3. Stelle den Gain im Modell auf `1.0` (Dämpfung zunächst auf `0`). Schwingt das Pendel jetzt doppelt so langsam? Prüfe es am Oszilloskop!

### Aufgabe 2: Phasenverschiebung zwischen Ort und Geschwindigkeit
Schließe mit einem `MUX`-Block sowohl den Weg $x(t)$ als auch die Geschwindigkeit $v(t)$ an das `CSCOPE` an.  
Wo ist die Geschwindigkeit am größten: Im Nulldurchgang oder an den Wendepunkten der Auslenkung?  
*(Physikalische Begründung: Energieerhaltung zwischen $E_{pot}$ und $E_{kin}$!).*
