resource "google_sql_database" "sqldb-rampup2" {
  name     = "sqldb-rampup2"
  instance = google_sql_database_instance.sql-instance-rampup2.name
  charset = "utf8"
  collation = "utf8_general_ci"
  project = var.project
}
resource "google_sql_database_instance" "sql-instance-rampup2" {
  name   = "sql-instance-rampup2"
  database_version = "MYSQL_5_7"
  region = var.region
  settings {
    tier = "db-e2-small"
  }

}