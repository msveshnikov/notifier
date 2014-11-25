OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '561935625736-ju9i1nsfdr8b65dnodfa7ufsdof88kgv.apps.googleusercontent.com',
           'x3jeqk1AlbQrkiW7-QFPJob0',
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end