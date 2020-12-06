import React from 'react';
import OperationBtn from './operation-btn';
export class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      firstValue: '',
      secondValue: '',
      result: 0,
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleOperation = this.handleOperation.bind(this);
    this.handleClear = this.handleClear.bind(this);
  }

  handleChange(e) {
    const value = e.target.value;
    if (value != '') {
      this.setState({
        [e.target.name]: parseFloat(value),
      });
    } else {
      this.setState({
        [e.target.name]: value,
      });
    }
  }

  handleClear(e) {
    e.preventDefault();
    this.setState({
      firstValue: '',
      secondValue: '',
    });
  }

  handleOperation(e) {
    // alert('A name was submitted: ' + value);
    e.preventDefault();
    const operation = e.target.dataset.type;
    const { firstValue, secondValue } = this.state;
    switch (operation) {
      case 'addition':
        this.setState({
          result: firstValue + secondValue,
        });
        break;
      case 'substract':
        this.setState({
          result: firstValue - secondValue,
        });
        break;
      case 'multiply':
        this.setState({
          result: firstValue * secondValue,
        });
        break;
      case 'divide':
        this.setState({
          result: firstValue / secondValue,
        });
        break;
      default:
        break;
    }
  }

  render() {
    const { result, firstValue, secondValue } = this.state;
    return (
      <div>
        <div className="result">{result}</div>
        <div className="inputs">
          <input
            type="number"
            id="first-value"
            name="firstValue"
            value={firstValue}
            onChange={this.handleChange}
          />
          <input
            type="number"
            id="second-value"
            name="secondValue"
            value={secondValue}
            onChange={this.handleChange}
          />

          <input type="reset" value="Clear" onClick={this.handleClear} />
        </div>
        <div className="btns">
          <OperationBtn
            btnType="addition"
            handleOperation={this.handleOperation}
          >
            +
          </OperationBtn>
          <OperationBtn
            btnType="substract"
            handleOperation={this.handleOperation}
          >
            -
          </OperationBtn>
          <OperationBtn
            btnType="multiply"
            handleOperation={this.handleOperation}
          >
            *
          </OperationBtn>
          <OperationBtn btnType="divide" handleOperation={this.handleOperation}>
            /
          </OperationBtn>
        </div>
      </div>
    );
  }
}
