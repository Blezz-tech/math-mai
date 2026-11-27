// =============================================================================
// Шаблон оформления, палитра, математические операторы и семантические блоки
// =============================================================================

// Палитра (строгая академическая, хорошо печатается и в цвете, и в ч/б)
#let c-navy     = rgb("#1b365d")
#let c-steel    = rgb("#2d5a88")
#let c-muted    = rgb("#526478")
#let c-border   = rgb("#c9d5e2")
#let c-ice      = rgb("#f2f6fb")
#let c-zebra    = rgb("#f9fbfd")
#let c-sage     = rgb("#2e664b")
#let c-sage-bg  = rgb("#f3f9f5")
#let c-amber    = rgb("#96550f")
#let c-amber-bg = rgb("#fdf7ee")

// Математические операторы в русскоязычной традиции
#let liminf = math.op("lim inf", limits: true)
#let limsup = math.op("lim sup", limits: true)
#let tg     = math.op("tg")
#let ctg    = math.op("ctg")
#let arctg  = math.op("arctg")
#let arcctg = math.op("arcctg")
#let sh     = math.op("sh")
#let ch     = math.op("ch")
#let th     = math.op("th")
#let lg     = math.op("lg")
#let const  = math.op("const")
#let sgn    = math.op("sgn")
#let d      = math.dif

// Семантические блоки
#let proof(title, body) = block(
  width: 100%,
  fill: c-ice,
  stroke: (left: 2pt + c-steel),
  radius: (right: 2.5pt),
  inset: (left: 8.5pt, right: 7.5pt, top: 5.5pt, bottom: 6pt),
  above: 0.4em,
  below: 0.55em,
  breakable: true,
)[
  #block(sticky: true, below: 0.42em)[#text(size: 8.8pt, weight: "bold", fill: c-navy)[#title]]
  #set text(size: 9.6pt)
  #set par(justify: true, leading: 0.64em, spacing: 0.44em)
  #body
]

#let example(title, body) = block(
  width: 100%,
  fill: c-sage-bg,
  stroke: (left: 1.8pt + c-sage),
  radius: (right: 2.5pt),
  inset: (left: 8.5pt, right: 7.5pt, top: 5pt, bottom: 5.5pt),
  above: 0.35em,
  below: 0.45em,
  breakable: true,
)[
  #block(sticky: true, below: 0.4em)[#text(size: 8.8pt, weight: "bold", fill: c-sage)[#title]]
  #set text(size: 9.5pt)
  #set par(justify: true, leading: 0.62em, spacing: 0.38em)
  #body
]

#let trap(body) = block(
  width: 100%,
  fill: c-amber-bg,
  stroke: (left: 2pt + c-amber),
  radius: (right: 2.5pt),
  inset: (left: 8.5pt, right: 7.5pt, top: 5pt, bottom: 5.5pt),
  above: 0.4em,
  below: 0.55em,
  breakable: true,
)[
  #set text(size: 9.4pt)
  #set par(justify: true, leading: 0.6em, spacing: 0.32em)
  #text(weight: "bold", fill: c-amber)[Ловушка билета.] #body
]

#let control_variant(title, body) = block(
  width: 100%,
  fill: rgb("#f8fafd"),
  stroke: (left: 2pt + c-steel, rest: 0.45pt + c-border),
  radius: 2.5pt,
  inset: (x: 7pt, y: 5.5pt),
  breakable: false,
)[
  #text(size: 9.2pt, weight: "bold", fill: c-navy)[#title]
  #v(0.25em)
  #set text(size: 8.6pt)
  #set par(justify: false, leading: 0.52em, spacing: 0.24em)
  #set enum(indent: 0.2em, body-indent: 0.35em, spacing: 0.35em)
  #show math.equation.where(block: true): set block(above: 0.4em, below: 0.4em)
  #body
]

#let badge(lbl, fg, bg) = box(
  fill: bg,
  inset: (x: 4pt, y: 1.5pt),
  radius: 2pt,
  text(size: 7.8pt, weight: "bold", fill: fg)[#lbl],
)

// Глобальная функция оформления документа (используется через `#show: project`)
#let project(body) = {
  set document(
    title: "Математический анализ. I семестр — Билеты и план подготовки",
    author: "Конспект к экзамену (I семестр)",
  )

  set page(
    paper: "a4",
    margin: (top: 1.85cm, bottom: 1.85cm, left: 1.75cm, right: 1.75cm),
    header: context {
      let cur-page = here().page()
      if cur-page > 1 {
        let h1s = query(heading.where(level: 1)).filter(h => h.location().page() <= cur-page)
        let sec = if h1s.len() > 0 { h1s.last().body } else { [] }
        set text(size: 8pt, fill: c-muted)
        grid(
          columns: (auto, 1fr),
          align: (left, right),
          [Математический анализ · I семестр],
          [#sec],
        )
        v(-0.45em)
        line(length: 100%, stroke: 0.4pt + c-border)
      }
    },
    footer: context {
      let p = counter(page).get().first()
      let total = counter(page).final().first()
      set align(center)
      set text(size: 8.5pt, fill: c-muted)
      [— #p / #total —]
    },
  )

  set text(
    font: "New Computer Modern",
    size: 10pt,
    lang: "ru",
    hyphenate: true,
    fill: rgb("#1a1f26"),
  )
  set par(justify: true, leading: 0.68em, spacing: 0.58em)
  set list(indent: 1em, body-indent: 0.45em, spacing: 0.54em)
  set enum(indent: 1em, body-indent: 0.45em, spacing: 0.46em)
  set math.equation(numbering: none)
  show math.equation.where(block: true): set block(above: 0.55em, below: 0.55em)

  // Глобальный компактный стиль таблиц
  set table(
    stroke: 0.45pt + c-border,
    inset: (x: 4.5pt, y: 3.4pt),
    align: left + top,
    fill: (_, y) => if y == 0 { c-navy } else if calc.odd(y) { white } else { c-zebra },
  )
  show table.cell: set text(size: 8.3pt)
  show table.cell: set par(justify: false, leading: 0.64em, spacing: 0.25em)
  show table.cell.where(y: 0): set text(fill: white, weight: "bold", size: 8.4pt)

  // Заголовки (всегда sticky: true, чтобы не оставлять висячих заголовков)
  show heading.where(level: 1): it => {
    block(
      sticky: true,
      above: 1.15em,
      below: 0.55em,
      width: 100%,
    )[
      #text(size: 13.8pt, weight: "bold", fill: c-navy)[#it.body]
      #v(-0.5em)
      #line(length: 100%, stroke: 0.9pt + c-navy)
    ]
  }

  show heading.where(level: 2): it => {
    block(
      sticky: true,
      above: 0.95em,
      below: 0.45em,
      width: 100%,
      fill: c-ice,
      stroke: (left: 3pt + c-navy, rest: 0.35pt + c-border),
      radius: (right: 2.5pt),
      inset: (left: 8pt, right: 7pt, top: 4.5pt, bottom: 4.5pt),
    )[
      #text(size: 11pt, weight: "bold", fill: c-navy)[#it.body]
    ]
  }

  show heading.where(level: 3): it => {
    block(
      sticky: true,
      above: 0.65em,
      below: 0.3em,
      width: 100%,
    )[
      #text(size: 10.2pt, weight: "bold", fill: c-steel)[#it.body]
    ]
  }

  body
}
