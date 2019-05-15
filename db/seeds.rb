# Esse arquivo deve conter toda a criação de registro necessária para popular o banco de dados com seus valores padrão.
# Alguns sistemas já iniciam com algum registro populado como, por exemplo, os dados referentes ao estado e municípios.
# rails db:seed tem essa finalidade de popular o banco com dados básicos ou dados para testes.
# Os dados podem então ser carregados com o comando rails db: seed (ou criado ao lado do banco de dados com db: setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

spinner = TTY::Spinner.new("[:spinner] Cadastrando moedas...")
spinner.auto_spin

# Variável com uma coleção de dados, um array de hashes
coins = [
            {
                description: "Bitcoin",
                acronym: "BTH",
                url_image: "http://pngimg.com/uploads/bitcoin/bitcoin_PNG47.png"
            },
            {
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://banner2.kisspng.com/20180820/ryr/kisspng-ethereum-bitcoin-cryptocurrency-blockchain-logo--5b7b6e2bd92a00.5250630615348157878895.jpg"
            },
            {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://www.ultimatemoney.com.au/wp-content/uploads/2018/06/dash-coin.png"
            }
        ]

# a variável 'coins' será iterada, ou seja, o each vai percorrer cada um dos itens da coleção. Cada item é um 'coin'
coins.each do |coin|
    # método do ActiveRecord que verifica a existência de um item antes de criá-lo.
    Coin.find_or_create_by!(coin) # 'coin' é um elemento pronto, composto por 'description', 'acronym' e 'url_image'
end

spinner.success("(Moedas cadastradas com sucesso!)")