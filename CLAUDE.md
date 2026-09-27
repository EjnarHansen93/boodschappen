# Boodschappen — projectcontext voor Claude Code

Gedeelde boodschappenlijst voor Ejnar en Shauni (+ aparte lijst voor mama). Mobiel-eerst PWA,
Nederlandstalige UI (Belgisch). Communiceer met Ejnar in het Nederlands, kort en actiegericht.

## Stack (zelfde opzet als OnsBudget)
- Eén bestand `index.html`: React 18 UMD + `@babel/standalone` (JSX in `<script type="text/plain" id="app-src">`),
  `@supabase/supabase-js@2` voor data + realtime. Geen build-stap.
- `manifest.webmanifest`, `icon-512.png` (gerenderd uit `icon.svg`), `.nojekyll` voor GitHub Pages.
- Stijl "A1": poederblauw `--sky #A9C4E0` + marine `--navy #1F3A5F`, titels in Cormorant Garamond.

## Supabase
- Project `lkzxkovpswyllzunrqks` (gedeeld met OnsBudget). Schema: `supabase/schema.sql`.
- `boodschappen_items` (list `samen|mama`, name, qty, category, added_by E/S, done_at) — realtime aan.
- `boodschappen_memory` (name_key → category, times) — leert categorie-correcties en voedt suggesties.
- Toegangscode `ACCESS_CODE = "samen"` (client-side, zoals OnsBudget). `localStorage`: `bs_ok`, `bs_who`, `bs_tab`.

## Logica
- Categorieën in `CATS` (volgorde = weergave): groenten, proteine, zuivel ("Witte artikels"), droog, sauzen, drank, huishoud, andere.
- `guessCat()`: eerst `boodschappen_memory`, dan trefwoorden `KW`. Binnen een woord telt het einde
  (appelSAP → drank), bij meerdere woorden het eerste herkende (yoghurt aardbei → zuivel).
- Afgevinkt = grijs + doorstreept; bij elke load verwijdert de app items met `done_at` ouder dan 24u.
- Zelfde artikel opnieuw toevoegen (open, zelfde lijst) → aantal verhoogd i.p.v. dubbel.
- Mama-tab: "Delen" → WhatsApp / kopiëren / systeem-deelmenu met tekstlijst per categorie.

## Testen
- Lokaal: `npx serve .` → http://localhost:3000 (praat met de **live** database; testdata achteraf opruimen).
