var form = $("form#private-key");

function add_private_key() {
  var private_key = $("#private-key-text").val();
  localStorage.setItem("private_key", private_key);
}

form.on("submit", add_private_key);

