
$(document).ready(function(){
 
  	$("#btn-chat").click(function(){
       var d = new Date();
       var m = d.getMonth() + 1;
       var mes = (m < 10) ? '0' + m : m;
       var dato = $("#btn-input").val();
       var fec =d.getFullYear()+'-'+mes+'-'+d.getDate()+' '+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds();
      
       
	    if($("#btn-input").val()!=""){

	    	 	    var request = $.ajax({
                            url: '/usuario/usuario_actual',
                            method: "POST",
                            dataType: "JSON",
                            success: function( data ) {
                            			var username = data.username;
                            			var foto = data.formato_foto + data.foto;
                                        $(".chat").append("<li class='right clearfix'><span class='chat-img pull-right'><img src='" + foto + "' alt='User Avatar' class='img-circle img-chat'/></span><small class=' text-muted'><span class='fa fa-clock-o'></span>"+fec+"</small><strong class='pull-right primary-font'>"+username+" </strong><br><p>"+dato+"</p></li>");
	       								                $("#btn-input").val("");
                                      },

                          });
                     
        request.fail(function( jqXHR, textStatus ) {
                                                    alert( "Request failed: " + textStatus );
                                                   });

	        
	    }
  	});

	$("#addClass").click(function () {
	    $('#chat').addClass('popup-box-on');
	});
	          
	$("#removeClass").click(function () {
	   $('#chat').removeClass('popup-box-on');
	});

});

$(document).on('click', '.panel-heading span.icon_minim', function (e) {
    var $this = $(this);
    if (!$this.hasClass('panel-collapsed')) {
        $this.parents('.panel').find('.panel-body').slideUp();
        $this.parents('.panel').find('.panel-footer').slideUp();
        $this.addClass('panel-collapsed');
        $this.removeClass('fa-minus').addClass('fa-plus');
    } else {
        $this.parents('.panel').find('.panel-body').slideDown();
        $this.parents('.panel').find('.panel-footer').slideDown();
        $this.removeClass('panel-collapsed');
        $this.removeClass('fa-plus').addClass('fa-minus');
    }
});
  
$(document).keypress(function(event) {
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if(keycode == '13') {
        $("#btn-chat").click();
    }
});