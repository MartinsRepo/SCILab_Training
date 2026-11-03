# Schüler-Projekt A: Der autonome Notbremsassistent
**Fachbereich:** Physik (Kinematik, Verkehrserziehung) & Informatik  
**Schwierigkeitsgrad:** Mittel (10. Klasse)

---

## 🚦 Die Ausgangssituation

Stell dir vor, du arbeitest im Entwicklungsteam für autonomes Fahren bei einem Automobilhersteller in Bayern. Du sollst den **autonomen Notbremsassistenten (Autonomous Emergency Braking, AEB)** für ein neues Modell programmieren und testen.

### Das Szenario:
Ein Testfahrzeug fährt innerorts mit genau der zulässigen Höchstgeschwindigkeit von:
$$v_0 = 50\,\text{km/h} \approx 13{,}89\,\text{m/s}$$

Plötzlich springt in einer Entfernung von genau **$d_{\text{Hindernis}} = 22\,\text{Metern}$** ein Fußgänger auf die Fahrbahn!
* Die Kameras und Radarsensoren des Autos erkennen das Hindernis sofort.
* Der Bordcomputer braucht eine technische Rechen- und Druckaufbauzeit von **$t_{\text{System}} = 0{,}2\,\text{Sekunden}$**, bevor die Bremsklötze voll zupacken.

---

## 📋 Die physikalischen Bedingungen

Je nach Wetterlage greifen die Reifen unterschiedlich gut auf dem Asphalt:
1. **Trockener Asphalt (Idealzustand):** Maximale Verzögerung $a_1 = 8{,}5\,\frac{\text{m}}{\text{s}^2}$
2. **Nasse Fahrbahn (Regenschauer):** Reduzierte Verzögerung $a_2 = 4{,}5\,\frac{\text{m}}{\text{s}^2}$
3. **Glätte / Blitzeis im Winter:** Gefährlich geringe Verzögerung $a_3 = 1{,}5\,\frac{\text{m}}{\text{s}^2}$

---

## 🛠 Deine Projektaufgaben

### Aufgabe 1: Berechnungen in der Scilab-Konsole
1. Schreibe ein Scilab-Skript `projekt_A_bremsen.sce`.
2. Berechne für alle 3 Szenarien den Bremsweg $s_B = \frac{v_0^2}{2 \cdot a}$ und addiere den Weg während der Sensor-Reaktionszeit ($s_{\text{Sensor}} = v_0 \cdot t_{\text{System}}$) zum gesamten **Anhalteweg**.
3. **Kollisions-Check:** In welchen Fällen kommt das Auto vor dem Fußgänger zum Stillstand?
4. **Aufprallgeschwindigkeit ermitteln:**  
   Wenn der Anhalteweg größer als $22\,\text{m}$ ist, prallt das Auto gegen das Hindernis. Berechne mit dem Energieansatz die Restgeschwindigkeit beim Aufprall:
   $$v_{\text{Aufprall}} = \sqrt{v_0^2 - 2 \cdot a \cdot (d_{\text{Hindernis}} - s_{\text{Sensor}})}$$
   Rechne $v_{\text{Aufprall}}$ in $\text{km/h}$ um.

### Aufgabe 2: Live-Simulation in Xcos
Baue die Notbremsung in Xcos nach:
* Ein `INTEGRAL_m` für die Geschwindigkeit $v$ ($v_0 = 13{,}89\,\text{m/s}$).
* Ein `INTEGRAL_m` für die Distanz zum Hindernis (Startwert $d_0 = 22\,\text{m}$, es wird rückwärts gezählt!).
* Zeige auf dem `CSCOPE` an, wie sich die Restdistanz verringert.
* Experimentiere mit den drei Verzögerungswerten $a_1, a_2, a_3$.

### Aufgabe 3: Auswertung für den Sicherheitsbericht
Beantworte für deinen Entwicklungsbericht folgende Fragen:
* Wie viel Meter Sicherheitsabstand bleiben bei trockenem Asphalt bis zum Fußgänger übrig?
* Mit welcher Geschwindigkeit prallt das Auto bei Glatteis auf? Hätte der Fußgänger eine Überlebenschance?
* Was würde passieren, wenn das Auto statt 50 km/h mit 60 km/h unterwegs gewesen wäre? Teste es mit deinem Skript!
