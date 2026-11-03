# Modul 7: Physik-Simulation I – Kinematik & Freier Fall mit Luftwiderstand

Im Physikunterricht der 10. Klasse lernst du die Formeln für Beschleunigung, Geschwindigkeit und Weg:
$$v(t) = a \cdot t + v_0 \quad \text{und} \quad s(t) = \frac{1}{2} a \cdot t^2 + v_0 \cdot t + s_0$$

Solange die Beschleunigung $a$ konstant ist, kann man das bequem mit dem Taschenrechner ausrechnen. Doch was passiert, wenn ein Fallschirmspringer aus dem Flugzeug springt und der **Luftwiderstand** mit jedem km/h mehr bremst? 

Plötzlich wird die Beschleunigung mit jedem Meter kleiner! Mit Papier und Stift ist das in Klasse 10 unlösbar (dafür bräuchte man Universitäts-Mathematik).  
In **Xcos** lösen wir dieses reale Problem in 5 Minuten – dank des **Integrator-Blocks**!

---

## 1. Das Herzstück der Physik: Der Integrator-Block (`INTEGRAL_m`)

In der Palette **Continuous** findest du den Block `INTEGRAL_m` (Symbol: $\frac{1}{s}$ oder $\int$).

Er ist die Zaubermaschine der Physik:
* Wenn du vorne eine **Beschleunigung $a$** hineinschickst, kommt hinten die **Geschwindigkeit $v$** heraus.
* Wenn du eine **Geschwindigkeit $v$** hineinschickst, kommt hinten der **zurückgelegte Weg $s$** heraus!

```mermaid
graph LR
    A["Beschleunigung a [m/s²]"] --> B["[INTEGRAL_m]<br/>v(0) = v₀"]
    B -->|Geschwindigkeit v [m/s]| C["[INTEGRAL_m]<br/>s(0) = 0"]
    C --> D["Weg s [m]"]
```

> **Die Anfangsbedingung (Initial Condition):**  
> Ein Auto, das mit $100\,\text{km/h}$ startet, hat eine Anfangsgeschwindigkeit $v_0 > 0$.  
> Mit einem **Doppelklick auf den `INTEGRAL_m`-Block** kannst du den Startwert `Initial condition` festlegen!

---

## 2. Modell 1: Vollbremsung eines Autos in Xcos

Bauen wir das Bremsmodell aus Modul 5 jetzt als Xcos-Schaltung auf:

### Benötigte Blöcke:
1. `CONST_m` (Palette *Sources*): Bremsverzögerung $a = -7{,}0\,\text{m/s}^2$.
2. `INTEGRAL_m` (Palette *Continuous*): Erster Integrator für die Geschwindigkeit $v$.
   * *Doppelklick:* `Initial condition` = `27.78` ($100\,\text{km/h}$ in $\text{m/s}$).
3. `INTEGRAL_m` (Palette *Continuous*): Zweiter Integrator für den Weg $s$.
   * *Doppelklick:* `Initial condition` = `0.0`.
4. `MUX` (Palette *Signal routing*): Bündelt zwei Signale auf eine Leitung, damit wir $v$ und $s$ gemeinsam auf einem Oszilloskop sehen!
5. `CSCOPE` (Palette *Sinks*) & `CLOCK_c` (Palette *Sources*).

### So verbindest du die Blöcke:

```
  +---------+           +------------+  v(t)     +------------+  s(t)
  | CONST_m |---------->| INTEGRAL_m |----+----->| INTEGRAL_m |----+
  | a = -7  |           | v0 = 27.78 |    |      |   s0 = 0   |    |
  +---------+           +------------+    |      +------------+    |
                                          |                        |
                                          v                        v
                                       +------------------------------+
                                       |             MUX              |
                                       +------------------------------+
                                                      |
                                                      v
                                               +--------------+
                                               |    CSCOPE    |
                                               +--------------+
                                                      ^
                                                      | (rot)
                                               +--------------+
                                               |   CLOCK_c    |
                                               +--------------+
```

### Oszilloskop einstellen & starten:
* `CSCOPE` Doppelklick: `Ymin = 0`, `Ymax = 60`, `Refresh period = 10`.
* In **Simulation $\rightarrow$ Setup**: `Final integration time = 5.0` Sekunden.
* Klicke auf **Play ▶**!

**Beobachtung:**  
Du siehst zwei Kurven live entstehen: Die rote Geschwindigkeitslinie fällt linear von $27{,}8\,\text{m/s}$ ab und schneidet nach knapp $4\,\text{Sekunden}$ die Nulllinie. Gleichzeitig steigt die grüne Weg-Kurve parabolisch an und flacht bei ca. $55\,\text{Metern}$ ab. Genau das Verhalten aus dem Physikbuch!

---

## 3. Modell 2: Der Fallschirmsprung mit Luftwiderstand ($v^2$-Bremse)

Jetzt wagen wir uns an ein Problem, das ohne Simulation unlösbar wäre!

Wenn ein Fallschirmspringer ($m = 80\,\text{kg}$) aus dem Flugzeug springt, wirken zwei Kräfte:
1. **Die Erdanziehungskraft** nach unten:  
   $$F_G = m \cdot g = 80\,\text{kg} \cdot 9{,}81\,\frac{\text{m}}{\text{s}^2} \approx 785\,\text{N}$$
