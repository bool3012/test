locals {
  # Convert to UC
  env = upper(var.tags_as_map["Environment"])

  env_short = substr(local.env, 0, min(3, length(local.env)))
  prefix = upper(
    format("%s-%s", var.tags_as_map["ApplicationName"], local.env_short),
  )
  name = upper(var.name)

  #not supported in tf 0.12, fixed with dynamic tags and foreach
  # Convert tags var (defined as map) to the format used in the ASG
  # tags_asg_format = [null_resource.tags_as_list_of_maps[0].triggers]
}

# This dumb resource is needed to convert the tags variable
# into a list of maps (the format used in Autoscaling Groups).
# resource "null_resource" "tags_as_list_of_maps" {
#   count = var.create ? length(keys(var.tags_as_map)) : 0 # if module not created it's not needed

#   triggers = {
#     "key"                 = element(keys(var.tags_as_map), count.index)
#     "value"               = element(values(var.tags_as_map), count.index)
#     "propagate_at_launch" = "true"
#   }
# }


