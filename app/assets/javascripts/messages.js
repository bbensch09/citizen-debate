// window.client = new Faye.Client('/faye');

// client.addExtension({
//   outgoing: function(message, callback) {
//     message.ext = message.ext || {};
//     message.ext.csrfToken = $('meta[name=csrf-token]').attr('content');
//     return callback(message);
//   }
// });

// jQuery(function() {
//   $('#new_comment').submit(function() {
//     return $(this).find("input[type='submit']").val('Sending...').prop('disabled', true);
//   });
//   try {
//     client.unsubscribe('/comments');
//   } catch (_error) {
//     if (typeof console !== "undefined" && console !== null) {
//       console.log("Can't unsubscribe.");
//     }
//   }
//   return client.subscribe('/comments', function(payload) {
//     if (payload.message) {
//       var sound_notification = new Audio('http://www.oringz.com/oringz-uploads/sounds-948-just-like-magic.mp3')
//       // var sound_notification = new Audio('assets/notification_sound.mp3')
//       sound_notification.play();
//       return $('#comments').find('.media-list').prepend(payload.message);
//     }
//   });
// });