2. **Die Luftreibungskraft** nach oben:  
   Sie wächst mit dem Quadrat der Geschwindigkeit:
   $$F_{\text{Luft}} = k \cdot v^2$$
   *(Für einen Menschen in Bauchlage gilt etwa $k \approx 0{,}25\,\text{kg/m}$).*

Die resultierende Beschleunigung ist nach Newtons 2. Gesetz ($F = m \cdot a$):
$$a(t) = g - \frac{k}{m} \cdot v^2 = 9{,}81 - \frac{0{,}25}{80} \cdot v^2 = 9{,}81 - 0{,}003125 \cdot v^2$$

### Die Rückkopplungsschleife (Feedback Loop) in Xcos:
Merkst du das Faszinierende?  
* Die Beschleunigung erzeugt die Geschwindigkeit $v$.
* Aber die Geschwindigkeit $v$ bestimmt wiederum die Reibungskraft und bremst damit die Beschleunigung ab!

In Xcos lässt sich das durch einfaches Zurückführen einer Leitung (Rückkopplung) abbilden:

```
                  +----------------------------------------------+
                  |                                              |
                  v                                              |
 +---------+   +-----+   a(t)   +------------+  v(t)             |
 | CONST_m |--->|  +  |-------->| INTEGRAL_m |--------+--------->+
 | g=9.81  |   |     |          |   v0 = 0   |        |
 +---------+   |  -  |          +------------+        |
               +-----+                                |
                  ^                                   v
                  |                           +---------------+
                  |                           |   PROD_f      |  (Quadrieren:
                  |                           |  (v mal v)    |   v * v = v²)
                  |                           +---------------+
                  |                                   |
                  |                                   v
                  |                           +---------------+
                  +---------------------------|    GAINBLK    |  (Faktor:
                                              | Gain = 0.0031 |   k/m = 0.003125)
                                              +---------------+
```

### Schritt-für-Schritt-Bauanleitung in Xcos:
1. `CONST_m` (Palette *Sources*): Wert `9.81` (Erdbeschleunigung $g$).
2. `SUMMATION` (Palette *Math operations*): 
   * Doppelklick: Ändere die Eingangs-Vorzeichen auf `[1; -1]` (ein Plus- und ein Minus-Eingang).
3. `INTEGRAL_m` (Palette *Continuous*): Startwert `0.0`.
4. `PROD_f` (Palette *Math operations*): Multipliziert zwei Eingänge ($v \times v = v^2$). Ziehe den Geschwindigkeitsausgang an beide schwarzen Eingänge von `PROD_f`.
5. `GAINBLK` (Palette *Math operations*): Multipliziert mit einer Zahl.
   * Doppelklick: `Gain` = `0.003125` ($k/m$).
   * Verbinde den Ausgang des Gain-Blocks mit dem Minus-Eingang des Summierers.
6. Schließe die Geschwindigkeit $v$ an ein `CSCOPE` mit `CLOCK_c` an:
   * `Ymin = 0`, `Ymax = 70` (für bis zu $70\,\text{m/s}$).
   * Simulationszeit: `30` Sekunden.
7. Klicke auf **Play ▶**!

---

## 4. Die physikalische Erkenntnis: Die Grenzgeschwindigkeit

Schau dir die Kurve auf dem Oszilloskop an:
* Zu Beginn (bei $t = 0$) ist $v = 0$, die Reibung ist null. Der Springer fällt mit den vollen $9{,}81\,\text{m/s}^2$ und wird rasant schneller.
* Je schneller er wird, desto heftiger bremst der Gegenwind. Die Kurve wird immer flacher!
* Nach etwa $15\,\text{Sekunden}$ wird die Kurve absolut waagrecht:  
  Die Reibungskraft ist exakt genauso groß geworden wie die Schwerkraft ($F_{\text{Luft}} = F_G$).
* Die Beschleunigung sinkt auf $a = 0$. Der Springer fällt mit konstanter **Grenzgeschwindigkeit** von ca. $56\,\text{m/s}$ (das sind **ca. $200\,\text{km/h}$**)!

> [!NOTE]
> **Warum ist das so genial?**  
> Ohne Luftwiderstand wäre der Springer nach 30 Sekunden mit über $1000\,\text{km/h}$ Überschallgeschwindigkeit unterwegs.  
> Deine Xcos-Simulation zeigt die Realität, wie sie Fallschirmspringer tagtäglich erleben!

---

## 5. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Der Fallschirm öffnet sich!
Wenn der Springer die Reißleine zieht, bläht sich der Fallschirm auf. Der Widerstandsbeiwert steigt schlagartig von $k = 0{,}25$ auf $k = 12{,}0$.
1. Berechne den neuen Gain-Wert: $\text{Gain} = \frac{12{,}0}{80} = 0{,}15$.
2. Ändere im `GAINBLK` den Wert auf `0.15`.
3. Auf welche sichere Sinkgeschwindigkeit bremst der Fallschirm den Springer herunter? Lies den Wert am Oszilloskop ab. *(Tipp: Er liegt unter $10\,\text{m/s}$!)*

### Aufgabe 2: Regentropfen im Sinkflug
Ein kleiner Regentropfen hat ein ganz anderes Verhältnis von Masse zu Reibung.  
Probiere im Modell einen Gain-Faktor von `0.5` aus. Wie schnell fällt ein Regentropfen, wenn er auf deinem Regenschirm landet?
