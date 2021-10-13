$(function () {
  window.onload = (e) => {
    window.addEventListener("message", (event) => {
      var item = event.data;
       if (item !== undefined && item.type === "custom") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification" style="border-left: 5px ' +
          item.color +
          ' solid;"><div class="notification-title"><p id="notfication-title-content"><font style="color:' +
          item.color +
          ';">' +
          item.title +
          '</font></p></div><div class="notification-message"><p id="notfication-message-content">' +
          item.message +
          "</p></div></div>";

        $(".notification").delay(3000).fadeOut("fast");
      } else if (item !== undefined && item.type === "length") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification" style="border-left: 5px ' +
          item.color +
          ' solid;"><div class="notification-title"><p id="notfication-title-content"><font style="color:' +
          item.color +
          ';">' +
          item.title +
          '</font></p></div><div class="notification-message"><p id="notfication-message-content">' +
          item.message +
          "</p></div></div>";

        $(".notification").delay(9000).fadeOut("fast");
      } else if (item !== undefined && item.type === "support") {
        document.getElementById("notifications").innerHTML +=
          '<div class="notification" style="border-left: 5px ' +
          item.color +
          ' solid;"><div class="notification-title"><p id="notfication-title-content"><font style="color:' +
          item.color +
          ';">' +
          item.title +
          '</font></p></div><div class="notification-message"><p id="notfication-message-content">' +
          item.message +
          "</p></div></div>";

        $(".notification").delay(9000).fadeOut("fast");
      }
    });
  };
});
