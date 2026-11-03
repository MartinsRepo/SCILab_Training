# Modul 1: Die Scilab-Konsole als Super-Taschenrechner

Willkommen in Scilab! In diesem ersten Modul machen wir uns mit der Arbeitsumgebung vertraut. Du wirst sehen, dass Scilab viel mehr kann als dein gewohnter Taschenrechner: Es merkt sich Variablen, rechnet mit extrem hoher Genauigkeit und verzeiht dir Tippfehler, weil du alte Eingaben blitzschnell zurückholen kannst.

---

## 1. Die Scilab-Oberfläche im Überblick

Wenn du **SCILab 2027** startest, siehst du standardmäßig drei wichtige Bereiche:

1. **Die Konsole (Console):** Das Herzstück in der Mitte. Hier blinkt der Eingabe-Prompt `-->`. Genau hier tippst du Befehle ein und drückst **Enter**. Scilab rechnet sofort und zeigt dir das Ergebnis.
2. **Der Variablenbrowser (Variable Browser):** Meist rechts oder links angedockt. Hier siehst du alle Variablen, die du im aktuellen Arbeitsgang erstellt hast, inklusive Typ und aktuellem Wert.
3. **Der Befehlsverlauf (Command History):** Zeigt dir chronologisch alle Befehle, die du bisher eingegeben hast. Ein Doppelklick auf eine Zeile führt sie erneut aus.

---

## 2. Erste Rechnungen in der Konsole

Tippe einfache Rechenausdrücke hinter den Pfeil `-->` und drücke **Enter**:

```scilab
--> 25 + 17
 ans  =
   42.

--> (12 + 8) * 4
 ans  =
   80.

--> 2^10
 ans  =
   1024.
```

> **Was bedeutet `ans`?**  
> `ans` steht für das englische Wort *answer* (Antwort). Wenn du einem Ergebnis keinen eigenen Namen gibst, speichert Scilab das jeweils letzte Ergebnis automatisch in der Hilfsvariablen `ans`.

### Wichtige mathematische Konstanten
Scilab kennt die wichtigsten Zahlen der Mathematik von Haus aus. Um sie von normalen Variablennamen zu unterscheiden, beginnen sie mit einem Prozentzeichen `%`:

* `%pi` steht für die Kreiszahl $\pi \approx 3{,}1415927...$
* `%e` steht für die Eulersche Zahl $e \approx 2{,}7182818...$

Probiere es direkt aus:
```scilab
--> 2 * %pi
 ans  =
   6.2831853

--> %e^2
 ans  =
   7.3890561
```

---

## 3. Variablen: Dein digitaler Notizzettel

Im Mathe- und Physikunterricht willst du Werte oft mehrfach verwenden, z. B. eine Masse $m$, eine Erdbeschleunigung $g$ oder einen Radius $r$. In Scilab kannst du Werte einfach mit einem Gleichheitszeichen `=` einer Variablen zuweisen:

```scilab
--> r = 4.5
 r  =
   4.5

--> flaeche = %pi * r^2
 flaeche  =
   63.617251
```

### Der Zaubertrick mit dem Semikolon `;`
Fällt dir auf, dass Scilab jedes Mal das Ergebnis wiederholt? Wenn du am Ende deiner Zeile ein Semikolon `;` setzt, führt Scilab die Rechnung im Hintergrund aus, **ohne** die Konsole vollzuschreiben:

```scilab
--> breite = 12;
--> hoehe = 5;
--> diagonale = sqrt(breite^2 + hoehe^2)
 diagonale  =
   13.
```
*(Die Funktion `sqrt()` berechnet die Quadratwurzel – engl. square root).*

---

## 4. Profi-Tipps für schnelles Arbeiten

* **Pfeiltasten $\uparrow$ und $\downarrow$:** Wenn du dich vertippt hast, musst du die Zeile nicht neu tippen! Drücke einfach die Taste **Pfeil nach oben**, um den letzten Befehl aufzurufen, passe die Zahl mit **$\leftarrow$** und **$\rightarrow$** an und drücke Enter.
* **Tabulator-Taste ($\rightarrow\vert$):** Tippe `sq` ein und drücke **Tab**. Scilab zeigt dir automatisch alle passenden Funktionen (z. B. `sqrt`).
* **Konsole leeren:** Wenn dein Bildschirm zu voll wird, tippe `clc` ein (steht für *clear console*). Deine Variablen im Speicher bleiben dabei erhalten!

