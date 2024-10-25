# frozen_string_literal: true

# Helper de Carpool Controller
module CarpoolsHelper
  def price_de_quina(price)
    price.modulo(500).zero?
  end
end
