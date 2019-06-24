// @flow

import React from "react";

import ScoreRow from "./ScoreRow";
import { colours, fonts } from "../lib/theme";

import type { ScoresListType } from "../types/scores";

type Props = {
  scores: ScoresListType
};

class ScoreBoard extends React.Component<Props> {
  render() {
    const { scoresList } = this.props;
    return (
      <div className="scoreBoard">
        <style jsx>{`
          .scoreBoard {
            display: flex;
            background: ${colours.teal};
            flex-direction: column;
            border-radius: 20px;
            border: solid 2px;
          }
          .headerContainer {
            display: flex;
            flex-direction: row;
          }
          .header {
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
        <div className="headerContainer">
          <div className="header">p1</div>
          <div className="header">p2</div>
          <div className="header">p3</div>
          <div className="header">p4</div>
        </div>
        {scoresList.map((scores, i) => <ScoreRow key={i} scores={scores} />)}
      </div>
    )
  }
}

export default ScoreBoard;
