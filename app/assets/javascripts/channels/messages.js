App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    $("#message_body").val('');

    return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return '<li><div class="alert alert-info" role="alert"><b>'+ data.user +'</b>: ' + data.message + '</div></li>';
  }
});