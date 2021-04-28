function MovingObject(options) {
  const { pos, vel, radius, color, game } = options;
  this.pos = pos;
  this.vel = vel;
  this.radius = radius;
  this.color = color;
  this.game = game;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.fillStyle = this.color;
  ctx.beginPath();

  ctx.arc(
    this.pos[0] - this.radius,
    this.pos[1] - this.radius,
    this.radius,
    0,
    2 * Math.PI,
    false
  );

  ctx.fill();
};

MovingObject.prototype.move = function () {
  if (this.game.isOutOfBounds(this)) {
    if (this.isWrappable) {
      this.pos = this.game.wrap(this.pos);
    } else {
      this.game.remove(this);
    }
  }

  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

MovingObject.prototype.isCollidedWith = function (otherObject) {
  const dist = Math.sqrt(
    (this.pos[0] - otherObject.pos[0]) ** 2 +
      (this.pos[1] - otherObject.pos[1]) ** 2
  );
  if (dist < this.radius * 2) {
    return true;
  }
};

MovingObject.prototype.collideWith = function () {};

MovingObject.prototype.isWrappable = true;

export default MovingObject;
