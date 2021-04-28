import React from 'react';
import ReactDOM from 'react-dom';
import { Game } from './components/game';
import 'what-input';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Game />, document.getElementById('root'));
});
