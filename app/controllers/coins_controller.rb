class CoinsController < ApplicationController
  layout "adm" # especifica qual layout usar. Se não for especificado, o controller usará o padrão, ou seja, 'application.html.erb'

  # Antes de uma ação, set_coin(configure uma moeda) somente(only) em show, edit, update e destroy
  before_action :set_coin, only: [:show, :edit, :update, :destroy]

  # GET /coins
  # GET /coins.json
  def index
    @coins = Coin.all # variável de instância que recebe todos os elementos do model Coin (da tabela coins)
  end

  # GET /coins/1
  # GET /coins/1.json
  def show
    # a ação do show é feita pelo before_action com o método set_coin. Por isso não há necessidade de configurar nada aqui
  end

  # GET /coins/new
  def new
    @coin = Coin.new # Essa ação instancia um objeto vazio, mas com os atributos para serem preenchidos. Ou seja, disponibliza a tabela com os campos especificados, mas vazios, para o formulário da aplicação
  end

  # GET /coins/1/edit
  def edit
  end

  # POST /coins
  # POST /coins.json
  def create
    @coin = Coin.new(coin_params)

    respond_to do |format|
      if @coin.save
        format.html { redirect_to @coin, notice: 'Coin was successfully created.' }
        format.json { render :show, status: :created, location: @coin }
      else
        format.html { render :new }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coins/1
  # PATCH/PUT /coins/1.json
  def update
    respond_to do |format|
      if @coin.update(coin_params)
        format.html { redirect_to @coin, notice: 'Coin was successfully updated.' }
        format.json { render :show, status: :ok, location: @coin }
      else
        format.html { render :edit }
        format.json { render json: @coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coins/1
  # DELETE /coins/1.json
  def destroy
    @coin.destroy # '@coin' variável configurada no método set_coin
    respond_to do |format|
      format.html { redirect_to coins_url, notice: 'Coin was successfully destroyed.' } # Após excluir redireciona para index e exibe a mensagem de que foi apagado com sucesso.
      format.json { head :no_content }
    end
  end

  private
    # Pegar a moeda coin e encontrá-la a partir do parâmetro id
    def set_coin
      @coin = Coin.find(params[:id]) # find retorna um único elemento, e não um array de elementos.
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coin_params
      params.require(:coin).permit(:description, :acronym, :url_image)
    end
end
