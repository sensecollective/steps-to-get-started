(deftheme goldenrod
  "Created 2013-12-28.")

(custom-theme-set-variables
 'goldenrod
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))

(provide-theme 'goldenrod)
