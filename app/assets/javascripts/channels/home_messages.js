App.home_messages = App.cable.subscriptions.create('HomeMessagesChannel', {  
  received: function(data) {
    return $('#last-messages').prepend(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return '<li class="list-group-item"><b>'+ data.user +'</b>: ' + data.message + '</li>';
  }
});