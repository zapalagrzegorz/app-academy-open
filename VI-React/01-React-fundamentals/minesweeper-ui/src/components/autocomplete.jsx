import React from 'react';
import { CSSTransitionGroup } from 'react-transition-group';

export class Autocomplete extends React.Component {
  constructor(props) {
    super(props);

    this.state = { inputText: '' };

    this.handleChange = this.handleChange.bind(this);
    this.handleItemClick = this.handleItemClick.bind(this);
  }

  handleChange(e) {
    const value = e.target.value;
    this.setState({
      [e.target.name]: value,
    });
  }

  handleItemClick(e) {
    e.preventDefault();

    this.setState({
      inputText: e.target.innerText,
    });
  }

  render() {
    const inputVal = this.state.inputText.toLowerCase();

    // solucja wydziela this.props.people.filter do osobnej funkcji - matches
    // jeśli filtr jest 0 length, zwróć wszystko
    // jeśli wyników jest 0 , zwróć komunikat

    // includes nie działa gorzej - zwraca true dla pustego stringa
    const people = this.props.people
      .filter((name) => name.toLowerCase().includes(inputVal))
      .map((name) => (
        <li key={name} onClick={this.handleItemClick}>
          {name}
        </li>
      ));

    return (
      <div className="autocomplete flex-child-grow">
        <input
          type="text"
          name="inputText"
          onChange={this.handleChange}
          value={this.state.inputText}
          placeholder="Search..."
        />
        <ul>
          <CSSTransitionGroup
            transitionName="auto"
            transitionEnterTimeout={500}
            transitionLeaveTimeout={500}
          >
            {people}
          </CSSTransitionGroup>
        </ul>
      </div>
    );
  }
}
