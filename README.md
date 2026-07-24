# Planetarium

Ein didaktisches Planetarium als einzelne HTML-Datei — ohne Installation, ohne
Abhängigkeiten, ohne Server. Sämtliche Berechnungen, Sternkataloge, Stile und
Bilder stecken in `index.html`.

**Version 11 · Build 20260724m**

## Verwenden

Datei herunterladen und im Browser öffnen — das genügt. Für die Veröffentlichung
über GitHub Pages: Diese Dateien in ein Repository legen, unter *Settings →
Pages* den Branch als Quelle wählen, fertig.

Der Aufruf über HTTPS ist empfehlenswert. Zwei Funktionen setzen ihn voraus:

- **Lagemodus** — Browser geben die Lagesensoren nur über gesicherte
  Verbindungen frei. GitHub Pages liefert HTTPS von sich aus.
- **Standort** — die Ortsbestimmung über GPS verlangt ebenfalls HTTPS.

Ohne Internetverbindung bleibt alles nutzbar; lediglich der Original-Funkspruch
zum Raketenstart wird dann durch einen erzeugten Countdown ersetzt.

## Zwei Ansichten

**Himmelsansicht** — die Himmelskuppel von außen betrachtet. Sie eignet sich für
Erklärungen: Bahnen, Kreise und Zusammenhänge sind vollständig zu überblicken.

**Beobachtermodus** — der Blick zum Horizont, wie man ihn tatsächlich hat, mit
Landschaftssilhouette und Kompass. Der Himmel wird stereographisch abgebildet:
winkeltreu, sodass Sternbilder ihre Form behalten und auch der Zenit sauber
dargestellt wird.

## Bedienung

| Schalter | Wirkung |
|---|---|
| **Jetzt** | Himmelsansicht, aktuelle Zeit, Echtzeit; beendet die anderen Modi |
| **▶ / ⏸** | wechselt zwischen Echtzeit und der eingestellten Geschwindigkeit |
| **📱 Lage** | Blick folgt dem Gerät; Zeit läuft dabei in Echtzeit |
| **👁 Ansicht** | Beobachtermodus |

Ziehen bewegt die Zeit beziehungsweise den Blick, zwei Finger seitlich
verschieben die Uhrzeit (nach links vorwärts), senkrecht das Datum. Die
Zwei-Finger-Geste ändert Vergrößerung beziehungsweise Sichtfeld.

Auf der Startseite führt Ziehen nach unten — etwa eine Sekunde gehalten — zum
Neustart mit der Ausgangskonfiguration.

## Genauigkeit

Die astronomischen Größen sind gegen die Standardwerke geprüft:

| Größe | berechnet | Sollwert |
|---|---|---|
| Ekliptikschiefe J2000 | 23,43928° | 23,43928° |
| Sonnendeklination zu den Sonnenwenden | ±23,43° | ±23,44° |
| Rücklauf der Mondknoten | −19,3414°/Jahr | −19,3414°/Jahr |
| Umlaufzeit der Mondknoten | 18,613 Jahre | 18,613 Jahre |
| Neigung der Mondbahn | 5,2° | 5,15° |

Die Präzession folgt Vondrák, Capitaine und Wallace (2011) und bleibt über
±200.000 Jahre gültig. Mond- und Sonnenpositionen stammen aus den Reihen nach
Meeus; der Mond wird topozentrisch dargestellt, also so, wie er vom
Beobachtungsort aus erscheint.

## Aufbau

`index.html` enthält alles: rund 334 CSS-Regeln und vierzehn Skriptblöcke. Der
erste Block trägt die Astronomie und die Darstellung, die übrigen ergänzen die
didaktischen Szenen, Simulationen und Bedienelemente.

## Herkunft der Daten

Sternörter nach Yale Bright Star Catalogue und Hipparcos. Der Funkspruch zum
Raketenstart stammt aus dem gemeinfreien Tonarchiv der NASA.
