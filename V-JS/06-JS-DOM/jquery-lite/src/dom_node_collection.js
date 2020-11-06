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
  // parent
  // Return a DOMNodeCollection of the parents of each of the nodes
  parent() {
    const parents = this.arr.reduce((acc, curr) => {
      if (!acc.includes(curr.parentElement)) {
        acc.push(curr.parentElement);
      }
      return acc;
    }, []);

    return new DOMNodeCollection(parents);
  }

  // find
  //     Returns a DOMNodeCollection of all the nodes matching the selector passed in as an argument that are descendants of the nodes. This might come in handy.
  find(selector) {
    const foundEls = this.arr.reduce((acc, curr) => {
      const foundElements = curr.querySelectorAll(selector);
      const foundElementsArr = Array.from(foundElements);
      const foundElementsSingle = foundElementsArr.filter((foundElement) => {
        if (!acc.includes(foundElement)) return true;
      });

      return acc.concat(foundElementsSingle);
    }, []);
    return new DOMNodeCollection(foundEls);
  }

  remove() {
    this.arr.forEach((element) => {
      element.remove();
    });
  }

  on(method, cb) {
    this.arr.forEach((element) => {
      element.addEventListener(method, cb);
      element.callbacks = element.callbacks || {};
      element.callbacks[method] = element.callbacks[method] || [];
      element.callbacks[method].push(cb);
    });
  }

  off(method) {
    this.arr.forEach((element) => {
      element.callbacks;
      element.callbacks[method];
      element.callbacks[method].forEach((callback) => {
        element.removeEventListener(method, callback);
      });
      element.callbacks[method] = [];
    });
  }
}
