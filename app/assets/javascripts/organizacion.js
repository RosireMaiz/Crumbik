   $("#agregar-red-social a").click(function(){
        var source = this;
        if($("#lista-redes-sociales").hasClass("vacia"))
            $("#lista-redes-sociales").removeClass("vacia").addClass("llena");
        var class_a = $(source).attr("class"),
            class_i = $(source).children().first().attr("class"),
             id_a = $(source).attr("id");
         $("#lista-redes-sociales").append("<li><div class='input-group'><span class='input-group-addon "+
                    class_a+"'><i class='"+class_i+"'></i></span>"+
                    "<input id='usuario_perfil_attributes_"+id_a+"' name='usuario[perfil_attributes]["+id_a+"]' type='text' class='form-control'></div></li>");
    });