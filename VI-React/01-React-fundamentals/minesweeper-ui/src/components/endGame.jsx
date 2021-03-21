import React from 'react';
export function endGameBox(props) {
  return (
    <div className="modal-screen">
      <div className="modal-content">
        <div className="modal-inner-content">
          <p>{props.endGameText}</p>
          <button className="btn" onClick={props.restartGame}>
            <strong>Play Again!</strong>
          </button>
        </div>
      </div>
    </div>
  );
}
