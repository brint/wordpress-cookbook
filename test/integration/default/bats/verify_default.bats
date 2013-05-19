@test "check for wordpress install" {
  export welcome="Welcome to the famous five minute WordPress installation process"
  wget -O - http://localhost/wp-admin/install.php | grep "${welcome}"
}
