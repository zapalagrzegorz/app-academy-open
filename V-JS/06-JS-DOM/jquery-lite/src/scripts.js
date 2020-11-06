import { DOMNodeCollection } from './dom_node_collection';

document.addEventListener('DOMContentLoaded', () => {
  console.log('DOM Content Loaded');
});

window.$1 = function (obj) {
  if (typeof obj === 'function') {
    window.$1.ready = [] || window.$1.ready;

    window.$1.ready.push(obj);

    window.$1.ready.forEach((fun) => {
      document.addEventListener('DOMContentLoaded', fun);
    });
    // For this phase of the project we will be adding this functionality to our core $l function. We will need to change the code inside of our main function, the one we used to create an instance of DomNodeCollection.
    // Change the $l function so that if it receives a function, it will push that function into an array (queue) of functions to be executed when the document is ready.
    //     If the document is already ready, trigger the function immediately
  } else {
    const nodes = document.querySelectorAll(obj);
    if (nodes.length === 1 && nodes[0] instanceof HTMLElement) {
      return new DOMNodeCollection([nodes[0]]);
    }
    return new DOMNodeCollection([...document.querySelectorAll(obj)]);
  }
};

window.$1.extend = (...objects) => {
  if (objects.length > 1) {
    objects[0] = Object.assign(...objects);
  }
};

window.$1.ajax = async (conf) => {
  const options = {
    method: conf.type,
  };

  const response = await fetch(conf.url, options);
  if (!response.ok) {
    conf.error();
    return;
  }
  const jsonResponse = await response.json();
  conf.success(jsonResponse);
};

$1(function () {
  // const html = $('h1').html();
  // console.log(html);
  // const html2 = $1('h1').html();
  // console.log(html2);
  // const html3 = $('h1').html('changed');
  // console.log(html3);
  // const html4 = $1('h1').html('changedAgain');
  // console.log(html4);
  // $1('li').empty();
  // $1('ul li:first-of-type').append($1('p'));
  // $1('ul li').append($1('p'));
  // const children = $1('ul').children();
  // parent;
  // $1(() => {
  //   $1('li').remove();
  // });
  // const foundLi = li.find('li');
  // foundLi;
  // $1('ul li:first-of-type').append($1(['p']));
  // $('li').on('mouseover', () => {
  //   console.log(this);
  // });
  // $('li').on('mouseover', () => {
  //   console.log('check');
  // });
  // $1('h1').on('mouseover', () => {
  //   console.log(this);
  // });
  // $1('h1').on('mouseover', () => {
  //   console.log('check');
  // });
  // $1('h1').off('mouseover');
  // });
  // const objA = { a: 'a', b: 'a', c: 'a' };
  // const objB = { b: 'b', c: 'b' };
  // const objC = { c: 'c' };
  // $1.extend(objA, objB, objC); //=> {a: 'a', b: 'b', c: 'c'}
  // objA;

  $1.ajax({
    type: 'GET',
    url:
      'http://api.openweathermap.org/data/2.5/weather1?q=London,uk&appid=bcb83c4b54aee8418983c2aff3073b3b',
    success(data) {
      console.log('We have your weather!');
      console.log(data);
    },
    error() {
      console.error('An error occurred.');
    },
  });
});
