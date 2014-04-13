if (localStorage.getItem("armored_private_key") === null || localStorage.getItem("armored_public_key") === null) {
  $(".private-key-status").show();
  $(".post-message").hide();
}
else {
  $(".keys-success").show();
  $(".private-key-status").hide();
}
