document.addEventListener('DOMContentLoaded', () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const ul = e.currentTarget.id;
    const li = e.target;
    if (li.closest(`#${ul}`)) {
      li.classList.toggle('visited');
    }
    // if (li.className === 'visited') {
    //   li.className = '';
    // } else {
    //   li.className = 'visited';
    // }
  };

  document.querySelector('#restaurants').addEventListener('click', toggleLi);

  // adding SF places as list items
  const form = document.querySelector('.list-container form');
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    const restaurants = document.querySelector('#restaurants');
    const textInput = form.querySelector('.favorite-input');
    const text = textInput.value;

    const li = document.createElement('li');

    li.textContent = text;
    restaurants.appendChild(li);

    textInput.textContent = '';
  });

  // adding new photos
  const photoContainer = document.querySelector('.photo-form-container');

  document.querySelector('.photo-show-button').addEventListener('click', () => {
    photoContainer.classList.toggle('hidden');
  });

  // --- your code here!
  const photoForm = photoContainer.querySelector('form');
  photoForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const dogPhotos = document.querySelector('.dog-photos');
    const textInput = photoForm.querySelector('.photo-url-input');
    const src = textInput.value;

    const li = document.createElement('li');
    const img = document.createElement('img');
    img.setAttribute('src', src);
    li.appendChild(img);

    dogPhotos.appendChild(li);
  });
});
