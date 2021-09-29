resource "google_sql_database" "sqlsdb-rampup2" {
  name     = "sqlsdb-rampup2"
  instance = google_sql_database_instance.sqls-instance-rampup2.name
  charset = "utf8"
  collation = "utf8_general_ci"
  project = var.project
}
resource "google_sql_database_instance" "sqls-instance-rampup2" {
  name   = "sqls-instance-rampup2"
  database_version = "MYSQL_5_7"
  region = var.region
  settings {
    tier = "db-n1-standard-2"
  }

}