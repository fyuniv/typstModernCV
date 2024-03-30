#import "lib.typ": *

#show: resume.with(
  title: "Curriculum Vitae",
  author: (
      firstname: "John", 
      lastname: "Doe",
      email: "john.doe@gmail.com", 
      address: [Dept. of Math\ home number, street name,\ city, zipcode],
      positions: (
        "Mathematician",
      ),
      phone: "(000) 123 4567",
      github: "abcd",
      orcid: "0000-0000-0000-0000",
      web: "https://..."
  ),
  date: datetime.today().display(),
  theme: (
    color: "orange",
    font: "Inter"
  )
)

// #set text(font: "Comic Neue")
#show link: set text(fill: blue)

= Education

#resume_entry(
  date: "August 2019 - May 2024",
  title: "Ph.D. in Mathematics",
  university: "University of ABC",
  location: "City A, USA",
  description: "Advisor: Prof. "
)

= Experience

#resume_entry(
  title: "Teaching Assistance",
  university: "University of ABC",
  date: "2019 - Present",
  department: "Dept. of Math.",
  location: "City A, USA",
  description: "Teach math courses..."
)

= Research Interests

#resume_content[
All fields of Mathematics 
]

= Papers

#resume_list[
  
+ #lorem(15)

+ #lorem(20)

]

= Talks


#resume_list[
  #reverse[
    + #lorem(15)
    
    + #lorem(20)
  ]
]

= Grant Awards

#resume_list[
- #lorem(5)
]

= Teaching

== Certificates

#resume_list[
- #lorem(6)
]
