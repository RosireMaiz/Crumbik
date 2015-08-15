class OrganizacionsController < ApplicationController


  def validar_subdominio
    if Organizacion.exists?(subdominio: params[:usuario][:organizacion_attributes][:subdominio])
      render json: false
    else
      render json: true
    end
  end

end
