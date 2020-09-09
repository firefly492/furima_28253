// if (document.URL.match( "items/new" ) || document.URL.match( "items/12/edit" )) {
  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {

      const imageElement = document.createElement('div');
      const blobImage = document.createElement('img');
      blobImage.className = 'image-li'
      blobImage.setAttribute('src', blob);
      imageElement.appendChild(blobImage);
      imageList.appendChild(imageElement);
    };

    document.getElementById('item-image').addEventListener('change', function(e){

      const imageContent = document.querySelector('image-list');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
// }