---

## 5. Typische Stolperfallen für Einsteiger

> [!CAUTION]
> **1. Komma vs. Punkt:**  
> In Deutschland schreiben wir $3{,}5$. In Scilab (und fast allen Programmiersprachen der Welt) musst du zwingend den **Dezimalpunkt** verwenden: `3.5`.  
> Ein Komma `,` bedeutet in Scilab: „Hier fängt ein neues Element an!“

> [!WARNING]
> **2. Groß- und Kleinschreibung (Case Sensitivity):**  
> `sqrt(16)` funktioniert. `SQRT(16)` oder `Sqrt(16)` liefert den Fehler `Undefined variable: SQRT`. Achte genau auf Kleinbuchstaben!

> [!NOTE]
> **3. Keine Umlaute oder Sonderzeichen in Variablennamen:**  
> Nenne Variablen `flaeche` statt `fläche` und `hoehe` statt `höhe`. Sonderzeichen wie `ä, ö, ü, ß` führen zu Syntaxfehlern.

---

## 6. Praxisbeispiel aus der 10. Klasse (Physik): Der E-Scooter-Check

In der 10. Klasse Physik lernst du die kinetische Energie (Bewegungsenergie) kennen:
$$E_{kin} = \frac{1}{2} \cdot m \cdot v^2$$

**Die Fragestellung:**  
Ein E-Scooter wiegt samt Fahrerin $m = 85\,\text{kg}$. Gesetzlich erlaubt sind in Deutschland $20\,\text{km/h}$. Viele getunte Scooter fahren jedoch $25\,\text{km/h}$.  
*Wie viel kinetische Energie steckt in beiden Geschwindigkeiten? Um wie viel Prozent steigt die Bremsenergie bei nur $5\,\text{km/h}$ mehr Tempo?*

**Rechne es in der Scilab-Konsole nach:**

```scilab
// Masse in Kilogramm
m = 85;

// Geschwindigkeit 1: 20 km/h in m/s umrechnen (durch 3.6 teilen!)
v1 = 20 / 3.6;

// Geschwindigkeit 2: 25 km/h in m/s
v2 = 25 / 3.6;

// Kinetische Energie berechnen: E = 0.5 * m * v^2
E1 = 0.5 * m * v1^2;
E2 = 0.5 * m * v2^2;

// Ausgabe der Energien in Joule:
E1
E2

// Prozentualer Zuwachs an Zerstörungs-/Bremsenergie:
zuwachs = (E2 - E1) / E1 * 100
```

**Ergebnis in Scilab:**
```scilab
 E1  =
   1311.7284
 E2  =
   2049.5756
 zuwachs  =
   56.25
```

**Physikalische Erkenntnis:**  
Obwohl die Geschwindigkeit nur um $25\,\%$ gestiegen ist (von 20 auf 25 km/h), steigt die Bremsenergie um mehr als **$56\,\%$**!  
Warum? Weil die Geschwindigkeit **quadratisch** ($v^2$) in die Formel eingeht.

---

## 7. Aufgaben: Jetzt bist du dran!

### Aufgabe 1: Der freie Fall vom 10-Meter-Turm (Physik)
Du springst im Freibad vom 10-Meter-Brett ($h = 10\,\text{m}$).  
Die Aufprallgeschwindigkeit lässt sich mit der Energieerhaltung berechnen:
$$v = \sqrt{2 \cdot g \cdot h} \quad \text{mit } g = 9{,}81\,\frac{\text{m}}{\text{s}^2}$$
1. Berechne $v$ in $\text{m/s}$ in der Scilab-Konsole.
2. Rechne die Geschwindigkeit in $\text{km/h}$ um (Ergebnis mit `3.6` multiplizieren).
*(Erwartungswert: ca. $50\,\text{km/h}$!)*

### Aufgabe 2: Volumen und Oberfläche einer Kugel (Mathe)
Für eine Kugel mit Radius $r = 6{,}5\,\text{cm}$ gelten:
$$V = \frac{4}{3} \pi r^3 \quad \text{und} \quad A = 4 \pi r^2$$
1. Definiere die Variable `r = 6.5;`.
2. Berechne das Volumen `V` und die Oberfläche `A`. Benutze `%pi`.
3. Was passiert mit $V$ und $A$, wenn sich der Radius verdoppelt? Teste es mit `r = 13.0;`.
