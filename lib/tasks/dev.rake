namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    # '%x' permite a execução de comandos de terminal diretamente da apliacação.
    # puts %x(rails db:drop db:create db:migrate db:seed)
    #if Rails.env.development?
    #  spinner = TTY::Spinner.new("[:spinner] Executando as tarefas ...", format: :pulse_2)
    #  spinner.auto_spin
    #  puts %x(rails db:create)
    #  puts %x(rails db:migrate)
    #  puts %x(rails db:seed)
    #  spinner.stop('Concluído com sucesso!')
    #else
    #  puts "Você não está em modo de desenvolvimento!"
    #end

    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Criando banco de dados...")
      spinner.auto_spin
      %x(rails db:create)
      spinner.success('(Concluído com sucesso!)')

      spinner = TTY::Spinner.new("[:spinner] Migrando banco de dados...")
      spinner.auto_spin
      %x(rails db:migrate)
      spinner.success('(Concluído com sucesso!)')

      spinner = TTY::Spinner.new("[:spinner] Populando banco de dados...")
      spinner.auto_spin
      %x(rails db:seed)
      spinner.success('(Concluído com sucesso!)')
    else
      puts "Você não está em modo de desenvolvimento!"
    end
  end
end
