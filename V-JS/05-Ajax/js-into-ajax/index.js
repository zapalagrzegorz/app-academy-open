console.log('Hello from the JavaScript console!');

// Your AJAX request here
function printWeather(resp) {
  console.log(resp.weather[0].main);
}

$.ajax({
  url:
    'http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=bcb83c4b54aee8418983c2aff3073b3b',
  method: 'GET',
  success: printWeather,
});
// Add another console log here, outside your AJAX request
console.log('Right after AJAX!');
