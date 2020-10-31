export class DOMNodeCollection {
  constructor(arr) {
    this.arr = arr;
  }

  html(htmlString) {
    if (!htmlString) {
      return this.arr[0].innerHTML;
    } else {
      this.arr.forEach((element) => {
        element.innerHTML = htmlString;
      });
    }
  }

  empty() {
    this.arr.forEach((element) => {
      element.innerHTML = '';
    });
  }
  append(appendElements) {
    // collection, an HTML element, or a string. Append the outerHTML of each element in the argument to the innerHTML of each element in the DOMNodeCollection. Don't worry about converting strings into HTML elements; just pass them straight through to the elements' innerHTML.
    this.arr.forEach((element) => {
      if (Array.isArray(appendElements)) {
        appendElements.forEach((appendedElement) => {
          element.append(appendedElement);
        });
      } else if (appendElements instanceof DOMNodeCollection) {
        appendElements.arr.forEach((appendedElement) => {
          element.append(appendedElement);
        });
      } else {
        element.append(appendElements);
      }
    });
  }

  children() {
    const children = [];
    this.arr.forEach((element) => {
      this._addChild(element, children);
    });

    return children;
  }
  _addChild(element, arr) {
    if (!element.children.length) {
      arr.push(element);
      return arr;
    } else {
      arr.push(element);
      Array.from(element.children).forEach((element) => {
        this._addChild(element, arr);
      });
    }
  }

  //   parent

  //     Return a DOMNodeCollection of the parents of each of the nodes

  // find

  //     Returns a DOMNodeCollection of all the nodes matching the selector passed in as an argument that are descendants of the nodes. This might come in handy.

  // remove

  //     This should remove the html of all the nodes in the array from the DOM
}
