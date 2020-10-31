import { DOMNodeCollection } from './dom_node_collection';

window.$1 = function (obj) {
  const nodes = document.querySelectorAll(obj);
  if (nodes.length === 1 && nodes[0] instanceof HTMLElement) {
    return new DOMNodeCollection([nodes[0]]);
  }
  return new DOMNodeCollection([...document.querySelectorAll(obj)]);
};

$(function () {
  // const html = $('h1').html();
  // console.log(html);

  // const html2 = $1('h1').html();
  // console.log(html2);

  // const html3 = $('h1').html('changed');
  // console.log(html3);

  // const html4 = $1('h1').html('changedAgain');
  // console.log(html4);

  // $1('li').empty();

  $1('ul li:first-of-type').append($1('p'));
  // $1('ul li').append($1('p'));

  const children = $1('ul').children();
  // $1('ul li:first-of-type').append($1(['p']));
});
