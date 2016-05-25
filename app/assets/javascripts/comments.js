window.client = new Faye.Client('/faye');
$local_status = "You are waiting for a reply.";
console.log("Local status is set. User is awaiting a reply.");


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
if (document.getElementById('message-text-area') ) {
document.getElementById('message-text-area').focusin = function() {userTyping() };
document.getElementById('message-text-area').focusout = function() {awaitingReply() };
document.getElementsByClassName('btn-cross-ex')[0].focusin = function() {userTyping() };
document.getElementsByClassName('btn-cross-ex')[0].focusout = function() {awaitingReply() };
}

function userTyping() {
  status_publisher = client.publish('/comments', {
  status: 'Your opponent is typing...'
  });
  $local_status = 'You are typing...';
  $('.current-status').html($local_status);
  status_publisher.callback(function() {
  console.log("user has begun typing");
});
  status_publisher.errback(function() {
    alert('There was an error while posting your comment.');
});
}

function awaitingReply() {
  status_publisher = client.publish('/comments', {
  status: 'Awaiting a reply...'
  });
  $local_status = "You are waiting for a reply.";
  status_publisher.callback(function() {
  console.log("user has stopped typing");
});
  status_publisher.errback(function() {
    alert('There was an error while posting your comment.');
});
}


  return client.subscribe('/comments', function(payload) {
    if (payload.message) {
      var sound_notification = new Audio('https://s3-us-west-2.amazonaws.com/citizen-debate/gets-in-the-way.mp3')
      sound_notification.play();
      // console.log("The payload is: "+payload.message)
      return $('#comments').find('.media-list').append(payload.message);
    };

    // If typing status is published display it here.
    if (payload.status && $local_status == "You are waiting for a reply." ){
      return $('.current-status').html(payload.status);
    }

  });
});
