import React from 'react';

export default class OperationBtn extends React.Component {
  constructor(props) {
    super(props);
    this.btnType = props.btnType;

    this.children = props.children;

    this.onClick = this.onClick.bind(this);
  }

  onClick(e) {
    this.props.handleOperation(e);
  }

  render() {
    return (
      <button type="button" data-type={this.btnType} onClick={this.onClick}>
        {this.children}
      </button>
    );
  }
}
