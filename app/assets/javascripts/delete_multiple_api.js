var superlist = {};

superlist.setupDeleteMultipleHandlers = function() {

  $(document).ready(function(){

    $("body").on("click", "[data-delete-multiple-button]", function(event) {
      event.preventDefault();
      var todosId = $('[name="todos[]"]:checked').map(function(){return parseInt(this.value);}).get();
      var userId = $('meta[name="user_name"]').attr("content").split(' ').join('-').toLowerCase();
      var userToken = $('meta[name="user_auth"]').attr("content");
      var data = {"todos": todosId};
      if (confirm("Are you sure you want to delete this ?")) {
        $.ajax({
          type : "DELETE",
          url : "/api/users/"+userId+"/todos/destroy_multiple",
          data: JSON.stringify(data),
          datatype : "application/json",
          contentType: "application/json; charset=utf-8",
          beforeSend: function (xhr) {
            xhr.setRequestHeader ("Authorization", userToken);
          },
          success : function() {
            $.each(todosId, function(index, value) {
              $("#todo-"+value).fadeOut(600);
            });
            
          },
          error : function(error) {
            alert('Error in deleting the item'); 
          }
        });
      };
    });
  });
  
};
superlist.setupDeleteMultipleHandlers();