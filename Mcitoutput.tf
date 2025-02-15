locals{
  servicename="abracadabra"
  forum="abracadabramcit"
  lengthsa=length(local.servicename)
  lengthforum=length(local.forum)
  winterlistOfSports=["icehockey","snowboarding","iceskating"]
  total_output = ["150", "150", "150"]
  characters = ["luke", "yoda", "darth"]
  enemies_destroyed = [4252, 900, 20000056894]
character_enemy_map =   { for character in local.characters: # Convert character list to a set
      character => local.enemies_destroyed
}
}
/*output "winterlistOfSport {

value       = { for idx, name in local.winterlistOfSports : idx => "Sport Name: ${name}" }
}
output "total_output" {

   value = { for idx, name in local.total_output: idx => "total out: ${name}" }
}
output "characters" {

value =   { for idx, name in local.characters: idx => "character name: ${name}" }
}
*/
