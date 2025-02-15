output "winterlistOfSport_name" {
value   ={ for idx, name in local.winterlistOfSport : idx => "winterlistOfSport wint: ${name}" }
}
output "total_output_name" {
   value = { for idx, name in local.total_output: idx => "total_output out: ${name}" }
}
output "characters_name" {
value =   { for idx, name in local.characters: characters => "character char: ${name}"}
}
