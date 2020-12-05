import React from 'react';

export class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      firstValue: 0,
      secondValue: 0,
      result: 0,
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleOperation = this.handleOperation.bind(this);
  }

  handleChange(e) {
    this.setState({
      [e.target.name]: parseFloat(e.target.value),
    });
  }

  handleOperation(e) {
    // alert('A name was submitted: ' + this.state.value);
    e.preventDefault();
    const operation = e.target.dataset.type;
    switch (operation) {
      case 'addition':
        this.setState({
          result: this.state.firstValue + this.state.secondValue,
        });
        break;
      case 'substract':
        this.setState({
          result: this.state.firstValue - this.state.secondValue,
        });
        break;
      case 'multiply':
        this.setState({
          result: this.state.firstValue * this.state.secondValue,
        });
        break;
      case 'divide':
        this.setState({
          result: this.state.firstValue / this.state.secondValue,
        });
        break;
      default:
        break;
    }
  }

  render() {
    return (
      <div>
        <div className="result">{this.state.result}</div>
        <div className="inputs">
          <input
            type="number"
            id="first-value"
            name="firstValue"
            value={this.state.firstValue}
            onChange={this.handleChange}
          />
          <input
            type="number"
            id="second-value"
            name="secondValue"
            value={this.state.secondValue}
            onChange={this.handleChange}
          />

          <input type="reset" value="Clear" />
        </div>
        <div className="btns">
          <button
            type="button"
            data-type="addition"
            onClick={this.handleOperation}
          >
            +
          </button>
          <button
            type="button"
            data-type="substract"
            onClick={this.handleOperation}
          >
            -
          </button>
          <button
            type="button"
            data-type="multiply"
            onClick={this.handleOperation}
          >
            *
          </button>
          <button
            type="button"
            data-type="divide"
            onClick={this.handleOperation}
          >
            /
          </button>
        </div>
      </div>
    );
  }
}
