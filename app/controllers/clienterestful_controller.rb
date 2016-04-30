
class ClienterestfulController < ApplicationController
   def index   
      end
  
  def verificarTarjetaSaldo
           require 'curl'
           curl = CURL.new 
           $numerotarjeta =params[:tarjeta]
           $codigotarjeta =params[:seguridad]
           $montoplan =params[:montoplan].to_i
           $fechatarjeta =params[:fechaexp]

           
         contenido = curl.get("http://192.168.42.206:81/html/servidor-banco/Despachador.php?servicio=1&tarjeta=#{$numerotarjeta}&seguridad=#{$codigotarjeta}&fechavenc=#{$fechatarjeta}")
          @respuesta = Hash.new
           j=ActiveSupport::JSON
           #convertir como arreglo si hubo exito, j.decode(contenido).to_a[0] trae ["exito", "1"]
           exito = j.decode(contenido).to_a[0] # exito
           if exito.to_a[1].to_s=="1"
              #convertir como arreglo a tarjeta j.decode(contenido).to_a[1] trae ["tarjeta", ""]
              tarjeta = j.decode(contenido).to_a[1] # Usuario

            #convertir como arreglo a seguridad j.decode(contenido).to_a[2] trae ["seguridad", ""]
              seguridad = j.decode(contenido).to_a[2] # Clave

            #convertir como arreglo a monto j.decode(contenido).to_a[2] trae ["monto", ""]
              monto = j.decode(contenido).to_a[4] # Clave

              fecha = j.decode(contenido).to_a[3]

                  if(monto.to_a[1].to_i<$montoplan.to_i)
                    @respuesta["codigo"] = 500
                    @respuesta["respuesta"] = "El saldo de su tarjeta no es suficiente para el pago del plan"
                    @tirajson = '{ "success": "true", "codigo": "500", "exito": "false", "msg":  }'
                  else
                    @respuesta["codigo"] = 200
                    @respuesta["respuesta"] = "Los datos ingresados son correctos"
                    @tirajson = '{ "success": "true", "codigo": "200",  "exito": "true", "msg": "Los datos ingresados son correctos"}'
                   end
            #  @saludo = "El tarjeta es: "+tarjeta.to_a[1].to_s+", la seguridad es: "+seguridad.to_a[1].to_s+", el monto es: "+monto.to_a[1].to_s
           else
              @respuesta["codigo"] = 400
              @respuesta["respuesta"] = "Verifique los datos de la tarjeta."
             @tirajson = '{ "success": "true", "codigo": "400",  "exito": "false", "msg": "Verifique los datos de la tarjeta." }'
           end
           #render :text => @tirajson
           render json: @respuesta
  end
end
