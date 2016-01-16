
$(function()
  {
  $("#enableinfoupdate").click(function(){
    $("#user_name").removeAttr("readonly");
    $("#user_cellphone").removeAttr("readonly");
    $("#user_creditcard_num").removeAttr("readonly");
    $("#user_id_card").removeAttr("readonly");
    $("#user_address").removeAttr("readonly");
    $("#user_email").removeAttr("readonly");
    }
  )

  $("#disableinfoupdate").click(function(){
    $("#user_name").attr("readonly","readonly");
    $("#user_cellphone").attr("readonly","readonly");
    $("#user_creditcard_num").attr("readonly","readonly");
    $("#user_id_card").attr("readonly","readonly");
    $("#user_address").attr("readonly","readonly");
    $("#user_email").attr("readonly","readonly");
    } 
  )
  }
)