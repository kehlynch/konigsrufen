// @flow

import React from "react";

import { colours, fonts } from "../lib/theme";
import type { ScoresType } from "../types/scores";

type Props = {
  scores: ScoresType
};

class Score extends React.Component<Props> {
  render() {
    const { scores } = this.props;
    return (
      <div className="score">
        <style jsx>{`
          .score {
            display: flex;
            flex-direction: row;
          }
          .playerScore {
            font-family: ${fonts.postGrotesk};
            font-size: 14px;
            font-weight: 700;
            text-align: center;
            flex: 1;
            padding: 4px 16px 5px 16px;
            color: ${colours.white};
            border-color: ${colours.green};
          }
        `}</style>
        <div className="playerScore">{scores.p1}</div>
        <div className="playerScore">{scores.p2}</div>
        <div className="playerScore">{scores.p3}</div>
        <div className="playerScore">{scores.p4}</div>
      </div>
    )
  }
}

export default Score

