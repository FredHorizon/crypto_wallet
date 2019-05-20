module ApplicationHelper
    
    def locale(locale)
        # if I18n.locale == :en
        #     "English USA"
        # else
        #     "Português Brasil"
        # end

        # if 'ternário' para sentenças simples:
        I18n.locale == :en ? "English USA" : "Português Brasil"
    end

    # Necessita da gem 'rails-i18n'
    def data_br(data_us)
        data_us.strftime("%d/%m/%Y")
    end

    def ambiente_rails
        if Rails.env.development?
            "Desenvolvimento"
        elsif Rails.env.production?
            "Produção"
        else
            "Teste"
        end
    end
end
