require 'curl'
class ClienterestfulController < ApplicationController
   def index   
      end
  
  def verificarTarjetaSaldo

           curl = CURL.new 
           $numerotarjeta =params[:tarjeta]
           $codigotarjeta =params[:seguridad]
           $montoplan =params[:montoplan]
           $fechatarjeta =params[:fechaexp]

           
         contenido = curl.get("http://172.19.25.29:81/html/servidor-banco/Despachador.php?servicio=1&tarjeta=#{$numerotarjeta}&seguridad=#{$codigotarjeta}&fechavenc=#{$fechatarjeta}")

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
                     @tirajson = '{ "success": "true", "exito": "false", "msg": "El saldo de su tarjeta no es suficiente para el pago del plan" }'
                  else
                    @tirajson = '{ "success": "true", "exito": "true", "msg": "Los datos ingresados son correctos"}'
                   end
            #  @saludo = "El tarjeta es: "+tarjeta.to_a[1].to_s+", la seguridad es: "+seguridad.to_a[1].to_s+", el monto es: "+monto.to_a[1].to_s
           else
             @tirajson = '{ "success": "true", "exito": "false", "msg": "Verifique los datos de la tarjeta." }'
           end
           render :text => @tirajson
  end
end
