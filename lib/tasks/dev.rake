namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    # '%x' permite a execução de comandos de terminal diretamente da apliacação.
    # puts %x(rails db:drop db:create db:migrate db:seed)
    puts %x(rails db:create)
    puts %x(rails db:migrate)
    puts %x(rails db:seed)
  end

end
