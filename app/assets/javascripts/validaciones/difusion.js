$(document).ready(function(){

    $('#usuarios').dataTable({
      "select": false, 
      "pageLength": 10,
      "lengthChange": false,
      "language": {
              "zeroRecords": "No hay datos disponibles en la tabla",
      }
    });

    $(".call").on("click", function() {
      $(".audio-play")[0].currentTime = 0;
      return $(".audio-play")[0].play();
    });

    $(".end-call-botton").on("click", function() {
      return $(".audio-play")[0].pause();
    });
     $(".end-call").on("click", function() {
      return $(".audio-play")[0].pause();
    });

    tinymce.init({
      language: ['es'],
        selector: 'textarea#edit-email',
        height: 250,
        langs: ['es'],
        plugins: [    'advlist autolink lists link image charmap print preview hr anchor pagebreak',
    'searchreplace wordcount visualblocks visualchars code fullscreen',
    'insertdatetime media nonbreaking save table contextmenu directionality',
    'emoticons template paste textcolor colorpicker textpattern imagetools'
        ],
        toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image ',
        toolbar2: 'print preview media | forecolor backcolor emoticons',
    });

    $(function() {
      $( "#accordion" ).accordion({
              heightStyle: "content"
      });
    });


});

function remove_social(index,id){
  social_remove_ids.push(id);
  id = "#social_"+index;
  $(id).remove();
}

function remove_usuario_sms(index,id){
  usuarios_mensaje_remove_ids.push(id);
  id = "#div_usuario_mensaje_"+index;
  $(id).remove();
}

function remove_usuario_email(index, id){
  usuarios_email_remove_ids.push(id);
  id = "#div_usuario_email_"+index;
  $(id).remove();
}