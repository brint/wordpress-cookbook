@test "check for wordpress install on port 80" {
  run bash -c "wget -O - http://localhost:8080 | grep 'WordPress'"
}

@test "check for wordpress install on port 443" {
  run bash -c "wget --no-check-certificate -O - http://localhost:8443 | grep 'Houston'"
}
