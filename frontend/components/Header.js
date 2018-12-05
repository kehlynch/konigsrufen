// @flow

import React from "react";

import type { GameType } from "../types/game";

type Props = {
  game: GameType,
  message: ?string
};

class Header extends React.Component<Props> {
  render() {
    const { message } = this.props;

    return (
      <div>
        <style jsx>{`
          .root {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
          }
          .message {
            font-size: 24px;
            font-weight: 700;
          }
        `}</style>
        <div className="root">
          <div className="message">{message}</div>
        </div>
      </div>
    );
  }
}

export default Header;
