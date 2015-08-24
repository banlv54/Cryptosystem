// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  $(".import_data").click(function (){
    $("#myModal").show()
    $(".modal-backdrop.fade.in").show()
  })

  $("#myModal").hide()
  $(".modal-backdrop.fade.in").hide()
})
