// @flow

import React from "react";

import Tricks from "./Tricks";
import { colours } from "../../lib/theme";

type Props = {
  game: GameType;
};

class Board extends React.Component<State> {
  render() {
    const { game } = this.props;
    const { points, talon, tricks } = game;

    return (
      <div className="board">
        <style jsx>{`
          .board {
            background: ${colours.green};
            border-radius: 10px;
            width: 50vh;
            height: 50vh;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
          }
        `}</style>
        {false && talon.map(card => <Card card={card} />)}
        <Tricks tricks={tricks} points={points} gameId={game.id} />
      </div>
    );
  }
}

export default Board;
