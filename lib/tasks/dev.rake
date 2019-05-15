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
      show_spinner("Criando BD...") do # somente o primeiro argumento do método foi chamado
        %x(rails db:create)
      end

      show_spinner("Migrando BD...") { %x(rails db:migrate) } # quando a estrutura tem apenas uma linha, não precisa de 'do ... end'
      
      show_spinner("Populando BD...") do
        %x(rails db:seed)
      end
    else
      puts "Você não está em modo de desenvolvimento!"
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Conluído com sucesso!") # parâmetros de mensagem de início e final. A de final será por padrão 'Concluído com sucesso', caso não seja setada
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield # executará o trecho de código '%x(rails db:...)'
    spinner.success("(#{msg_end})")
  end

end
