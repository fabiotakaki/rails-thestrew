//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();  

App.conversations = App.cable.subscriptions.create('ConversationsChannel', {  
  received: function(data) {
    if(!data.exist)
      return $('#conversations').append(this.renderConversation(data));
    else return;
  },

  renderConversation: function(data) {
    return '<a href="/conversations/'+data.conversation+'" class="list-group-item list-group-item-action"><b>['+data.role+'] '+data.user+'</b></a>';
  }
});