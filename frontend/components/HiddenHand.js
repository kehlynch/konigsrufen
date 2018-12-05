// @flow

import React from "react";

import Card from "./Card";
import type { CardListType } from "../types/card";
import type { HandType } from "../types/hand";

type Props = {
  hand: HandType,
  position: string
};

class HiddenHand extends React.Component<Props> {
  render() {
    const { hand, position } = this.props;

    const { trumps, spades, hearts, clubs, diamonds } = hand;
    const cards: CardListType = [
      trumps,
      spades,
      hearts,
      clubs,
      diamonds
    ].reduce(function(prev, curr) {
      return prev.concat(curr);
    });

    return (
      <div className={`hand ${position}`}>
        <style jsx>{`
          .hand {
            display: flex;
          }
          .hand.n {
            margin-left: 25px;
            align-items: flex-end;
            flex-direction: row-reverse;
            margin-left: 25px;
          }
          .hand.e,
          .hand.w {
            margin-top: 75px;
          }
          .hand.e {
            margin-left: 20px;
            flex-direction: column-reverse;
          }
          .hand.w {
            margin-right: 20px;
            flex-direction: column;
            align-items: flex-end;
          }
          .cardContainer.n {
            margin-left: -25px;
          }
          .cardContainer.e {
            transform: rotate(90deg);
          }
          .cardContainer.w {
            transform: rotate(-90deg);
          }
          .cardContainer.e,
          .cardContainer.w {
            margin-top: -75px;
          }
        `}</style>
        {cards.map(card => (
          <div className={`cardContainer ${position}`} key={card.slug}>
            <Card key={card.slug} card={card} position={position} hidden />
          </div>
        ))}
      </div>
    );
  }
}

export default HiddenHand;
