export class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    window.addEventListener('hashchange', this.render.bind(this));
    this.render();
  }
  render() {
    const component = this.activeRoute();

    this.node.innerHTML = '';
    if (component) {
      this.node.appendChild(component.render());
    }
  }
  activeRoute() {
    const route = window.location.hash.slice(1);
    return this.routes[route];
  }
}
