# Modul 9: Mathematische Rückkopplung – Logistisches Wachstum

In der 10. Klasse lernst du in Mathematik verschiedene Wachstumsmodelle kennen:
1. **Lineares Wachstum:** In jedem Zeitschritt kommt der gleiche Betrag hinzu ($f(t) = m \cdot t + t_0$).
2. **Exponentielles Wachstum:** Die Zunahme ist proportional zum aktuellen Bestand ($f(t) = B_0 \cdot a^t$).
3. **Begrenztes / Logistisches Wachstum:** Nichts auf der Welt kann unendlich wachsen! Irgendwann gehen Nahrung, Platz oder Kunden aus – das Wachstum bremst sich selbst ab und nähert sich einer Sättigungsgrenze (Kapazitätsgrenze $K$).

In diesem Modul bauen wir in Xcos ein **Populations- und Infektionsmodell** auf. Du wirst sehen, wie aus einer einfachen Rückkopplung die berühmte **S-Kurve (Sigmoide)** entsteht!

---

## 1. Die Mathematik des logistischen Wachstums

Stell dir eine Kultur von Hefebakterien in einem Glas Nährlösung vor (oder die Ausbreitung eines witzigen TikTok-Memes an deiner Schule mit 1.000 Schülerinnen und Schülern):

* Zu Beginn gibt es nur sehr wenige Träger ($B_0 = 10$). Sie stecken andere an $\rightarrow$ das Wachstum explodiert zunächst fast **exponentiell**.
* Je mehr Menschen das Video jedoch schon kennen, desto seltener trifft man jemanden, der es noch *nicht* gesehen hat!
* Es gibt $K = 1.000$ Schüler (die Kapazitätsgrenze). Die Zahl der noch uninformierten Schüler ist $(K - B)$.
* Die Wachstumsrate ist daher proportional zum Produkt aus den schon Informierten $B$ und den noch Uninformierten $(K - B)$:

$$\text{Zuwachs pro Stunde } \frac{dB}{dt} = r \cdot B \cdot (K - B)$$

---

## 2. Das Modell in Xcos konstruieren

In Xcos lässt sich diese Wachstumsformel verblüffend elegant und kompakt nachbauen.

### Benötigte Bausteine:
1. `INTEGRAL_m` (Palette *Continuous*): Speichert die aktuelle Anzahl $B(t)$.
   * *Doppelklick:* `Initial condition = 10.0` (wir starten mit 10 Personen).
2. `CONST_m` (Palette *Sources*): Die Gesamtzahl der Schule / Umweltkapazität:
   * *Doppelklick:* Wert = `1000.0`.
3. `SUMMATION` (Palette *Math operations*): Berechnet den noch freien Raum $(K - B)$.
   * *Doppelklick:* Eingänge auf `[1; -1]` stellen (oben Plus für $K$, unten Minus für $B$).
4. `PROD_f` (Palette *Math operations*): Multipliziert $B$ mit $(K - B)$.
5. `GAINBLK` (Palette *Math operations*): Der Übertragungsfaktor $r$.
   * *Doppelklick:* `Gain = 0.0005`.
6. `CSCOPE` & `CLOCK_c`.

---

### Das Schaltschema in Xcos:

```
                   +---------------------------------------------+
                   |                                             |
                   v                                             |
  +--------+    +-----+   (K - B)   +--------+      +---------+  |   Zuwachs   +------------+  B(t)
  |CONST_m |--->|  +  |------------>|        |      | GAINBLK |  +------------>| INTEGRAL_m |----+---> CSCOPE
  | K=1000 |    |  -  |             | PROD_f |----->|r=0.0005 |                |   B0 = 10  |    |
  +--------+    +-----+             |        |      +---------+                +------------+    |
                   ^                +--------+                                                   |
                   |                    ^                                                        |
                   |                    |                                                        |
                   +--------------------+--------------------------------------------------------+
```

### Oszilloskop einstellen & starten:
* `CSCOPE`: `Ymin = 0`, `Ymax = 1100`, `Refresh period = 20`.
* In `Simulation Setup`: `Final integration time = 20.0` Tage / Stunden.
* Klicke auf **Play ▶**!

---

## 3. Die typischen Phasen der S-Kurve erforschen

Auf dem Bildschirm siehst du die klassische logistische Kurve:

1. **Phase 1 (Anlaufphase):** In den ersten Stunden tut sich scheinbar wenig, die Kurve kriecht langsam nach oben.
2. **Phase 2 (Explosionsphase):** Die Kurve schießt steil nach oben. Bei der Hälfte der Kapazität ($B = 500$) ist die Kurve am steilsten – hier ist der **Wendepunkt**! Zu diesem Zeitpunkt verbreitet sich das Meme am schnellsten.
3. **Phase 3 (Sättigungsphase):** Das Wachstum bremst spürbar ab.
4. **Phase 4 (Gleichgewicht):** Die Kurve schmiegt sich perfekt an die 1.000er-Marke an und bleibt dort stabil. Fast jeder kennt das Meme, Neuansteckungen sind kaum noch möglich.

---

## 4. Physik-Vergleich: Kondensator-Aufladung im Smartphone

Das gleiche Prinzip des begrenzten Wachstums begegnet dir in der 10. Klasse Physik bei der Elektrizitätslehre:
Wenn du dein Smartphone an das Schnellladegerät hängst, lädt der Akku (bzw. der Kondensator) anfangs extrem schnell auf (von $0\,\%$ auf $50\,\%$ in 20 Minuten). Je voller der Akku jedoch wird, desto geringer ist die verbleibende Spannungsdifferenz – die letzten $10\,\%$ von $90\,\%$ auf $100\,\%$ dauern am längsten!

In Xcos kannst du diesen Ladevorgang untersuchen, indem du den `PROD_f`-Block weglässt und nur die Differenz $(U_{\text{Lader}} - U_{\text{Akku}})$ über einen Integrator laufen lässt:
$$u_{\text{Lade}}(t) = U_0 \cdot \left(1 - e^{-\frac{t}{\tau}}\right)$$

---

## 5. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Schnelleres Gerücht
Das Meme ist so genial, dass es sich doppelt so schnell herumspricht ($r = 0{,}001$).  
1. Verdopple den Gain im `GAINBLK` auf `0.001`.
2. Nach wie vielen Tagen ist jetzt der Wendepunkt ($500$ Personen) erreicht?

### Aufgabe 2: Kleinere Schule
Simuliere ein Schullandheim mit nur $K = 150$ Jugendlichen und $B_0 = 2$ infizierten Schnupfen-Patienten.
1. Ändere $K$ auf `150` und $B_0$ auf `2`.
2. Passe die Achsen im `CSCOPE` an (`Ymin = 0`, `Ymax = 180`).
3. Welcher Gain-Faktor $r$ führt dazu, dass nach 10 Tagen alle erkältet sind? Experimentiere mit verschiedenen Werten!
