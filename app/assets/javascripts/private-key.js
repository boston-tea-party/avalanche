/*global $, localStorage, FileReader, document, openpgp, Uint16Array */
var private_key_form = $("form#private-key"),
    public_key_form = $("form#public-key"),
    file_form = $("form.new_upload"),
    armored_private_key = localStorage.getItem("armored_private_key"),
    armored_public_key = localStorage.getItem("armored_public_key");

function add_armored_private_key() {
  var armored_private_key = $("#private-key-text").val();
  localStorage.setItem("armored_private_key", armored_private_key);
}

function add_armored_public_key() {
  var armored_public_key = $("#public-key-text").val();
  localStorage.setItem("armored_public_key", armored_public_key);
}

function handle_file(e) {
  var file = e.target.files[0],
      reader = new FileReader();

  reader.onloadend = function(e) {
    if (e.target.readyState == FileReader.DONE) {
        var str = e.target.result,
            private_keys = openpgp.key.readArmored(armored_private_key),
            private_key = private_keys.keys[0],
            clear_msg;
        console.log(private_keys);
        console.log(private_key);
        private_key.decrypt();
        clear_msg = openpgp.signClearMessage([private_key], str);
        $("form.new_upload #signed_file").val(clear_msg);
        $("form.new_upload #public_key").val(armored_public_key);
    }
  };

  reader.readAsText(file, "ascii");
}

private_key_form.on("submit", add_armored_private_key);
public_key_form.on("submit", add_armored_public_key);
file_form.on("change", handle_file);
