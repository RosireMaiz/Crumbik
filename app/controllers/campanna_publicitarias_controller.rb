class CampannaPublicitariasController < ApplicationController

	$ICONOS_DIFUSION = ["mdi-notification-phone-in-talk", "fa fa-comments", "mdi-communication-email", "mdi-social-share"];
	def dashboard_campanna
		if !usuario_signed_in?
        	redirect_to root_path
     	else
	        @campanna_publicitarias = CampannaPublicitarium.order('id ASC').page(params[:page]).per(9)
	        @campanna_publicitarias_ejecucion = CampannaPublicitarium.where(["? between fecha_inicio  AND fecha_fin  ", Date.today]).order('id ASC').page(params[:page]).per(9)
	        @campanna_publicitarias_proximas = CampannaPublicitarium.where([" fecha_inicio > ? ", Date.today]).order('id ASC').page(params[:page]).per(9)
	        @campanna_publicitarias_ejecutadas = CampannaPublicitarium.where([" fecha_fin < ? ", Date.today]).order('id ASC').page(params[:page]).per(9)
	        render "campanna_publicitarias/campanna_publicitarias"	
     	end
	end

	def new
		if !usuario_signed_in?
			redirect_to root_path
		else
			@campanna_publicitaria = CampannaPublicitarium.new
			render "campanna_publicitarias/new"
		end
	end

	def create
		@campanna_publicitaria = CampannaPublicitarium.new(campanna_params)
		@campanna_publicitaria.save
		redirect_to :controller => 'campanna_publicitarias', :action => 'dashboard_campanna'
	end

	def show
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria = CampannaPublicitarium.where("id = ?", id).first	
			render "campanna_publicitarias/show"
		end
	end
	
	def edit
		if !usuario_signed_in?
			redirect_to root_path
		else
			id = params[:id_campanna_publicitaria]
			@campanna_publicitaria = CampannaPublicitarium.where("id = ?", id).first	
			render "campanna_publicitarias/edit"
		end
	end

	def save_edit
		id = params[:campanna_publicitarium][:id]

		campanna_publicitaria_edit = CampannaPublicitarium.where(["id = ?", id]).first
		
		campanna_publicitaria_edit.update(campanna_edit_params)

		redirect_to :controller => 'campanna_publicitarias', :action => 'dashboard_campanna'
	end

	private
	   	def campanna_params
	    accessible = [ :titulo, :descripcion, :fecha_inicio, :fecha_fin, :producto_id, 	:campanna_publicitaria_detalles_attributes =>[[ :medio_difusion]], :criterio_campanna_pubs_attributes =>[ [ :criterio_difusion_id, :operador, :valor ] ] ] # extend with your own params
	    params.require(:campanna_publicitarium).permit(accessible)
		end
		def campanna_edit_params
	    	accessible = [ :titulo, :descripcion, :fecha_inicio, :fecha_fin, :producto_id ] # extend with your own params
	    	params.require(:campanna_publicitarium).permit(accessible)
		end
end
