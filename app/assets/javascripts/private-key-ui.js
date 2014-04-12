if (localStorage.getItem("private_key") === null) {
  $(".private-key-status").show();
  $(".post-message").hide();
}
else {
  $(".private-key-success").show();
  $(".private-key-status").hide();
}
