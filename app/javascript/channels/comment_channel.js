import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `
        <p class="comment-warn">
          <strong>
            <a href>${data.user.nickname}</a>
            :
          </strong>
          ${data.content.text}
        </p>`;
    const comments = document.getElementById('comment-text-id');
    const newComment = document.getElementById('comment_text');
    console.log(comments);
    comments.insertAdjacentHTML('afterend', html);
    newComment.value='';
    document.getElementById("comment-btn-id").removeAttribute("disabled");
  }
});
