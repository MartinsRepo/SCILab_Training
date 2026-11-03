# Xcos-Block-Katalog: Die 10 wichtigsten Bausteine

In Xcos baust du physikalische und mathematische Modelle grafisch auf. Dieser Katalog stellt dir die 10 wichtigsten Standard-Blöcke vor, die du für Schwingungen, Fallbewegungen, Bremsvorgänge und Wachstumsmodelle brauchst.

---

## 🚦 Die Grundregel für Anschlüsse (Ports)
* **Schwarze Anschlüsse (seitlich):** Transportieren **Mess- und Rechenwerte** (z. B. Kraft, Geschwindigkeit, Weg, Spannung).
* **Rote Anschlüsse (oben/unten):** Transportieren **Uhrtakte und Steuersignale** (Events).

---

## 1. `INTEGRAL_m` (Der Integrator)
* **Palette:** `Continuous`
* **Symbol:** `1/s` oder $\int$
* **Anschlüsse:** 1 schwarzer Eingang (links), 1 schwarzer Ausgang (rechts).
* **Wichtigster Parameter:** `Initial condition` (Startwert zur Zeit $t = 0$).
* **Physikalische Bedeutung:**  
  Macht aus Beschleunigung $a$ Geschwindigkeit $v$ ($v = \int a \, dt + v_0$) oder aus Geschwindigkeit $v$ den Weg $s$ ($s = \int v \, dt + s_0$). Das absolute Herzstück jeder Physik-Simulation!

---

## 2. `CSCOPE` (Das Oszilloskop)
* **Palette:** `Sinks`
* **Symbol:** Bildschirm mit Wellenlinie
* **Anschlüsse:** 1 schwarzer Dateneingang (links), 1 roter Takteingang (oben).
* **Wichtigste Parameter:**
  * `Ymin` und `Ymax`: Minimaler und maximaler Bereich der vertikalen Achse.
  * `Refresh period`: Zeitfenster auf der x-Achse (z. B. 20 oder 30 Sekunden).
* **Bedeutung:**  
  Zeigt das Eingangssignal in Echtzeit als Kurve auf einem virtuellen Bildschirm an. Braucht zwingend ein Taktsignal von `CLOCK_c` am roten oberen Eingang!

---

## 3. `CLOCK_c` (Der Taktgeber / Die System-Uhr)
* **Palette:** `Sources` (oder `Events`)
* **Symbol:** Uhr-Symbol mit Pfeil nach unten
* **Anschlüsse:** 1 roter Ausgang (unten).
* **Wichtigster Parameter:** `Period` (Abtastrate, Standard: $0{,}1$ Sekunden).
* **Bedeutung:**  
  Gibt in regelmäßigen Zeitabständen einen Steuerimpuls aus. Wird per roter Leitung mit dem oberen Eingang von `CSCOPE` verbunden, damit das Oszilloskop weiß, wann es den Bildschirm aktualisieren soll.

---

## 4. `CONST_m` (Konstanter Wert)
* **Palette:** `Sources`
* **Symbol:** `C` oder Zahl
* **Anschlüsse:** 1 schwarzer Ausgang (rechts).
* **Wichtigster Parameter:** `Constant value` (z. B. `9.81` für die Erdbeschleunigung $g$, `1000` für Kapazität).
* **Bedeutung:**  
  Liefert ein dauerhaft unverändertes Signal.

---

## 5. `GAINBLK` (Verstärker / Multiplikation mit einer Zahl)
* **Palette:** `Math operations`
* **Symbol:** Dreieck mit `k`
* **Anschlüsse:** 1 schwarzer Eingang (links), 1 schwarzer Ausgang (rechts).
* **Wichtigster Parameter:** `Gain` (der Multiplikationsfaktor, z. B. `-4.0`, `0.5` oder `1/m`).
* **Bedeutung:**  
  Multipliziert das hereinkommende Signal mit einer festen Zahl: $\text{Ausgang} = \text{Gain} \cdot \text{Eingang}$. Perfekt für Federkonstanten ($D/m$), Dämpfung ($d/m$) oder Vorzeichenwechsel (`-1`).

---

## 6. `SUMMATION` (Summierer / Differenzblock)
* **Palette:** `Math operations`
* **Symbol:** Kreis oder Kasten mit Vorzeichen `+` und `-`
* **Anschlüsse:** 2 schwarze Eingänge (links), 1 schwarzer Ausgang (rechts).
* **Wichtigster Parameter:** `Inputs ports signs/gain` (z. B. `[1; 1]` für Addition oder `[1; -1]` für Subtraktion).
* **Bedeutung:**  
  Addiert oder subtrahiert Kräfte und Signale: $F_{\text{gesamt}} = F_1 - F_2$.

---

## 7. `PROD_f` (Multiplizierer zweier Signale)
* **Palette:** `Math operations`
* **Symbol:** Multiplikationspunkt $\times$
* **Anschlüsse:** 2 schwarze Eingänge (links), 1 schwarzer Ausgang (rechts).
* **Bedeutung:**  
  Multipliziert zwei veränderliche Signale miteinander ($A \cdot B$).  
  *Wichtig für:*
  * Luftwiderstand: $v \cdot v = v^2$.
  * Logistisches Wachstum: $B \cdot (K - B)$.

---

## 8. `GENSIN_f` (Sinuswellen-Generator)
* **Palette:** `Sources`
* **Symbol:** Sinuskurve
* **Anschlüsse:** 1 schwarzer Ausgang (rechts).
* **Wichtigste Parameter:**
  * `Magnitude`: Amplitude $a$ der Schwingung.
  * `Frequency`: Kreisfrequenz $\omega$ in $\text{rad/s}$ ($\omega = 2\pi f$).
* **Bedeutung:**  
  Erzeugt eine saubere Sinusschwingung $y(t) = a \cdot \sin(\omega t)$. Ideal zum Testen von Oszilloskopen und Filtern.

---

## 9. `MUX` (Multiplexer / Signalkabel-Bündler)
* **Palette:** `Signal routing`
* **Symbol:** Schwarzer Balken mit mehreren Eingängen
* **Anschlüsse:** Mehrere schwarze Eingänge (links), 1 gebündelter Ausgang (rechts).
* **Wichtigster Parameter:** `number of input ports or vector of sizes` (z. B. `2` für zwei Kurven).
* **Bedeutung:**  
  Erlaubt es dir, zwei oder mehr Signale (z. B. Weg $s$ und Geschwindigkeit $v$) gemeinsam in ein einziges `CSCOPE` einzuspeisen, sodass beide Kurven gleichzeitig auf demselben Monitor sichtbar sind!

---

## 10. `TOWS_c` (Daten an Scilab senden)
* **Palette:** `Sinks`
* **Symbol:** Pfeil nach außen / Pfeil in Tabelle
* **Anschlüsse:** 1 schwarzer Eingang (links), 1 roter Takteingang (oben).
* **Wichtigster Parameter:** `Variable name` (Name der Variablen in Scilab).
* **Bedeutung:**  
  Speichert die Messwerte der Xcos-Simulation direkt als Vektor in der Scilab-Konsole ab. So kannst du das Simulationsergebnis anschließend in Scilab mit `plot()` hochpräzise weiterverarbeiten oder ausdrucken!
