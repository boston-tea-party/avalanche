var key_form = $("form#private-key"),
    file_form = $("form.new_upload");

function add_private_key() {
  var private_key = $("#private-key-text").val();
  localStorage.setItem("private_key", private_key);
  $(".post-message").show();
  $(".add-private-key").hide();
}

function handle_file(e) {
  var file = e.target.files[0],
      reader = new FileReader();

  reader.onload = (function (the_file) {
    console.log(the_file);
  });

  reader.readAsBinaryString(file);
  //var key = openpgp.key.readArmored(private_key);
  //openpgp.signClearMessage(key, "Burns");
}

key_form.on("submit", add_private_key);
file_form.on("change", handle_file);
