fetch("http://nginx-service:80")
  .then((response) => response.text())
  .then(console.log)
