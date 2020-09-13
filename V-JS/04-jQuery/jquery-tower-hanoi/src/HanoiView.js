class HanoiView {
  constructor(game, $rootEl) {
    this.game = game;
    this.$rootEl = $rootEl;
    this.clickedTowerIdx = null;
    this.bindHandlers();
    this.setupTowers();
    this.render();
  }

  setupTowers() {
    // $('body').append($('<ul class="towers">'));

    // for (let i = 0; i < 3; i++) {
    //   $('.towers').append($('<li></li>'));
    // }

    const firstTower = $('.towers li:first');
    for (let i = 0; i < 3; i++) {
      firstTower.append(`<span class="ring ring${i + 1}"></span>`);
    }
  }

  render() {
    const ringContainers = $('.towers li');
    ringContainers.empty().removeClass('active');
    this.game.towers.map((rings, index) => {
      const HTMLrings = rings
        .map((ring) => $(`<span class="ring ring${ring}"></span>`))
        .reverse();
      ringContainers.eq(index).prepend(HTMLrings);
    });
  }

  bindHandlers() {
    this.$rootEl.on('click', 'li', (e) => {
      this.clickTower(e);
    });
  }

  clickTower(e) {
    const clickedTower = $(e.currentTarget);
    clickedTower.addClass('active');
    // jednak powinna być referencja do obiektu
    if (this.clickedTowerIdx === null) {
      this.clickedTowerIdx = clickedTower.data('pos');
      clickedTower.addClass('active');
    } else {
      this._secondClick(clickedTower);
    }
  }

  _secondClick(clickedTower) {
    if (this.game.move(this.clickedTowerIdx, clickedTower.data('pos'))) {
      this.render();
      if (this.game.isWon()) {
        $('body').append("<h1>You've made it</h1>");
        this.$rootEl.off('click');
      }
    } else {
      alert('invalidMove');
    }
    this.clickedTowerIdx = null;
    $('.towers li').removeClass('active');
  }
}

module.exports = HanoiView;
