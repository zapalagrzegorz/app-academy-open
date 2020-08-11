// myDebounce
// określa czas bezwywołania podstawowej funkcji
// jeżeli funkcja będzie wywołana w podanym okresie ponownie, anuluje dotychczasowe
// wywołanie i zakolejkuje ostatnie do wywołania w danym oknie czasowym
Function.prototype.myDebounce = function (interval) {
  let timeout;
  return (...args) => {
    // declare a function that sets timeout to null and invokes this with args
    const fnCall = () => {
      timeout = null;
      this(...args);
    }

    clearTimeout(timeout);
    timeout = setTimeout(fnCall, interval);
  };
};

class SearchBar {
  constructor() {
    this.query = "";

    this.type = this.type.bind(this);
    this.search = this.search.bind(this);
  }

  type(letter) {
    this.query += letter;
    this.search();
  }

  search() {
    console.log(`searching for ${this.query}`);
  }
}

const searchBar = new SearchBar();

searchBar.search = searchBar.search.myDebounce(500);

const queryForHelloWorld = () => {
  searchBar.type("h");
  searchBar.type("e");
  searchBar.type("l");
  searchBar.type("l");
  searchBar.type("o");
  searchBar.type(" ");
  searchBar.type("w");
  searchBar.type("o");
  searchBar.type("r");
  searchBar.type("l");
  searchBar.type("d");
};

queryForHelloWorld();