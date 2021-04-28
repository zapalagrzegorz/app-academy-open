function draw() {
  var ctx = document.getElementById('mycanvas').getContext('2d');

  ctx.fillRect(0, 0, 150, 150); // Draw a rectangle with default settings
  ctx.save(); // Save the default state

  ctx.fillStyle = '#09F'; // Make changes to the settings
  ctx.fillRect(15, 15, 120, 120); // Draw a rectangle with new settings

  ctx.save(); // Save the current state
  ctx.fillStyle = '#FFF'; // Make changes to the settings
  ctx.globalAlpha = 0.5;
  ctx.fillRect(30, 30, 90, 90); // Draw a rectangle with new settings

  ctx.restore(); // Restore previous state
  // back to blus
  ctx.fillRect(45, 45, 60, 60); // Draw a rectangle with restored settings

  // back to black
  ctx.restore(); // Restore original state
  ctx.fillRect(60, 60, 30, 30); // Draw a rectangle with restored settings
}

function translate() {
  var ctx = document.getElementById('mycanvas').getContext('2d');
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      ctx.save();
      ctx.fillStyle = 'rgb(' + 51 * i + ', ' + (255 - 51 * i) + ', 255)';
      ctx.translate(10 + j * 50, 10 + i * 50);
      ctx.fillRect(0, 0, 25, 25);
      ctx.restore();
    }
  }
}

function rotate() {
  var ctx = document.getElementById('mycanvas').getContext('2d');

  // left rectangles, rotate from canvas origin
  ctx.save();
  // blue rect
  ctx.fillStyle = '#0095DD';
  ctx.fillRect(30, 30, 100, 100);

  ctx.rotate((Math.PI / 180) * 25);
  // // grey rect
  ctx.fillStyle = '#4D4E53';
  ctx.fillRect(30, 30, 100, 100);
  ctx.restore();

  // // right rectangles, rotate from rectangle center
  // // draw blue rect
  ctx.fillStyle = '#0095DD';
  ctx.fillRect(150, 30, 100, 100);

  ctx.translate(200, 80); // translate to rectangle center
  // x = x + 0.5 * width
  // y = y + 0.5 * height
  ctx.rotate((Math.PI / 180) * 25); // rotate
  ctx.translate(-200, -80); // translate back

  // // draw grey rect
  ctx.fillStyle = '#4D4E53';
  ctx.fillRect(0, 0, 100, 100);
}

function scale() {
  var ctx = document.getElementById('mycanvas').getContext('2d');

  // draw a simple rectangle, but scale it.
  ctx.save();
  ctx.scale(10, 3);
  // ctx.fillRect(1, 10, 10, 10);
  ctx.restore();
  
  // mirror horizontally
  ctx.scale(-1, 1);
  ctx.font = '48px serif';
  ctx.fillText('MDN', -135, 50);
}

document.addEventListener('DOMContentLoaded', function () {
  // draw();
  const canvas = document.getElementById('mycanvas');
  canvas.width = 500;
  canvas.height = 500;
  scale();
  // const ctx = canvas.getContext('2d');

  // // rectangle
  // ctx.fillStyle = 'blue';
  // ctx.fillRect(15, 15, 40, 50);

  // // circle

  // ctx.beginPath();
  // ctx.strokeStyle = 'brown';
  // // ctx.moveTo(200, 200);
  // ctx.lineWidth = 3;
  // ctx.arc(200, 200, 50, 0, 2 * Math.PI);
  // // ctx.lineTo(200, 20);
  // ctx.stroke();
  // ctx.fillStyle = 'green';
  // ctx.fill();

  // ctx.fillRect(25, 25, 100, 100);
  // ctx.clearRect(45, 45, 60, 60);
  // ctx.strokeRect(50, 50, 50, 50);
  // ctx.strokeRect(55, 55, 40, 40);
  // ctx.strokeRect(60, 60, 30, 30);
  // ctx.strokeRect(65, 65, 20, 20);
  // ctx.strokeRect(70, 70, 10, 10);
});
