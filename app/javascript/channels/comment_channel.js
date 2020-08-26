import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // received(data) {
  //   const html = `text_field${data.content.text}`;
  //   console.log(data)
  //   const comments = document.getElementById('comment-text-id');
  //   const newComment = document.getElementById('comments_text');
  //   comments.insertAdjacentHTML('afterbegin', html);
  //   newComment.value='';

  received(data) {
    const html = `text_field${data.content.text}`;
    console.log(data)
    const comments = document.getElementById('comment-text-id');
    const newComment = document.getElementById('comments_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value='';
  }
});
