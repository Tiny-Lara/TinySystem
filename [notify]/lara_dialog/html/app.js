setTimeout(function(){ $("#box").hide(); }, 500);
$.post("http://lara_dialog/lara_dialog:callback");


window.onload = function(e) {
  window.addEventListener('message', function(event) {
    let data = event.data
    $("#box").show();
        document.getElementById("title").textContent = data.title;
        document.getElementById("description").textContent = data.message;
  })
}

$("#okbtn").click(function () {
  $("#box").hide();
  $.post("http://lara_dialog/lara_dialog:callback");
  
});


$("#cancelbtn").click(function () {
  $("#box").hide();
  $.post("http://lara_dialog/lara_dialog:delcode");
});