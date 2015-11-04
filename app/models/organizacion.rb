class Organizacion < ActiveRecord::Base

	after_create do
		Apartment::Tenant.create(self.subdominio)
	end
	
	RESTRICTED_SUBDOMAINS = %w{www}

	validates :subdominio, presence: true,
						uniqueness: { case_sensitive: false },
						#format: { with: /\A[w\-]+\Z/i, message: 'Contiene caracteres no validos' },
						exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'Restringido'}						
	before_validation :convertir_subdominio

	private
		def convertir_subdominio
			self.subdominio = subdominio.try(:downcase)
		end

	belongs_to :usuario, class_name: "Usuario", foreign_key: "usuario_id", :inverse_of=>:organizacion
	belongs_to :pais, class_name: "Pais", foreign_key: "pais_id", :inverse_of=>:organizacion
	has_many :organizacion_red_social, class_name: "OrganizacionRedSocial"
	has_many :contratos, class_name: "Contrato"
  	has_many :red_social, :through => :organizacion_red_social

  	accepts_nested_attributes_for :contratos
end
