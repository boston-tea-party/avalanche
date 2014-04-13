/*global $, localStorage, FileReader, document, openpgp, Uint16Array */
var keys_form = $("form#keys"),
    file_form = $("form.new_upload"),
    armored_private_key = localStorage.getItem("armored_private_key"),
    armored_public_key = localStorage.getItem("armored_public_key");

function add_armored_private_public_key() {
  var armored_private_key = $("#private-key-text").val();
  localStorage.setItem("armored_private_key", armored_private_key);
  var armored_public_key = $("#public-key-text").val();
  localStorage.setItem("armored_public_key", armored_public_key);
  $(".post-message").show();
  $(".add-private-key").hide();
}

function handle_file(e) {
  var file = e.target.files[0],
      reader = new FileReader();

  reader.onloadend = function(e) {
    if (e.target.readyState == FileReader.DONE) {
        var str = e.target.result,
            private_keys = openpgp.key.readArmored(armored_private_key),
            private_key = private_keys.keys[0],
            public_keys = openpgp.key.readArmored(armored_private_key),
            public_key = public_keys.keys[0],
            signed_file,
            clear_msg,
            signature;
        console.log(private_keys);
        console.log(private_key);
        private_key.decrypt();
        signed_file = openpgp.signClearMessage([private_key], str);
        console.log(signed_file);
        clear_msg = openpgp.cleartext.readArmored(signed_file);
        console.log(clear_msg);
        signature = openpgp.verifyClearSignedMessage([public_key], clear_msg);
        console.log(signature);
        $("form.new_upload #signed_file").val(signature);
        $("form.new_upload #public_key").val(armored_public_key);
    }
  };

  reader.readAsText(file, "ascii");
}

keys_form.on("submit", add_armored_private_public_key);
file_form.on("change", handle_file);
