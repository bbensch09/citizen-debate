# HACKY SHIT --> THIS FILE ISNT BEING USED BECAUSE IT RELIES ON SESSONS WHICH WE MANAGE WITH DEVISE
class CsrfProtection
  def incoming(message, request, callback)
    session_token = request.session['_csrf_token']
    message_token = message['ext'] && message['ext'].delete('csrfToken')

    unless session_token == message_token
      message['error'] = '401::Access denied'
    end
    callback.call(message)
  end
end
