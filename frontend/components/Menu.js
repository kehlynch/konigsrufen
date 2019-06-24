// @flow

import React from "react";
import Router from "next/router";

import Button from "./Button";
import { createGame } from "../lib/game";
import type { GameType } from "../types/game";

type Props = {
  game: GameType,
  message: ?string,
  setGame: Function
};

class Menu extends React.Component<Props> {
  // TODO repeated code from pages/login.js
  createGame = async () => {
    const { setGame, game } = this.props;
    const newGame = await createGame(null, null, game.id);
    setGame(newGame);
  };

  render() {
    const { message } = this.props;

    return (
      <div className="menu">
        <style jsx>{`
          .menu {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
          }
          .message {
            font-size: 24px;
            font-weight: 700;
          }
        `}</style>
        <div className="submitButton">
          <Button
            text="🧙‍♀️ New Game"
            onClick={this.createGame}
            type="new"
          />
        </div>
      </div>
    );
  }
}

export default Menu;
