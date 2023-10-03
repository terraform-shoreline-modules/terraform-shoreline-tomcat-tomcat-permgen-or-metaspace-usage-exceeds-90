resource "shoreline_notebook" "tomcat_permgen_or_metaspace_usage_exceeds_90" {
  name       = "tomcat_permgen_or_metaspace_usage_exceeds_90"
  data       = file("${path.module}/data/tomcat_permgen_or_metaspace_usage_exceeds_90.json")
  depends_on = [shoreline_action.invoke_increase_tomcat_config_size]
}

resource "shoreline_file" "increase_tomcat_config_size" {
  name             = "increase_tomcat_config_size"
  input_file       = "${path.module}/data/increase_tomcat_config_size.sh"
  md5              = filemd5("${path.module}/data/increase_tomcat_config_size.sh")
  description      = "Increase the PermGen or Metaspace size in the Tomcat configuration file to accommodate the application's memory usage."
  destination_path = "/agent/scripts/increase_tomcat_config_size.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_increase_tomcat_config_size" {
  name        = "invoke_increase_tomcat_config_size"
  description = "Increase the PermGen or Metaspace size in the Tomcat configuration file to accommodate the application's memory usage."
  command     = "`chmod +x /agent/scripts/increase_tomcat_config_size.sh && /agent/scripts/increase_tomcat_config_size.sh`"
  params      = ["PATH_TO_TOMCAT_CONFIG_FILE","NEW_SIZE","OLD_SIZE"]
  file_deps   = ["increase_tomcat_config_size"]
  enabled     = true
  depends_on  = [shoreline_file.increase_tomcat_config_size]
}

