// @flow

import React from "react";

import Card from "../Card";
import CardStack from "../CardStack";
import { colours, fonts } from "../../lib/theme";
import type { PlayedCardType, CardListType } from "../../types/card";
import type { TricksType } from "../../types/tricks";

type Props = {
  pointsTotal: number,
  tricks: TricksType,
};

class Points extends React.Component<Props, State> {
  render() {
    const { tricks, pointsTotal } = this.props;

    return (
      <div className="points">
        <style jsx>{`
          .points {
            display: flex;
            flex: 1;
            flex-direction: column;
          }
          .pointsTotal {
            font-family: ${fonts.postGrotesk};
            font-size: 14px;
            font-weight: 700;
            text-align: center;
            flex: 1;
            padding: 4px 16px 5px 16px;
            color: ${colours.white};
            border-color: ${colours.green};
          }
          .tricks {
            display: flex;
            justify-content: center;
          }
          .trickContainer {
            margin-left: 2px;
            margin-right: 2px;
          }
        `}</style>
        <div className="pointsTotal">{pointsTotal}</div>
        <div className="tricks">
          {tricks.map((trick, i) => (
            <div className="trickContainer">
              <CardStack key={i} cards={trick} />
            </div>
          ))}
        </div>
      </div>
    );
  }
}

export default Points;
