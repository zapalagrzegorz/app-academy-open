import React from 'react';
export class Tabs extends React.Component {
  constructor(props) {
    super(props);

    this.state = { activeTabIdx: 0 };

    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(e) {
    e.preventDefault();
    this.setState({ activeTabIdx: e.target.dataset.index });
  }

  render() {
    const activeTabIdx = this.state.activeTabIdx;
    const tabs = this.props.tabs;
    const tabsBtns = tabs.map((tab, index) => (
      <li key={tab.title}>
        <button
          onClick={this.handleClick}
          data-index={index}
          className={index == activeTabIdx ? 'active' : ''}
        >
          {tab.title}
        </button>
      </li>
    ));

    return (
      <div className="tabs">
        <ul className="flex-container">{tabsBtns}</ul>
        <article>{tabs[this.state.activeTabIdx].content}</article>
      </div>
    );
  }
}
