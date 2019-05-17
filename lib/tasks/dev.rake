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
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) } # quando a estrutura tem apenas uma linha, não precisa de 'do ... end'
      %x(rails dev:add_mining_types) # Não pode haver coins sem tipos de mineração. por isso 'mining_types' vem por primeiro
      %x(rails dev:add_coins)
    else
      puts "Você não está em modo de desenvolvimento!"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    
    show_spinner("Cadastrando moedas...") do
      # Variável com uma coleção de dados, um array de hashes
      coins = [
                  {
                      description: "Bitcoin",
                      acronym: "BTH",
                      url_image: "http://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png",
                      mining_type: MiningType.find_by(acronym: 'PoW') # Força a inserção de um tipo de mineração específica: Proof of Work
                      # mining_type: MiningType.where(acronym: 'PoW').first # força a busca também, mas where busca um ou mais elementos, enquanto que find_by busca apenas um.
                  },
                  {
                      description: "Ethereum",
                      acronym: "ETH",
                      url_image: "https://banner2.kisspng.com/20180820/ryr/kisspng-ethereum-bitcoin-cryptocurrency-blockchain-logo--5b7b6e2bd92a00.5250630615348157878895.jpg",
                      mining_type: MiningType.all.sample # insere um tipo de mineração ao campo mining_type por meio do método 'sample'
                  },
                  {
                      description: "Dash",
                      acronym: "DASH",
                      url_image: "https://www.ultimatemoney.com.au/wp-content/uploads/2018/06/dash-coin.png",
                      mining_type: MiningType.all.sample
                  },
                  {
                    description: "Iota",
                    acronym: "IOT",
                    url_image: "https://cdn4.iconfinder.com/data/icons/iota-bitcoin-crytocurrency/128/bitcoin_Cryptocurrency_Iota_2_coin-512.png",
                    mining_type: MiningType.all.sample
                  },
                  {
                    description: "ZCash",
                    acronym: "ZEC",
                    url_image: "https://cdn2.iconfinder.com/data/icons/cryptocurrency-5/100/cryptocurrency_blockchain_crypto-16-512.png",
                    mining_type: MiningType.all.sample
                }
              ]
      
      # a variável 'coins' será iterada, ou seja, o each vai percorrer cada um dos itens da coleção. Cada item é um 'coin'
      coins.each do |coin|
        # método do ActiveRecord que verifica a existência de um item antes de criá-lo.
        Coin.find_or_create_by!(coin) # 'coin' é um elemento pronto, composto por 'description', 'acronym' e 'url_image'
      end
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
      ]

      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
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
