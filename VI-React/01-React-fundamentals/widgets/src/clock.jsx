import React from 'react';
export class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      date: new Date(),
    };
    this.tick = this.tick.bind(this);
  }

  tick() {
    this.setState({ date: new Date() });
  }
  componentDidMount() {
    this.timerID = setInterval(this.tick, 1000);
  }
  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  render() {
    const { date } = this.state;
    return (
      <div className="clock">
        <p className="flex">
          <span>Time</span>
          <time>{date.toLocaleTimeString()}</time>
        </p>
        <p>
          <span>Date</span>
          <time>{date.toLocaleDateString()}</time>
        </p>
      </div>
    );
  }
}
