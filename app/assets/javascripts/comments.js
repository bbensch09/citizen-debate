window.client = new Faye.Client('/faye');

client.addExtension({
  outgoing: function(message, callback) {
    message.ext = message.ext || {};
    message.ext.csrfToken = $('meta[name=csrf-token]').attr('content');
    return callback(message);
  }
});

jQuery(function() {
  $('#new_comment').submit(function() {
    return $(this).find("input[type='submit']").val('Sending...').prop('disabled', true);
    console.log("line 14 -- sending new comment.");
  });
  try {
    client.unsubscribe('/comments');
  } catch (_error) {
    if (typeof console !== "undefined" && console !== null) {
      console.log("Can't unsubscribe.");
    }
  }


// Detect and log to console when text box is clicked into
console.log("listening for form to be selected");
document.getElementById('message-text-area').onclick = function() {userTyping() };
function userTyping() {
  console.log("Opponent is typing...");
}


  return client.subscribe('/comments', function(payload) {
    if (payload.message) {
      var sound_notification = new Audio('https://s3-us-west-2.amazonaws.com/citizen-debate/gets-in-the-way.mp3')
      sound_notification.play();
      // console.log("The payload is: "+payload.message)
      return $('#comments').find('.media-list').prepend(payload.message);
    };

    // If typing status is published display it here.
    if (payload){
      return $('#opponent-status').find('.current-status').innerHTML = payload.status;
    }

  });
});
