// const icons
#let icon_size = 0.8em
#let orcid_icon = box(height: icon_size, image("icons/orcid.svg"))
#let github_icon = box(height: icon_size, image("icons/github.svg"))
#let phone_icon = box(height: icon_size, image("icons/phone.svg"))
#let email_icon = box(height: icon_size, image("icons/email.svg"))
#let web_icon = box(height: icon_size, image("icons/web.svg"))

#let github_link = "https://github.com/"
#let orcid_link = "https://orcid.org/"

#let icon_link(icon, web, account_name) = {
  align(horizon)[
    #icon
    #link(web + account_name, account_name)
  ]
}

//Resume layout

#let left_column_width = 16%
#let column_gutter = 1.2em

#let resume(
  title: "",
  author: (:), 
  date: datetime.today().display("[month repr:long] [day], [year]"), 
  theme: (:),
  body
) = {
  set text(
    font: theme.font,
    lang: "en",
    size: 11pt,
    fallback: true
  )
  // Set up theme color
  let primary_color = {
    if (theme.color == "") {rgb("#4B0082")}
    if (theme.color == "blue") { rgb("#0D8FCD") }
    if (theme.color == "orange") { rgb("#CC5500") }
  }
  
  let accent_color = {
    if (theme.color == "") {rgb("#228B22")}
    if (theme.color == "blue") { rgb("#333333") } 
    if (theme.color == "orange") { rgb("#422921") } 
  }
  
  set document(
    author: author.firstname + " " + author.lastname, 
    title: title,
  )

  // Set page style 
  set page(
    paper: "us-letter",
    margin: (left: 0.8in, right: 0.8in, top: 0.6in, bottom: 0.6in),
    footer: [
      #set text(fill: accent_color, size: 8pt)
      #grid(
        columns: (1fr,)*3,
        align: (left, center, right),
        smallcaps[#date],
        counter(page).display("1 / 1"),
        smallcaps[
              #author.firstname
              #author.lastname
              #sym.dot.c
              #title
            ],
        )
    ],
  )
  
  // Set paragraph spacing
  
  show par: set block(above: 0.8em, below: 1em)
  set par(justify: true)

  // Set heading styles
  
  set heading(
    numbering: none,
    outlined: false,
  )

  show heading.where(level:1): it => {
    set text(
      size: 1.2em,
      weight: "semibold"
    )
    grid(
      columns: (left_column_width, 1fr),
      column-gutter: 1.2em,
      align(horizon, line(stroke: 5pt + primary_color, length: 100%)),
      pad(left: -0.5em, text(fill: primary_color, it.body))
    )
  }

  show heading.where(level: 2): it => {
    set text(primary_color, size: 1.1em, style: "italic", weight: "regular")
    grid(
      columns: (left_column_width, 1fr),
      align: (right, left),
      column-gutter: 1.2em,
      row-gutter: 0.5em,
      [],
      pad(left: -0.25em, it.body)
    )
  }

  show heading.where(level: 3): it => {
    set text(size: 10pt, weight: "regular")
    smallcaps[#it.body]
  }

  // Set name style
  
  let name = {
    set text(
      size: 2.5em, 
      weight: "bold", 
      fill: primary_color
    )
    pad(bottom: 0.5em)[
      #author.firstname
      #h(0.2em)
      #author.lastname
    ]
  }

  // Set position style
  
  let positions = {
    set text(
      accent_color,
      size: 0.8em,
      weight: "regular"
    )
    smallcaps(
      author.positions.join(
        text[#"  "#sym.dot.c#"  "]
      )
    )
  }

  // Set address style
  let address = {
    set text(
      size: 0.8em,
      weight: "bold",
      style: "italic",
    )
    align(right, author.address)
  }

  // Set contact information styles
  
  let contactinfo = {
    align(right)[
      #set text(size: 0.8em, weight: "regular", style: "normal")
      #align(horizon)[
        #if (author.phone != "") {
          phone_icon
          box(inset: (left: 6pt),  
            author.phone
          )
        }
        
        #if (author.email != "") {
          email_icon
          box(inset: (left: 6pt), link("mailto:" + author.email)[#author.email])
        }
      ]
    ]
  }
  
  let socialinfo = {
      set text(size: 0.9em, weight: "regular", style: "normal")
      grid(
          columns: (1fr,) + (auto,)*3,
          column-gutter: 1.5em,
          align: (left, right, right, right),
          [],
          if (author.web != "") {
            icon_link(web_icon, "", author.web)
          },
          if (author.orcid != "") {
            icon_link(orcid_icon, orcid_link, author.orcid)
          },
          if (author.github != "") {
            icon_link(github_icon, github_link, author.github)
          }
    )
  } 
  grid(
   columns: (1fr,1fr),
   align: (left, right), 
   {name; positions;},
   {address; contactinfo},
  )
  socialinfo
  body
}

// Resume-list: marker will be placed on the left

#let resume_list(body) = {
  set text(size: 1em, weight: 400)
  set par(leading: 0.8em)
  set enum(numbering: n => {
      box(width: left_column_width, align(right)[#n.])
    },
    body-indent: 1.2em
  )
  show list.item: it => {
    grid(
      columns: (left_column_width, 1fr),
      align: (right, left),
      column-gutter: 1.2em,
      row-gutter: 0.5em,
      $bullet$,
      it.body
    )
  }
  body
}

// Resume entry. Displayed as  date title university\ [] location description
#let resume_content(body) = {
  grid(
      columns: (left_column_width, auto, 1fr),
      align: (right, left, right),
      column-gutter: 1.2em,
      row-gutter: 0.5em,
      [],
      body
    )
}

#let resume_entry(
  date: "",
  title: "",
  department: "",
  university: "",
  location: "", 
  description: ""
) = {
  grid(
      columns: (left_column_width, auto, 1fr),
      align: (right, left, right),
      column-gutter: 1.2em,
      row-gutter: 0.65em,
      grid.cell(
        rowspan: 2,
        date,
      ),
      strong(title),
      department,
      emph(university),
      location,
      [],
      description
    )
}

// Reverse the numbering of enum items. It was shared by frozolotl. A reimplement of enum can be found in https://gist.github.com/frozolotl/1eeafa5ff4a38b2aab412743bd9c1ded. It may be used to realize the same feature.

#let reverse(it) = {
  let len = it.children.filter(child => child.func() == enum.item).len()
  set enum(numbering: n => box(width: left_column_width,        align(right)[#(1 + len - n).])
  ) 
  it
}

// ---- End of Resume Template ----
