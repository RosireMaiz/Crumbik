class CampannaPublicitarium < ActiveRecord::Base
	belongs_to :producto, class_name: "Producto"
	
	has_many :campanna_publicitaria_detalles, class_name: "CampannaPublicitariaDetalle", foreign_key: "campanna_publicitaria_id"
	
	has_many :criterio_campanna_pubs, class_name: "CriterioCampannaPub", foreign_key: "campanna_publicitaria_id"
  	has_many :criterio_difusion, :through => :criterio_campanna_pubs, foreign_key: "campanna_publicitaria_id"

  	accepts_nested_attributes_for :campanna_publicitaria_detalles
  	accepts_nested_attributes_for :criterio_campanna_pubs
  	
  	def cantidad_difusion
  		cantidad = 0
  		self.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
  			cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_detalle
  		end
  		cantidad
  	end

    def cantidad_difusion_general
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?",date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
            campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
              cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_detalle
            end
        end
        difusion.push(cantidad)
      end
      difusion  
    end
  	
    def cantidad_difusion_producto(id_producto)
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("producto_id =? AND extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", id_producto, date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          self.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_detalle
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_sms
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["sms"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_llamada
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["llamada"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_email
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["email"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_red_social
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion] == CampannaPublicitariaDetalle.medio_difusions["red_social"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end


    def count_sms_producto(id_producto)
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("producto_id = ? AND extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", id_producto, date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["sms"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_llamada_producto(id_producto)
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("producto_id = ? AND extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", id_producto, date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["llamada"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_email_producto(id_producto)
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("producto_id = ? AND extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", id_producto, date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["email"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_red_social_producto(id_producto)
      difusion ||= Array.new
      date = Date.today.strftime("%Y")
      (1..12).each do |i|
        campannas_publicitaria = CampannaPublicitarium.where("producto_id = ? AND extract(year  from fecha_inicio) = ? AND extract(month from fecha_inicio) = ?", id_producto, date, i)
        cantidad = 0
        campannas_publicitaria.each do |campanna_publicitaria|
          campanna_publicitaria.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion] == CampannaPublicitariaDetalle.medio_difusions["red_social"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_sms_unique
      difusion ||= Array.new

      date_range = self.fecha_inicio..fecha_fin

      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
      months = date_months.map {|d| d.strftime "%m" }

      months.each do |i|
        cantidad = 0
          self.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["sms"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_llamada_unique
      difusion ||= Array.new
      date_range = self.fecha_inicio..fecha_fin

      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
      months = date_months.map {|d| d.strftime "%m" }

      months.each do |i|
      cantidad = 0
          self.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["llamada"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_email_unique
      difusion ||= Array.new
      date_range = self.fecha_inicio..fecha_fin

      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
      months = date_months.map {|d| d.strftime "%m" }

      months.each do |i|
        cantidad = 0
          self.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion]  == CampannaPublicitariaDetalle.medio_difusions["email"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        difusion.push(cantidad)
      end
      difusion  
    end

    def count_red_social_unique
      difusion ||= Array.new
      date_range = self.fecha_inicio..fecha_fin

      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
      months = date_months.map {|d| d.strftime "%m" }

      months.each do |i|
        cantidad = 0
          self.campanna_publicitaria_detalles.each do |campanna_publicitaria_detalle|
            if CampannaPublicitariaDetalle.medio_difusions[campanna_publicitaria_detalle.medio_difusion] == CampannaPublicitariaDetalle.medio_difusions["red_social"]
               cantidad = cantidad + campanna_publicitaria_detalle.cantidad_difusion_usuario
            end
          end
        difusion.push(cantidad)
      end
      difusion  
    end



 end
