locals {

Students = ["Yves", "Maryam", "Damita", "Bachir", "Braeden","Benito", "Joseph", "Arnault"]

 Teachers = ["German Torres", "Keyvan Keymanesh", "Aldo Andrade","Sami Islam"]


}

# Generate a unique list of Student-Teacher combinations
output "app_McitStudentTeacher_combos" {
  value = tolist(toset([
    for stud in local.Students : 
    [for teach in local.apps : "${stud}-${teach}"]
  ]))
}
