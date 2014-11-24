@test "check for wordpress install" {
  export welcome="WordPress.*[Ii]nstallation"
  wget -O - http://localhost/wp-admin/install.php | egrep "${welcome}"
}
