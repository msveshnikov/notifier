OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '803335827642-kkrjdmaqps0n139revsg01qsiipi8572.apps.googleusercontent.com',
           'R9lqNYjY5NCieSC-BCnObCoU',
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

  provider :facebook, '196393753869092', 'b0d6cb5b3910cbf7b744964773a96651',
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end