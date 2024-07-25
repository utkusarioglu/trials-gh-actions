fetch("http://nginx-service:80")
  .then((response) => console.log(response.text()));
