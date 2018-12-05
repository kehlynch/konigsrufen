// @flow

import React from "react";

import Card from "./Card";
import { colours } from "../lib/theme";
import type { CardListType } from "../types/card";
import type { TrickType } from "../types/trick";

type Props = {
  talon: CardListType,
  trick: TrickType
};

class Hand extends React.Component<Props> {
  render() {
    const { talon, trick } = this.props;
    return (
      <div className="board">
        <style jsx>{`
          .board {
            background: ${colours.green};
            border-radius: 10px;
            margin: 30px;
            width: 40vw;
            height: 40vw;
            display: flex;
            flex-direction: column;
          }
          .cardContainer {
            flex: 1;
            // width: 50px;
            // height: 93px;
          }
          .p4 {
            display: flex;
            flex-direction: row;
            justify-content: center;
          }
          .p23 {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
          }
          .p3 {
            flex-direction: row;
            flex: 1;
          }
          .p2 {
            flex-direction: row;
            flex: 1;
          }
          .p1 {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: flex-end;
          }
        `}</style>
        {false && talon.map(card => <Card card={card} position="talon" />)}
        <div className="cardContainer p4">
          {trick.p4 && (
            <Card card={trick.p4} position="n" />
          )}
        </div>
        <div className="cardContainer p23">
          <div className="p3">
            {trick.p3 && (
              <Card card={trick.p3} position="w" />
            )}
          </div>
          <div className="cardContainer p2">
            {trick.p2 && (
              <Card card={trick.p2} position="e" />
            )}
          </div>
        </div>
        <div className="cardContainer p1">
          {trick.p1 && (
            <Card card={trick.p1} position="s" />
          )}
        </div>
      </div>
    );
  }
}

export default Hand;
