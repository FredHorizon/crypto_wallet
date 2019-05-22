class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso RoR 5.x [COOKIE]"
    session[:curso] = "Curso RoR 5.x [SESSION]"
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
