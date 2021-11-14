window.onload = function(){

var loginModal = document.getElementById("loginModal");


var btnlogin = document.getElementById("login");


var span = document.getElementsByClassName("close")[0];


btnlogin.onclick = function() {
    loginModal.style.display = "block";
}


span.onclick = function() {
    loginModal.style.display = "none";
}


window.onclick = function(event) {
  if (event.target == loginModal) {
    loginModal.style.display = "none";
  }
}
}